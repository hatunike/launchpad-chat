//
//  NSManagedObject+ID_Additions.h
//  Launchpad-chat
//
//  Created by STUDENT #5 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "ID.h"

@interface ID (Additions)

+ (NSFetchRequest *)requestUserID;
+ (NSFetchRequest *)requestUserName;
+ (NSFetchRequest *)requestUserAvater;
+ (NSFetchRequest *)requestUserStatus;
+ (NSFetchRequest *)requestConversations;

@end
