//
//  BurgerMenuViewController.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/7/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "BurgerMenuViewController.h"
#import "MenuTableViewController.h"
#import "SearchViewController.h"
#import "MyQuestionsViewController.h"
#import "ProfileViewController.h"

CGFloat const kBurgerMenuOpenScreenDivider = 100.0;
CGFloat const kBurgerMenuOpenScreenMultiplier = 0.8;
CGFloat const kBurgerButtonWidth = 40.0;
CGFloat const kBurgerButtonHeight = 40.0;
NSTimeInterval const kBurgerMenuAnimationTime = 0.4;

@interface BurgerMenuViewController () <UITableViewDelegate>

@property (strong, nonatomic) MenuTableViewController *menuViewController;
@property (strong, nonatomic) SearchViewController *searchViewController;
@property (strong, nonatomic) MyQuestionsViewController *questionsViewController;
@property (strong, nonatomic) ProfileViewController *profileViewController;
@property (strong, nonatomic) UIViewController *topViewController;
@property (strong, nonatomic) UIButton *burgerMenuButton;
@property (strong, nonatomic) UIPanGestureRecognizer *panRecognizer;
@property (strong, nonatomic) NSArray *viewControllers;

@end

@implementation BurgerMenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpViewControllers];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)setUpViewControllers {
    [self setUpMenuViewController];
    [self setUpSearchViewController];
    [self setUpMyQuestionsViewController];
    [self setUpProfileViewController];
    self.viewControllers = @[self.searchViewController, self.questionsViewController, self.profileViewController];
    self.topViewController = self.searchViewController;
    
    [self setUpMenuButton];
    [self setUpPanGestureRecognizer];
}

- (void)setUpMenuViewController {
    MenuTableViewController *menuVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MenuTableViewController"];
    menuVC.tableView.delegate = self;
    [self addChildViewController:menuVC];
    menuVC.view.frame = self.view.frame;
    [self.view addSubview:menuVC.view];
    [menuVC didMoveToParentViewController:self];
    self.menuViewController = menuVC;
}

- (void)setUpSearchViewController {
    SearchViewController *searchVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchViewController"];
    [self addChildViewController:searchVC];
    searchVC.view.frame = self.view.frame;
    [self.view addSubview:searchVC.view];
    [searchVC didMoveToParentViewController:self];
    self.searchViewController = searchVC;
}

- (void)setUpMyQuestionsViewController {
    MyQuestionsViewController *myQuestionsVC = [self.storyboard instantiateViewControllerWithIdentifier:@"MyQuestionsViewController"];
    [self addChildViewController:myQuestionsVC];
    myQuestionsVC.view.frame = self.view.frame;
    [self.view addSubview:myQuestionsVC.view];
    [myQuestionsVC didMoveToParentViewController:self];
    self.questionsViewController = myQuestionsVC;
}

- (void)setUpProfileViewController {
    ProfileViewController *profileVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self addChildViewController:profileVC];
    profileVC.view.frame = self.view.frame;
    [self.view addSubview:profileVC.view];
    [profileVC didMoveToParentViewController:self];
    self.profileViewController = profileVC;
}

- (void)setUpMenuButton {
    UIButton *menuButton = [[UIButton alloc] initWithFrame:CGRectMake(10.0, 10.0, kBurgerButtonWidth, kBurgerButtonHeight)];
    menuButton.backgroundColor = [UIColor whiteColor];
    [menuButton setImage:[UIImage imageNamed:@"guy.jpeg"] forState:UIControlStateNormal];
    menuButton.layer.cornerRadius = 5.0;
    menuButton.contentMode = UIViewContentModeScaleAspectFit;
    [self.topViewController.view addSubview:menuButton];
    [menuButton addTarget:self action:@selector(burgerMenuButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.burgerMenuButton = menuButton;
}

- (void)burgerMenuButtonPressed:(UIButton *)sender {
    [UIView animateWithDuration:kBurgerMenuAnimationTime animations:^{
        self.topViewController.view.center = CGPointMake(self.view.center.x * kBurgerMenuOpenScreenMultiplier, self.view.center.y);
    } completion:^(BOOL finished) {
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
        [self.topViewController.view addGestureRecognizer:tapRecognizer];
        sender.userInteractionEnabled = NO;
    }];
}

- (void)tapToCloseMenu:(UITapGestureRecognizer *)sender {
    [self.topViewController.view removeGestureRecognizer:sender];
    [UIView animateWithDuration:kBurgerMenuAnimationTime animations:^{
        self.topViewController.view.center = self.view.center;
    } completion:^(BOOL finished) {
        self.burgerMenuButton.userInteractionEnabled = YES;
    }];
}

- (void)setUpPanGestureRecognizer {
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pannedScreen:)];
    [self.topViewController.view addGestureRecognizer:self.panRecognizer];
}

- (void)pannedScreen:(UIPanGestureRecognizer *)sender {
    CGPoint velocity = [sender velocityInView:self.topViewController.view];
    CGPoint translation = [sender translationInView:self.topViewController.view];
    
    if (sender.state == UIGestureRecognizerStateChanged) {
        if (velocity.x > 0) {
            self.topViewController.view.center = CGPointMake(self.topViewController.view.center.x + translation.x, self.topViewController.view.center.y);
            [sender setTranslation:CGPointZero inView:self.topViewController.view];
        }
    }
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (self.topViewController.view.frame.origin.x > self.topViewController.view.frame.size.width / kBurgerMenuOpenScreenDivider) {
            [UIView animateWithDuration:kBurgerMenuAnimationTime animations:^{
                self.topViewController.view.center = CGPointMake(self.view.center.x * kBurgerMenuOpenScreenMultiplier, self.view.center.y);
            } completion:^(BOOL finished) {
                UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapToCloseMenu:)];
                [self.topViewController.view addGestureRecognizer:tapRecognizer];
                self.burgerMenuButton.userInteractionEnabled = NO;
            }];
        } else {
            [UIView animateWithDuration:kBurgerMenuAnimationTime animations:^{
                self.topViewController.view.center = self.view.center;
            } completion:^(BOOL finished) {
                //
            }];
        }
    }
}

- (void)switchToViewController:(UIViewController *)viewController {
    [UIView animateWithDuration:kBurgerMenuAnimationTime animations:^{
        self.topViewController.view.frame = CGRectMake(self.view.frame.size.width, self.view.frame.origin.y, self.topViewController.view.frame.size.width, self.topViewController.view.frame.size.height);
    } completion:^(BOOL finished) {
        CGRect oldFrame = self.topViewController.view.frame;
        [self.topViewController.view removeFromSuperview];
        [self.topViewController removeFromParentViewController];
        
        viewController.view.frame = oldFrame;
        [self addChildViewController:viewController];
        [self.view addSubview:viewController.view];
        [viewController didMoveToParentViewController:self];
        
        [self.burgerMenuButton removeFromSuperview];
        [viewController.view addSubview:self.burgerMenuButton];
        
        [UIView animateWithDuration:kBurgerMenuAnimationTime animations:^{
            viewController.view.center = self.view.center;
        } completion:^(BOOL finished) {
            [viewController.view addGestureRecognizer:self.panRecognizer];
        }];
    }];
}

@end
