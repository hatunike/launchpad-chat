//
//  Conversation+Conversation_Additions.h
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "Conversation.h"

@interface Conversation (Additions)

//Creating AND modifying
+ (Conversation *)createConvertationWithUser1:(User*)user1 AndUser2:(User*)user2 lastMessage:(NSDate*)lastMessageDate inContext:(NSManagedObjectContext*)context;
+ (void)setLastMessageDateForConversation:(Conversation *)Conversation inContext:(NSManagedObjectContext *)context;

//Requests
+ (NSFetchRequest *)requestConversationWithTwoUsers:(User*)user1 AndUser2:(User*)user2;
+ (NSFetchRequest *)requestConversationsForUser:(User*)user;

@end
