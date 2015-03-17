//
//  UINewMessageViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #6 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "UINewMessageViewController.h"
#import "AppDelegate.h"
#import "User+Additions.h"
#import "Message+Additions.h"
#import "Conversation+Additions.h"

@interface UINewMessageViewController ()

@end

@implementation UINewMessageViewController

- (IBAction)buttonSendMessageTapped:(id)sender
{
    [self sendNewMessage:self.messageFieldToNewConversation.text toUser:self.conversationToUsernameField.text];
}

- (BOOL)sendNewMessage:(NSString*)newMessage toUser:(NSString *)username
{
    //Create User (if doesn't exist)
    User* me = [User requestUserWithName:[[NSUserDefaults standardUserDefaults] valueForKey:@"currentUserName"] inContext:self.context];
    
    User* otherGuy = [User requestUserWithName:username inContext:self.context];
    if (otherGuy == nil)
    {
        otherGuy = [User createUserWithName:username onlineStatus:NO inContext:self.context];
    }
    
    Conversation* convo = [Conversation createConvertationWithUser1:me AndUser2:otherGuy lastMessage:[NSDate date] inContext:self.context];
    [Message createMessageWithText:newMessage onDate:[NSDate date] fromUser:me inConversation:convo withState:NO inContext:self.context];
    
    [self.navigationController popViewControllerAnimated:YES];
    
    return 0;
}

- (IBAction)cancelButtonPressed:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [super viewDidLoad];
    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
