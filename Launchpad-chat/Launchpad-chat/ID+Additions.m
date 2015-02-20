//
//  NSManagedObject+ID_Additions.m
//  Launchpad-chat
//
//  Created by STUDENT #5 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "ID+Additions.h"

@implementation ID (Additions)

+ (NSFetchRequest *)requestUserID
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"UserName"];
    
    return fetchRequest;
}

@end
