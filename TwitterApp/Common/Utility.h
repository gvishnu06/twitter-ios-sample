//
//  Utility.h
//  TwitterApp
//
//  Created by Vishnu on 16/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Utility : NSObject
+(NSUserDefaults *)sharedDefaults;
+(BOOL)isAuthenticated;
@end
