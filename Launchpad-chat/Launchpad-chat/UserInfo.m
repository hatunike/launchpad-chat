//
//  UserInfo.m
//  Launchpad-chat
//
//  Created by Charles Hart on 3/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype)initWithContainer:(CKContainer*)container
{
    self = [super init];
    if (self)
    {
        self.container = container;
    }
    return self;
}

@end
