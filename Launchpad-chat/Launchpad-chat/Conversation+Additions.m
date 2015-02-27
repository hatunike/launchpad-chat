//
//  Conversation+Conversation_Additions.m
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "Conversation+Additions.h"

@implementation Conversation (Additions)

+ (void)createConvertationWithUser1:(User*)name1 AndUser2:(User*)name2 lastMessage:(NSDate*)lastMessageDate inContext:(NSManagedObjectContext*)context;
{
    
    [context performBlockAndWait:^{
        
        Conversation* newConversation1 = [[Conversation alloc] initWithEntity:[NSEntityDescription entityForName:@"Conversation" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        newConversation1.lastMessageDate = lastMessageDate;
        
        
    }];
    
    [context save:nil];
    
}
@end
