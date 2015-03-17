//
//  CloudModel.h
//  Launchpad-chat
//
//  Created by Charles Hart on 3/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo.h"

@import CloudKit;
@import CoreData;

@protocol CloudDelegate <NSObject>

@optional

- (void)errorUpdating:(NSError*)error dataType:(NSString*)type;
- (void)modelUpdated:(NSArray*)recordsUpdated  dataType:(NSString*)type;
- (void)errorSubscribing:(NSError*)error dataType:(NSString*)type;
- (void)modelSubscribedForDataType:(NSString*)type;

@end

@interface CloudModel : NSObject

+ (instancetype)sharedCloudManager;

@property (nonatomic, strong) CKContainer* container;
@property (nonatomic, strong) CKDatabase* publicDataBase;
@property (nonatomic, strong) UserInfo* userInfo;
@property (nonatomic, strong) NSManagedObjectContext* context;

@property (nonatomic, assign) id <CloudDelegate> delegate;

- (void)requestUsers;
- (void)requestConversations;
- (void)requestMessages;

@end
