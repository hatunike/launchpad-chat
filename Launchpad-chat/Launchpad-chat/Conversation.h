//
//  Conversation.h
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Message.h"
#import "User.h"


@interface Conversation : NSManagedObject

@property (nonatomic, retain) NSDate * lastMessageDate;
@property (nonatomic, retain) User *user;
@property (nonatomic, retain) NSSet *messages;
@end

@interface Conversation (CoreDataGeneratedAccessors)

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
