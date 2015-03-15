//
//  User+User_Additions.m
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "User+Additions.h"

@implementation User (Additions)

+ (User *)createUserWithName:(NSString*)name onlineStatus:(BOOL)status inContext:(NSManagedObjectContext*)context
{
    __block User* newUser1 = nil;
    [context performBlockAndWait:^{
        
        newUser1 = [[User alloc] initWithEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        newUser1.name = name;
        newUser1.onlineStatus = [NSNumber numberWithBool:status];
        newUser1.avatar = nil;
        [context save:nil];
    }];
    
    return newUser1;
    
}

+ (void)changeStatusOf:(User *)currentUser inContext:(NSManagedObjectContext *)context;
{
    [context performBlockAndWait:^{
        
        if (currentUser.onlineStatus == [NSNumber numberWithBool:NO])
        {
            currentUser.onlineStatus = [NSNumber numberWithBool:YES];
        }
        else
        {
            currentUser.onlineStatus = [NSNumber numberWithBool:NO];
        }
        [context save:nil];
    }];
}

+ (void)setAvatar:(UIImage *)image forUser:(User *)user inContext:(NSManagedObjectContext *)context
{
    NSData *dataImage = UIImageJPEGRepresentation(image, 0.0);
    
    [context performBlockAndWait:^{
        
        user.avatar = dataImage;
        
        [context save:nil];
    }];
}

+ (void)setLastUploadDataAsNowForUser:(User *)user inContext:(NSManagedObjectContext *)context
{
    [context performBlockAndWait:^{
        
        user.lastUploadDate = [NSDate dateWithTimeIntervalSinceNow:0];
        
        [context save:nil];
    }];
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

+ (User *)requestUserWithName:(NSString*)name inContext:(NSManagedObjectContext *)context
{
    // NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name == %@", name];
    
    // NSFetchRequest
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];  // request all users

    fetchRequest.predicate = predicate;
    
    NSArray *result = [context executeFetchRequest:fetchRequest error:nil];
    
    User *user = result[0];
    
    return user;
}

+ (NSFetchRequest *)requestUsersOrderedByStatusAndNameWithoutCurrentUser:(NSString *)currentUser
{
    NSFetchRequest* fr = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"onlineStatus" ascending:NO],[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name != %@", currentUser];
    
    fr.predicate = predicate;
    
    return fr;
}

+ (NSFetchRequest *)requestUsersOrderedByStatusAndLastUploadDateWithoutCurrentUser:(NSString *)currentUser
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
