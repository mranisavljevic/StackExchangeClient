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
CGFloat const kBurgerButtonWidth = 20.0;
CGFloat const kBurgerButtonHeight = 20.0;
NSTimeInterval const kBurgerMenuAnimationTime = 0.4;

@interface BurgerMenuViewController ()

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
}

- (void)setUpMenuViewController {
    
}

- (void)setUpSearchViewController {
    
}

- (void)setUpMyQuestionsViewController {
    
}

- (void)setUpProfileViewController {
    
}

@end
