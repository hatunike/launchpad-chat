//
//  Message+Message_Additions.h
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "Message.h"

@interface Message (Additions)

- (NSFetchRequest *)requestMessagesFromUser:(NSString *) userName inManagedObjectContext:(NSManagedObjectContext *)context;

@end