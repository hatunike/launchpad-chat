//
//  LoginViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #3 on 2/12/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property (nonatomic, retain)IBOutlet UITextField *usernameField;
@property (nonatomic, retain)IBOutlet UITextField *passwordField;
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
    if([self.usernameField.text isEqual:@"Launchpad"] && [self.passwordField.text isEqual:@"Launchpad"]){
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



@end
