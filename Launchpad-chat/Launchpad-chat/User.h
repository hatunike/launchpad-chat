//
//  User.h
//  Launchpad-chat
//
//  Created by STUDENT #5 on 2/26/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Conversation, Message;

@interface User : NSManagedObject

@property (nonatomic, retain) NSData * avatar;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSNumber * onlineStatus;
@property (nonatomic, retain) NSDate * lastUploadDate;
@property (nonatomic, retain) NSSet *conversations;
@property (nonatomic, retain) NSSet *messages;
@end

@interface User (CoreDataGeneratedAccessors)

- (void)addConversationsObject:(Conversation *)value;
- (void)removeConversationsObject:(Conversation *)value;
- (void)addConversations:(NSSet *)values;
- (void)removeConversations:(NSSet *)values;

- (void)addMessagesObject:(Message *)value;
- (void)removeMessagesObject:(Message *)value;
- (void)addMessages:(NSSet *)values;
- (void)removeMessages:(NSSet *)values;

@end
