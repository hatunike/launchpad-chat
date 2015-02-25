//
//  Message+Message_Additions.m
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "Message+Additions.h"

@implementation Message (Additions)

- (NSFetchRequest *)requestMessagesFromUser:(NSString *)userName inManagedObjectContext:(NSManagedObjectContext *)context
{
    // NSSortDescriptor
    NSSortDescriptor *sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    
    // NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userName like %@", userName];
    
    // NSFetchRequest
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    //fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
    fetchRequest.entity = [NSEntityDescription entityForName:@"Message" inManagedObjectContext:context];
//    fetchRequest.fetchBatchSize = 20;
//    fetchRequest.fetchLimit = 100;
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:sortByDate];
    fetchRequest.predicate = predicate;
    
    return fetchRequest;
}

@end
