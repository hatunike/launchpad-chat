//
//  User+User_Additions.h
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "User.h"

@interface User (Additions)

//fetchrequestForAll (sorted)
//fetchRequestForIndivualProperty
//fetchRequestAllOnline
//fetchRequestAllOffline

//Creating AND modifying
+ (User *)createUserWithName:(NSString*)name onlineStatus:(BOOL)status inContext:(NSManagedObjectContext*)context;
+ (void)changeStatusOf:(User *)currentUser inContext:(NSManagedObjectContext *)context;
+ (void)setAvatar:(UIImage *)image forUser:(User *)user inContext:(NSManagedObjectContext *)context;
+ (void)setLastUploadDataAsNowForUser:(User *)User inContext:(NSManagedObjectContext *)context;

//Requests
+ (NSFetchRequest *)requestUsersWithRecentUploads;
+ (User *)requestUserWithName:(NSString*)name inContext:(NSManagedObjectContext *)context;
+ (NSFetchRequest *)requestUsersOrderedByStatusAndNameWithoutCurrentUser:(NSString *)currentUser;
+ (NSFetchRequest *)requestUsersOrderedByStatusAndLastUploadDateWithoutCurrentUser:(NSString *)currentUser;

@end
