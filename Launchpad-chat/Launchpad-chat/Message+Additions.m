//
//  Message+Message_Additions.m
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "Message+Additions.h"

@implementation Message (Additions)

+ (Message *)createMessageWithText:(NSString*)text onDate:(NSDate*)date fromUser:(User*)user inConversation:(Conversation*)conversation withState:(BOOL)readOrUnreadState inContext:(NSManagedObjectContext*)context
{
    __block Message *newMessage1 = nil;
    [context performBlockAndWait:^{
        
        newMessage1 = [[Message alloc] initWithEntity:[NSEntityDescription entityForName:@"Message" inManagedObjectContext:context] insertIntoManagedObjectContext:context];
        newMessage1.text = text;
        newMessage1.date = date;
        newMessage1.readOrUnreadState = [NSNumber numberWithBool:readOrUnreadState];
        newMessage1.fromWho = user;
        newMessage1.fromWhat = conversation;
        [context save:nil];
    }];
    
    return newMessage1;
    
}

+ (NSFetchRequest *)requestMessagesFromUser:(NSString *)userName
{
    // NSSortDescriptor
    //NSSortDescriptor *sortByDate = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES];
    
    // NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fromWho.name == %@", userName];
    
    // NSFetchRequest
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
//    fetchRequest.fetchBatchSize = 20;
//    fetchRequest.fetchLimit = 100;
    //fetchRequest.sortDescriptors = [NSArray arrayWithObject:sortByDate];
    fetchRequest.predicate = predicate;
    
    return fetchRequest;
}

+ (NSFetchRequest *)requestMessagesFromConversation:(Conversation *)conversation
{
    //Sort using fromWhat (Conversation)
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"fromWhat == %@", conversation];
    
    //Request Messages
    NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
    
    //Sort by date
    fr.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"date" ascending:YES]];
    
    fr.predicate = predicate;
    
    return fr;
}

@end
