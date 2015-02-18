//
//  CoreDataTableViewController.h
//  CoreDataExample
//
//  Created by Charles Hart on 2/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

/**
 * @warning 'Subclasses must finish implementing UITableviewDatasource, specifically tableView:cellForRowAtIndexPath'
 */

@interface CoreDataTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (nonatomic, strong) NSFetchedResultsController* fetchedResultsController;

@end
