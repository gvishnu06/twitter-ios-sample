//
//  Utility.m
//  TwitterApp
//
//  Created by Vishnu on 16/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import "Utility.h"

@implementation Utility
+(NSUserDefaults *)sharedDefaults
{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    return defaults;
}
+(BOOL)isAuthenticated
{
    NSString* token = [[Utility sharedDefaults] stringForKey:@"TOKEN"];
    if (token == nil) {
        return false;
    }
    return true;
}
@end
