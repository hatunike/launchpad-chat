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
    cell.textLabel.text = message.text;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd/mm/yyyy"];
    
    NSString *stringFromDate = [formatter stringFromDate:message.date];
    
    cell.detailTextLabel.text = stringFromDate;
    
    return cell;
}





@end
