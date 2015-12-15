//
//  SearchManager.m
//  TwitterApp
//
//  Created by Vishnu on 15/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import "SearchManager.h"
#import "Utility.h"

static SearchManager* singletonObject;

@implementation SearchManager
{
    APIProvider* apiProvider;
}
+ (id) sharedInstance
{
    if (! singletonObject) {
        
        singletonObject = [[SearchManager alloc] init];
    }
    return singletonObject;
}

- (id) init
{
    if (! singletonObject) {
        singletonObject = [super init];
        _shouldRefresh = true;
        _searchQuery = @"";
    }
    return singletonObject;
}

-(void)searchTweets:(NSString*)query
{
    if([query isEqualToString:@""])
    {
        return;
    }
    _searchQuery = query;
    if(apiProvider == nil)
    {
        apiProvider = [[APIProvider alloc] init];
    }
    apiProvider.delegate = self;
    if([Utility isAuthenticated])
    {
        NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
        NSString *encodedQuery = [query stringByAddingPercentEncodingWithAllowedCharacters:set];
        apiProvider.requestType = Search;
        [apiProvider searchTweets:encodedQuery];
    }
    else
    {
        apiProvider.requestType = Authentication;
        [apiProvider authenticateApp];
    }
    
}

-(void)responseRecievedSuccess:(NSData *)data
{
    if (apiProvider.requestType == Authentication) {
        NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        [[Utility sharedDefaults] setValue:[jsonData valueForKey:@"access_token"] forKey:@"TOKEN"];
        [self searchTweets:_searchQuery];
    } else {
        NSMutableDictionary* jsonData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        self.tweets = [jsonData valueForKey:@"statuses"];
        [self.delegate tweetsUpdated];
        NSTimer* timer;
        timer = [NSTimer scheduledTimerWithTimeInterval:5.0 target:self selector:@selector(callSearch) userInfo:nil repeats:false];
    }
}

-(void)responseRecievedFailure:(NSURLResponse*)response
{
    if (apiProvider.requestType == Authentication) {
        [self.delegate authenticationFailed];
    }
    else{
        [self.delegate searchFailed];
    }
}

-(void)callSearch
{
    if (_shouldRefresh) {
        [self searchTweets:_searchQuery];
    }
}
@end
