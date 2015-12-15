//
//  NetworkManager.m
//  TwitterApp
//
//  Created by Vishnu on 15/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import "APIProvider.h"
#import "Utility.h"
#define PAGESIZE 100

static APIProvider* singletonObject;
static NSString* hostUrl  = @"https://api.twitter.com";
static NSString* authUrl = @"/oauth2/token";
static NSString* searchUrl = @"/1.1/search/tweets.json";
static NSString* secret = @"ZDVnUEc0UEozQ1Vvb3N0aDZ4cUs4Z2lwWDpmOVVzRnlnbWhFN2ZjWE9SWVllRHBuQUQ5c0JpZm52Z3drWUVuZ2hiOUE3ZEduS3hwdA==";

@implementation APIProvider
{
}

-(void)authenticateApp
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    NSString* postString = @"grant_type=client_credentials";
    NSData* jsonData = [postString dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPBody = jsonData;
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",hostUrl,authUrl]]];
    NSString *postLength = [NSString stringWithFormat:@"%lu",(unsigned long)[jsonData length]];
    [request setHTTPMethod:@"POST"];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    [request setHTTPBody:jsonData];
    [request setValue:[NSString stringWithFormat:@"Basic %@",secret] forHTTPHeaderField:@"Authorization"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                          if ([httpResponse statusCode]==200) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self.delegate responseRecievedSuccess:data];
                                              });
                                          }
                                          else
                                          {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self.delegate responseRecievedFailure:response];
                                              });
                                          }
                                      }];
    [dataTask resume];
}

-(void)searchTweets:(NSString*)query
{
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    NSString* accessToken = [[Utility sharedDefaults] stringForKey:@"TOKEN"];
    NSLog(@"%@",[NSString stringWithFormat:@"%@%@?q=%@&count=%d",hostUrl,searchUrl,query,PAGESIZE]);
    [request setURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?q=%@&count=%d&result_type=recent",hostUrl,searchUrl,query,PAGESIZE]]];
    [request setHTTPMethod:@"GET"];
    [request setValue:[NSString stringWithFormat:@"Bearer %@",accessToken] forHTTPHeaderField:@"Authorization"];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
                                                completionHandler:^(NSData *data, NSURLResponse *response, NSError *error)
                                      {
                                          NSHTTPURLResponse *httpResponse = (NSHTTPURLResponse *) response;
                                          if ([httpResponse statusCode]==200) {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self.delegate responseRecievedSuccess:data];
                                              });
                                          }
                                          else
                                          {
                                              dispatch_async(dispatch_get_main_queue(), ^{
                                                  [self.delegate responseRecievedFailure:response];
                                              });
                                          }
                                      }];
    [dataTask resume];
}
@end
