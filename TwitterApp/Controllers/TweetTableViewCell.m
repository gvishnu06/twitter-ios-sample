//
//  TweetTableViewCell.m
//  TwitterApp
//
//  Created by Vishnu on 15/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import "TweetTableViewCell.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@implementation TweetTableViewCell
{
    NSString* reuseIdentifier;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)initCellWithFrame : (CGRect)frame
{
    CGRect newFrame = self.frame;
    newFrame.size.width = frame.size.width;
    self.frame = newFrame;
    reuseIdentifier = @"TweetCell";
}

-(void)updateCell:(NSMutableDictionary*)tweet
{
    NSMutableDictionary* user = [tweet valueForKey:@"user"];
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithObject:[UIFont systemFontOfSize:15] forKey:NSFontAttributeName];
    [attributes setValue:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    NSMutableAttributedString *name = [[NSMutableAttributedString alloc] initWithString:[user valueForKey:@"name"] attributes:attributes];
    [attributes removeAllObjects];
    
    [attributes setValue:[UIFont systemFontOfSize:14] forKey:NSFontAttributeName];
    [attributes setValue:[UIColor grayColor] forKey:NSForegroundColorAttributeName];
    
    NSMutableAttributedString *screenName = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" @%@",[user valueForKey:@"screen_name"]] attributes:attributes];
    
    [name appendAttributedString:screenName];
    _outProfileName.attributedText = name;
    
    _outTweet.text = [tweet valueForKey:@"text"];
    
    dispatch_async(kBgQueue, ^{
        NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[user valueForKey:@"profile_image_url"]]]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            _outProfileImage.image = [UIImage imageWithData:imgData];
        });
    });
}

@end
