//
//  UserIndexTableViewController.m
//  Launchpad-chat
//
//  Created by Collin on 2/12/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserTableViewController.h"
#import "ConversationTableViewController.h"
#import "User.h"
#import "Message+Additions.h"
#import "User+Additions.h"
#import "AppDelegate.h"
#import "UIUserTableViewCell.h"

@interface UserTableViewController ()

@property (nonatomic, strong) NSManagedObjectContext* context;

@end

@implementation UserTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] managedObjectContext];
    
    
    // grab all the users in core data and put them in userArray
    
    //[self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:[User requestUsersWithoutCurrentUserOrderedByStatusAndName:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserName"]] managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil]];
    
    [self setFetchedResultsController:[[NSFetchedResultsController alloc] initWithFetchRequest:[User requestUsersOrderedByStatusAndNameWithoutCurrentUser:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserName"]] managedObjectContext:self.context sectionNameKeyPath:nil cacheName:nil]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"user" forIndexPath:indexPath];

    User* user = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Check to see if the user has an avater
    if (user.avatar == nil)
    {
        //If not set placeholder image
        cell.userProfileImageView.image = [UIImage imageNamed:@"person.png"];
    }
    else
    {
        //Set user avater image
        cell.userProfileImageView.image = [UIImage imageWithData:user.avatar];
    }
    
    NSString* userName = user.name;
    
    cell.userNameTextLabel.text = userName;
    //Conversation* conversation = [Conversation getConversationWithName:ownID andOtherName:user.name];

    //Message* message = [Message getLatestMessageWithUsername:userName];
    NSArray *messages = [Message requestMessagesFromUser:user inContext:self.context];
    NSString *latestText;
    if (messages.count == 0)
    {
        latestText = @"";
    }
    else
    {
        Message *latestMessage = [messages lastObject];
        latestText = latestMessage.text;
    }
    cell.latestMessageTextLabel.text = latestText;
    
    //NSDate* latestMessageDate = message.date;
    //UIImage* userAvatar = user.avatar; //outlet must be made somewhere
    
    //cell.userAvatar.image = user.avatar;
    
    cell.userStatusCircleView.is_online = user.onlineStatus.boolValue;

    
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"open UIConversationViewController" sender:self];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"open UIConversationViewController"])
    {
        ConversationTableViewController* vc = [segue destinationViewController];
        
        
        //Get user of selected row
        User* selectedUser = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
        User* me = [User requestUserWithName:[[NSUserDefaults standardUserDefaults] objectForKey:@"currentUserName"] inContext:self.context];
        //vc.view = selectedUser.name;
        vc.userName = selectedUser.name;
        vc.conversation = [[self.context executeFetchRequest:[Conversation requestConversationWithTwoUsers:selectedUser AndUser2:me] error:nil] lastObject];
        
    }
    
    // Pass the selected object to the new view controller.
}


@end
