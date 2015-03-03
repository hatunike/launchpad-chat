//
//  Conversation.h
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/26/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Message, User;

@interface Conversation : NSManagedObject

@property (nonatomic, retain) NSDate * lastMessageDate;
@property (nonatomic, retain) NSSet *messages;
@property (nonatomic, retain) NSSet *user;
@end

@interface Conversation (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

- (void)addUserObject:(User *)value;
- (void)removeUserObject:(User *)value;
- (void)addUser:(NSSet *)values;
- (void)removeUser:(NSSet *)values;

@end
