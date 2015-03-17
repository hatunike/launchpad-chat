//
//  ImportOperation.h
//  Launchpad-chat
//
//  Created by Charles Hart on 3/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;
@import CloudKit;

@interface ImportOperation : NSOperation

- (instancetype)initWithRecordsToImport:(NSArray*)records forEntityType:(NSString*)entityType parentContext:(NSManagedObjectContext*)context;

@end
