//
//  ViewController.h
//  TwitterApp
//
//  Created by Vishnu on 15/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchManager.h"
#import "TweetTableViewCell.h"

@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,SearchDelegate, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *outHeaderView;
@property (weak, nonatomic) IBOutlet UIImageView *outSearchImage;
@property (weak, nonatomic) IBOutlet UITextField *outSearchField;
@property (weak, nonatomic) IBOutlet UIButton *outStopButton;
@property (weak, nonatomic) IBOutlet UILabel *outSearchTitle;
@property (weak, nonatomic) IBOutlet UIImageView *outNoData;
@property (weak, nonatomic) IBOutlet UITableView *outTableView;
- (IBAction)actionStop:(UIButton *)sender;
@end

