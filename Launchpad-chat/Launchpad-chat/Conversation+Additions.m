//
//  Conversation+Conversation_Additions.m
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "Conversation+Additions.h"

@implementation Conversation (Additions)

+ (Conversation *)createConvertationWithUser1:(User*)user1 AndUser2:(User*)user2 lastMessage:(NSDate*)lastMessageDate inContext:(NSManagedObjectContext*)context
{
    __block Conversation* newConversation1 = nil;
    [context performBlockAndWait:^{
        
        newConversation1 = [[Conversation alloc] initWithEntity:[NSEntityDescription entityForName:@"Conversation" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        newConversation1.lastMessageDate = lastMessageDate;
        [newConversation1 addUserObject:user1];
        [newConversation1 addUserObject:user2];
        [context save:nil];
        
    }];
    return newConversation1;
    
    
}

+ (NSFetchRequest *)requestConversationWithTwoUsers:(User*)user1 AndUser2:(User*)user2
{
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ANY user.name == %@ AND ANY user.name == %@", user1, user2];
    
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Conversation"];
    
    fr.predicate = predicate;
    
    return fr;
}

@end
