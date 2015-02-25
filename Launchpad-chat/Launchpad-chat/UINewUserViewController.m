//
//  LoginViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #3 on 2/12/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "UINewUserViewController.h"

@interface UINewUserViewController ()

@property (nonatomic, retain)IBOutlet UITextField *usernameField;
@property (nonatomic, retain)IBOutlet UITextField *passwordField;
@property (nonatomic, retain)IBOutlet UITextField *passwordField2;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *passWord;
@end

@implementation UINewUserViewController
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)btn_create_account:(id)sender {
    if([self.usernameField.text isEqual:@"1"] && [self.passwordField.text isEqual:@"2"] && [self.passwordField2.text isEqual:@"2"])
    {
        [self performSegueWithIdentifier:@"returnToLogin" sender:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yay"
                                                        message:@"Your account have been created"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
        self.userName = self.usernameField.text;
        self.passWord = self.passwordField.text;
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Incorrect"
                                                        message:@"There is a problem with your credentials, please try again"
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
