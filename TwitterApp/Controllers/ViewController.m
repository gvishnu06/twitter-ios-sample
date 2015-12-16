//
//  ViewController.m
//  TwitterApp
//
//  Created by Vishnu on 15/12/15.
//  Copyright © 2015 Vishnu. All rights reserved.
//

#import "ViewController.h"
#define REUSEID "TweetCell"

@interface ViewController ()

@end

@implementation ViewController
{
    SearchManager* searchManager;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    searchManager = [[SearchManager alloc] init];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showTextField)];
    [_outHeaderView addGestureRecognizer:tap];
    _outTableView.delegate = self;
    _outTableView.dataSource = self;
    searchManager.delegate = self;
    _outSearchField.delegate = self;
    UITapGestureRecognizer *outsideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:outsideTap];
    //[[APIProvider sharedInstance] searchTweets:@"#india"];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)dismissKeyboard
{
    [self.outSearchField resignFirstResponder];
    _outSearchTitle.hidden = false;
    _outSearchField.hidden = true;
}

-(void)showTextField
{
    _outSearchTitle.hidden = true;
    _outSearchField.hidden = false;
    [_outSearchField becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tweetsUpdated
{
    if ([searchManager.tweets count]==0) {
        [self alertWithTitle:@"Sorry!! No tweets found"];
        return;
    }
    _outNoData.hidden = true;
    _outTableView.hidden = false;
    [_outTableView reloadData];
}

-(void)searchFailed
{
    [self alertWithTitle:@"Could not fetch any tweets"];
}

-(void)authenticationFailed
{
    [self alertWithTitle:@"Sorry!! Authentication failed"];
}

-(void)alertWithTitle :(NSString*)title
{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:@"Error" message:title preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *cancelAction = [UIAlertAction
                                   actionWithTitle:@"Cancel"
                                   style:UIAlertActionStyleCancel
                                   handler:^(UIAlertAction *action)
                                   {
                                   }];
    [alert addAction:cancelAction];
    [self presentViewController:alert animated:true completion:^{
        
    }];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [[[SearchManager sharedInstance] tweets] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetTableViewCell *cell = (TweetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@REUSEID];
    if (cell == nil) {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"TweetTableViewCell" owner:self options:nil];
        cell = [topLevelObjects objectAtIndex:0];
        [cell initCellWithFrame:self.view.frame];
    }
    [cell updateCell:[[[SearchManager sharedInstance] tweets] objectAtIndex:indexPath.row]];
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return CELLHEIGHT;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [searchManager searchTweets:textField.text];
    [_outSearchField resignFirstResponder];
    return true;
}


- (IBAction)actionStop:(UIButton *)sender {
    if([sender.titleLabel.text isEqualToString:@"Stop"])
    {
        searchManager.shouldRefresh = false;
        [sender setTitle:@"Start" forState:UIControlStateNormal];
    }
    else
    {
        searchManager.shouldRefresh = true;
        [searchManager searchTweets:searchManager.searchQuery];
        [sender setTitle:@"Stop" forState:UIControlStateNormal];
    }
}
@end
