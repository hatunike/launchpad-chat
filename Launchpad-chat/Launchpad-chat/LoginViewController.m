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
    
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if ([[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserName"] && [[NSUserDefaults standardUserDefaults] valueForKey:@"password"]){
            [self performSegueWithIdentifier:@"LoginToUser" sender:self];
        }
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.usernameField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"currentUserName"];
    self.passwordField.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)btn_login_submit:(id)sender{
    if([self.usernameField.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserName"]] && [self.passwordField.text isEqualToString:[[NSUserDefaults standardUserDefaults] valueForKey:@"password"]])
    {
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
