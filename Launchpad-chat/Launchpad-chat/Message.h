//
//  Message.h
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Conversation;

@interface Message : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSNumber * readOrUnreadState;
@property (nonatomic, retain) Conversation *fromWhat;
@property (nonatomic, retain) User *fromWho;

@end
