//
//  NetworkManager.h
//  TwitterApp
//
//  Created by Vishnu on 15/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol APIProviderDelegate <NSObject>

-(void)responseRecievedSuccess:(NSData*)data;
-(void)responseRecievedFailure:(NSURLResponse*)response;

@end

typedef enum apiTypes
{
    Authentication = 0,
    Search
}ApiType;

@interface APIProvider : NSObject
@property id <APIProviderDelegate> delegate;
@property ApiType requestType;
-(void)authenticateApp;
-(void)searchTweets:(NSString*)query;
@end
