//
//  DialogTableViewController.m
//  Launchpad-chat
//
//  Created by Charles Hart on 3/10/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "DialogTableViewController.h"
#import "Message+Additions.h"

@interface DialogTableViewController ()

@end

@implementation DialogTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Message* message = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    User *userWhoSentMessage = message.fromWho;
    NSString *userString = [NSString stringWithFormat:@"%@: ", userWhoSentMessage.name];
    cell.textLabel.text = [userString stringByAppendingString:[NSString stringWithFormat:@"%@", message.text]];
    
    //cell.textLabel.text = message.text;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/mm/yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:message.date];
    
    cell.detailTextLabel.text = stringFromDate;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    if(cell.selectionStyle == UITableViewCellSelectionStyleNone)
    {
        return nil;
    }
    return indexPath;
}





@end
