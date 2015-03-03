//
//  User+User_Additions.m
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "User+Additions.h"

@implementation User (Additions)

+ (void)createUserWithName:(NSString*)name onlineStatus:(BOOL)status inContext:(NSManagedObjectContext*)context
{
    
    [context performBlockAndWait:^{
        
        User* newUser1 = [[User alloc] initWithEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        newUser1.name = name;
        newUser1.onlineStatus = [NSNumber numberWithBool:status];
        
    }];
    
    [context save:nil];
    
}

+ (NSFetchRequest *)requestUsersWithRecentUploads
{
    // NSSortDescriptor
    NSSortDescriptor *sortbyName = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];  // sort by User's name
    
    // NSPredicate
    NSDate *yesterday = [NSDate dateWithTimeIntervalSinceNow:-24*60*60]; // created message in past 24 hours
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY messages.uploadDate > %@", yesterday];
    
    // NSFetchRequest
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    //    fetchRequest.fetchBatchSize = 20;
    //    fetchRequest.fetchLimit = 100;
    fetchRequest.sortDescriptors = [NSArray arrayWithObject:sortbyName];
    fetchRequest.predicate = predicate;
    
    return fetchRequest;
}

+ (NSFetchRequest *)requestUserWithName:(NSString*)name
{
    // NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    // NSFetchRequest
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];  // request all users

    fetchRequest.predicate = predicate;
    
    return fetchRequest;
}

+ (NSFetchRequest *)requestUsersWithoutCurrentUserOrderedByStatusAndName:(NSString *)currentUser
{
    NSFetchRequest* fr = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"onlineStatus" ascending:NO],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name != %@", currentUser];
    
    fr.predicate = predicate;
    
    return fr;
}

+ (NSFetchRequest *)requestUsersWithoutCurrentUserOrderedByStatusAndLastUploadDate:(NSString *)currentUser
{
    //Fetch Users
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    
    //Sort by Online Status and Last Upload Date
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"onlineStatus" ascending:NO], [NSSortDescriptor sortDescriptorWithKey:@"lastUploadDate" ascending:NO]];
    
    //Predicate to filter out
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name != %@", currentUser];
    
    fr.predicate = predicate;
    
    return fr;
}

@end
