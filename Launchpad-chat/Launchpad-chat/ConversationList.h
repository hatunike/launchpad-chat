//
//  ConversationList.h
//  Launchpad-chat
//
//  Created by STUDENT #5 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class MessageList;

@interface ConversationList : NSManagedObject

@property (nonatomic, retain) NSData * list;
@property (nonatomic, retain) NSSet *messages;
@end

@interface ConversationList (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(MessageList *)value;
- (void)removeMessagesObject:(MessageList *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
