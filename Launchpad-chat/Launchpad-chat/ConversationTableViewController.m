//
//  ConversationTableViewController.m
//  Launchpad-chat
//
//  Created by STUDENT #4 on 2/24/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "ConversationTableViewController.h"
#import "UserTableViewController.h"
#import "DialogTableViewController.h"
#import "AppDelegate.h"
#import "Message+Additions.h"
#import "User+Additions.h"

@interface ConversationTableViewController ()

@property (strong, nonatomic) IBOutlet UITextField *messageTextField;

@end

@implementation ConversationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    self.userNameHeader.text = self.userName;
    self.messageTextField.delegate = self;

}
- (IBAction)sendMessageButtonPressed:(id)sender
{
    User* currentUser = [[self.context executeFetchRequest:[User requestUserWithName:self.userName] error:nil] lastObject];
    
    [Message createMessageWithText:self.messageTextField.text onDate:[NSDate date] fromUser:currentUser inConversation:nil withState:YES inContext:self.context];
    self.messageTextField.text = @"";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)dismissConversationViewController:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [self sendMessageButtonPressed:nil];
    return NO;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"Dialog TableViewController"])
    {
        self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
        DialogTableViewController* vc = [segue destinationViewController];
        NSFetchRequest* fr = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
        fr.predicate = [NSPredicate predicateWithFormat:@"fromWho.name == %@", self.userName];
        fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
        
        NSFetchedResultsController *frc = [[NSFetchedResultsController alloc] initWithFetchRequest:fr managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil];
        
        [vc setFetchedResultsController:frc];
    }
    
}


@end
