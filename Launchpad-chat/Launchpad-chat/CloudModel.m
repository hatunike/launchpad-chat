//
//  CloudModel.m
//  Launchpad-chat
//
//  Created by Charles Hart on 3/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "CloudModel.h"


@implementation CloudModel

+ (instancetype)sharedCloudManager
{
    static CloudModel *sharedCloudManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedCloudManager = [[self alloc] init];
    });
    return sharedCloudManager;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.container = [CKContainer defaultContainer];
        self.publicDataBase = self.container.publicCloudDatabase;
        self.userInfo = [[UserInfo alloc] initWithContainer:self.container];
    }
    return self;
}

- (void)requestUsers
{
    CKQuery* query = [[CKQuery alloc] initWithRecordType:@"User" predicate:[NSPredicate predicateWithFormat:@"TRUEPREDICATE"]];
    [self.publicDataBase performQuery:query inZoneWithID:nil completionHandler:[self completionHandlerForType:@"User"]];
}

- (void)requestConversations
{
    CKQuery* query = [[CKQuery alloc] initWithRecordType:@"Conversation" predicate:[NSPredicate predicateWithFormat:@"TRUEPREDICATE"]];
    [self.publicDataBase performQuery:query inZoneWithID:nil completionHandler:[self completionHandlerForType:@"Conversation"]];
}

- (void)requestMessages
{
    CKQuery* query = [[CKQuery alloc] initWithRecordType:@"Message" predicate:[NSPredicate predicateWithFormat:@"TRUEPREDICATE"]];
    [self.publicDataBase performQuery:query inZoneWithID:nil completionHandler:[self completionHandlerForType:@"Conversation"]];
}

- (id)completionHandlerForType:(NSString*)type
{
    return ^(NSArray *results, NSError *error) {
        if (error)
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate errorUpdating:error dataType:type];
            });
        }
        else
        {
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.delegate modelUpdated:results dataType:type];
            });
        }
    };
}

@end
