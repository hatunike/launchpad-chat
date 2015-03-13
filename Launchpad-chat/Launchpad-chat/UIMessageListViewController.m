//
//  UIMessageListViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #6 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "UIMessageListViewController.h"
#import "User+Additions.h"
#import "AppDelegate.h"

@interface UIMessageListViewController ()

@property (nonatomic, strong) NSManagedObjectContext* context;

@end

@implementation UIMessageListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];

    NSLog(@"userName: %@", self.userName);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)logoutButtonpressed:(id)sender
{
    //[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"currentUserName"];
    //[[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"password"];
    [User changeStatusOf:[User requestUserWithName:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserName"] inContext:self.context] inContext:self.context];
    [self.navigationController popViewControllerAnimated:YES];
    //self.usernameField.text = nil;
    //self.passwordField.text = nil;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
