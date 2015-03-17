//
//  PendingOperations.h
//  Launchpad-chat
//
//  Created by Charles Hart on 3/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ImportOperation.h"

@interface PendingOperations : NSObject

@property (nonatomic, strong) NSOperationQueue* importQueue;
@property (nonatomic, strong) NSMutableDictionary* importsInProgress;

- (void)startImportOperation:(ImportOperation*)operation withIdentifier:(NSString*)identifer;

@end
