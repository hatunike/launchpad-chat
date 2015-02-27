//
//  LoginViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #3 on 2/12/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "UINewUserViewController.h"
#import "AppDelegate.h"
#import "User+Additions.h"

@interface UINewUserViewController ()

@property (nonatomic, retain)IBOutlet UITextField *usernameField;
@property (nonatomic, retain)IBOutlet UITextField *passwordField;
@property (nonatomic, retain)IBOutlet UITextField *passwordField2;
@property (nonatomic, strong)NSString *userName;
@property (nonatomic, strong)NSString *passWord;
@property (nonatomic, strong) NSManagedObjectContext* context;
@end

@implementation UINewUserViewController
static NSString * const reuseIdentifier = @"Cell";
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createUser
{
}


- (IBAction)btn_create_account:(id)sender {
    if([self.usernameField.text length] > 0 &&  [self.passwordField.text isEqualToString:self.passwordField2.text])
    {
        self.userName = self.usernameField.text;
        self.passWord = self.passwordField.text;
        [User createUserWithName:self.userName onlineStatus:YES inContext:self.context];
        [[NSUserDefaults standardUserDefaults] setObject:self.userName forKey:@"currentUserName"];

        
        [self performSegueWithIdentifier:@"newUserToLogin" sender:nil];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Yay"
                                                        message:@"Your account has been created"
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
    else
    {
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
