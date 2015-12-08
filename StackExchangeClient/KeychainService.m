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
    
    CFDataRef *result = nil;
    
    OSStatus status = SecItemCopyMatching(keychainCFDict, (CFTypeRef *)&result);
    
    NSString *contentsOfKeychain;
    
    NSData *resultData = (__bridge_transfer NSData *)result;
    
    
    if (result) {
        (NSData *)result;
    }
    
    return nil;
}

@end

//class func loadFromKeychain() -> NSString? {
    //        // Instantiate a new default keychain query
    //        // Tell the query to return a result
    //        // Limit our results to one item
    //
    //        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
    //
    //        var dataTypeRef :AnyObject?
    //
    //        // Search for the keychain items
    //        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
    //
    //        var contentsOfKeychain: NSString?
    //
    //        if let retainedData = dataTypeRef as? NSData {
    //            contentsOfKeychain = NSString(data: retainedData, encoding: NSUTF8StringEncoding)
    //        } else {
    //            print("Nothing was retrieved from the keychain. Status code \(status)")
    //        }
    //        //dataTypeRef?.release()
    //        return contentsOfKeychain
    //    }

//// Identifiers
//let userAccount = "github"
//let accessGroup = "MyService"
//
//// Arguments for the keychain queries
//let kSecClassValue = kSecClass as NSString
//let kSecAttrAccountValue = kSecAttrAccount as NSString
//let kSecValueDataValue = kSecValueData as NSString
//let kSecClassGenericPasswordValue = kSecClassInternetPassword as NSString
//let kSecAttrServiceValue = kSecAttrService as NSString
//let kSecMatchLimitValue = kSecMatchLimit as NSString
//let kSecReturnDataValue = kSecReturnData as NSString
//let kSecMatchLimitOneValue = kSecMatchLimitOne as NSString
//
//class KeychainService: NSObject {
//    
//    class func save(data: NSString) {
//        let dataFromString: NSData = data.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false)!
//        
//        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrAccountValue, kSecValueDataValue])
//        
//        // Delete any existing items
//        SecItemDelete(keychainQuery)
//        
//        // Add the new keychain item
//        let _ : OSStatus = SecItemAdd(keychainQuery, nil)
//    }
//    
//    //}



