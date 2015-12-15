//
//  SearchManager.h
//  TwitterApp
//
//  Created by Vishnu on 15/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIProvider.h"

@protocol SearchDelegate <NSObject>
-(void) authenticationFailed;
-(void) tweetsUpdated;
-(void) searchFailed;
@end

@interface SearchManager : NSObject<APIProviderDelegate>
+ (id) sharedInstance;
-(void)searchTweets:(NSString*)query;
@property id<SearchDelegate> delegate;
@property NSMutableArray* tweets;
@property NSString* searchQuery;
@property BOOL shouldRefresh;
@end
