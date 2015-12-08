//
//  KeychainService.m
//  StackExchangeClient
//
//  Created by Miles Ranisavljevic on 12/7/15.
//  Copyright © 2015 creeperspeak. All rights reserved.
//

#import "KeychainService.h"
@import UIKit;
@import Security;

NSString const *userAccount = @"StackExchange";
NSString const *accessGroup = @"MyService";

@implementation KeychainService

+ (void)save:(NSString *)data {
    NSData *dataFromString = [data dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:NO];
    NSArray *keys = [NSArray arrayWithObjects:(NSString *)kSecClassInternetPassword, userAccount, dataFromString, nil];
    NSArray *values = [NSArray arrayWithObjects:(NSString *)kSecClass, kSecAttrAccount, kSecValueData, nil];
    NSMutableDictionary *keychainQuery = [NSMutableDictionary dictionaryWithObjects:keys forKeys:values];
    
    CFDictionaryRef keychainCFDict = (__bridge CFDictionaryRef)keychainQuery;
    
    SecItemDelete(keychainCFDict);
    
    SecItemAdd(keychainCFDict, nil);
}

+ (NSString *)loadFromKeychain {
    NSArray *keys = [NSArray arrayWithObjects:(NSString *)kSecClassInternetPassword, userAccount, kCFBooleanTrue, kSecMatchLimitOne, nil];
    NSArray *values = [NSArray arrayWithObjects:(NSString *)kSecClass, kSecAttrAccount, kSecReturnData, kSecMatchLimit, nil];
    NSMutableDictionary *keychainQuery = [NSMutableDictionary dictionaryWithObjects:keys forKeys:values];
    
    CFDictionaryRef keychainCFDict = (__bridge CFDictionaryRef)keychainQuery;
    
    CFDataRef result = nil;
    
    OSStatus status = SecItemCopyMatching(keychainCFDict, (CFTypeRef *)&result);
    
    NSString *contentsOfKeychain;
    
    NSData *resultData = (__bridge_transfer NSData *)result;
    
    
    if (resultData) {
        contentsOfKeychain = [NSString stringWithUTF8String:[resultData bytes]];
    } else {
        NSLog(@"Nothing was retrieved from the keychain.  Status code %d",(int)status);
    }
    return contentsOfKeychain;
    
    return nil;
}

@end

