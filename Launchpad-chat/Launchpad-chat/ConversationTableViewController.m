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
@property (nonatomic, strong) DialogTableViewController* messagesVC;
@end

@implementation ConversationTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    self.userNameHeader.text = self.userName;
    self.messageTextField.delegate = self;

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self scrollToBottom];
}
- (IBAction)sendMessageButtonPressed:(id)sender
{
    User* currentUser = [User requestUserWithName:self.userName inContext:self.context];
    
    [Message createMessageWithText:self.messageTextField.text onDate:[NSDate date] fromUser:currentUser inConversation:nil withState:YES inContext:self.context];
    self.messageTextField.text = @"";
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self scrollToBottom];
        });
    });
}

- (void)scrollToBottom
{
    [self.messagesVC.tableView  scrollRectToVisible:CGRectMake(0, self.messagesVC.tableView.contentSize.height - self.messagesVC.tableView.bounds.size.height, self.messagesVC.tableView.bounds.size.width, self.messagesVC.tableView.bounds.size.height) animated:YES];
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
        self.messagesVC = vc;
    }
    
}


@end
