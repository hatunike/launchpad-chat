//
//  ID.h
//  Launchpad-chat
//
//  Created by STUDENT #5 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Avatar;

@interface ID : NSManagedObject

@property (nonatomic, retain) NSString * identifier;
@property (nonatomic, retain) NSManagedObject *userName;
@property (nonatomic, retain) NSManagedObject *status;
@property (nonatomic, retain) Avatar *picture;
@property (nonatomic, retain) NSManagedObject *conversations;

@end
