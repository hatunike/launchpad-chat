//
//  LoginViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #3 on 2/12/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "LoginViewController.h"
#import "UIMessageListViewController.h"

@interface LoginViewController ()
@property (nonatomic, retain)IBOutlet UITextField *usernameField;
@property (nonatomic, retain)IBOutlet UITextField *passwordField;
@property (nonatomic, strong)NSString *userName;
@end

@implementation LoginViewController
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btn_login_submit:(id)sender {
    if([self.usernameField.text isEqualToString:@"1"] && [self.passwordField.text isEqualToString:@"2"]){
        self.userName = self.usernameField.text;
        [self performSegueWithIdentifier:@"LoginToUser" sender:nil];
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect"
                                                        message:@"Please enter the correct usename and password"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 0;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 0;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    // Configure the cell
    
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"LoginToUser"])
    {
        UIMessageListViewController* vc = [segue destinationViewController];
        vc.userName = self.userName;
    }
    else
    {
        
    }
}

@end
