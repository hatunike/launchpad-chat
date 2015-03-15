//
//  Message+Message_Additions.h
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "Message.h"

@interface Message (Additions)

//Creating AND modifying
+ (Message *)createMessageWithText:(NSString*)text onDate:(NSDate*)date fromUser:(User*)user inConversation:(Conversation*)conversation withState:(BOOL)readOrUnreadState inContext:(NSManagedObjectContext*)context;
+ (void)changeMessagereadOrUnreadState:(Message *)message inContext:(NSManagedObjectContext *)context;

//Requests
+ (NSArray *)requestMessagesFromUser:(User *)userName inContext:(NSManagedObjectContext*)context;
+ (NSFetchRequest *)requestLastestMessageFromUser:(User *) userName;
+ (NSFetchRequest *)requestMessagesOrderedByDateFromConversation:(Conversation *)Conversation;

@end
