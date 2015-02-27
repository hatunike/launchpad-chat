//
//  User+User_Additions.h
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "User.h"

@interface User (Additions)

//fetchrequestForAll (sorted)
//fetchRequestForIndivualProperty
//fetchRequestAllOnline
//fetchRequestAllOffline


+ (NSFetchRequest *)requestUsersWithRecentUploads;
+ (NSFetchRequest *)requestUserWithName:(NSString*)name;
+ (NSFetchRequest *)requestUsersOrderedByStatusAndName;
+ (NSFetchRequest *)requestUsersOrderedByStatusAndLastUploadDate;
+ (void)createUserWithName:(NSString*)name onlineStatus:(BOOL)status inContext:(NSManagedObjectContext*)context;

@end
