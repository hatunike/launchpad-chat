//
//  UserInfo.h
//  Launchpad-chat
//
//  Created by Charles Hart on 3/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CloudKit;

@interface UserInfo : NSObject


@property (nonatomic, strong) CKContainer* container;
@property (nonatomic, strong) CKRecordID* userRecordID;

- (instancetype)initWithContainer:(CKContainer*)container;

@end
