//
//  PendingOperations.m
//  Launchpad-chat
//
//  Created by Charles Hart on 3/17/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "PendingOperations.h"


@implementation PendingOperations

- (void)startImportOperation:(ImportOperation*)operation withIdentifier:(NSString*)identifer
{
    if ([operation isEqual:self.importsInProgress[identifer]])
    {
        return;
    }
    
    [operation setCompletionBlock:^{
        NSLog(@"Successfully imported users!");
        [self.importsInProgress removeObjectForKey:identifer];
    }];
    
    [self.importsInProgress setObject:operation forKey:identifer];
    
    [self.importQueue addOperation:operation];
}

- (NSOperationQueue*)importQueue
{
    if (!_importQueue)
    {
        _importQueue = [[NSOperationQueue alloc] init];
        _importQueue.maxConcurrentOperationCount = 5;
        _importQueue.name = @"CloudKit Import Operation";
    }
    return _importQueue;
}

@end
