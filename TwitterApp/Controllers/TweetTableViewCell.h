//
//  TweetTableViewCell.h
//  TwitterApp
//
//  Created by Vishnu on 15/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#define CELLHEIGHT 112

@interface TweetTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *outProfileImage;
@property (weak, nonatomic) IBOutlet UILabel *outProfileName;
@property (weak, nonatomic) IBOutlet UILabel *outTweet;
-(void)initCellWithFrame : (CGRect)frame;
-(void)updateCell:(NSMutableDictionary*)tweet;
@end
