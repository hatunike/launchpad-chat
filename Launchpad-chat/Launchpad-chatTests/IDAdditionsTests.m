//
//  IDAdditionsTests.m
//  Launchpad-chat
//
//  Created by STUDENT #5 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import <CoreData/CoreData.h>
#import "ID+Additions.h"
#import "AppDelegate.h"

@interface IDAdditionsTests : XCTestCase

@property (nonatomic, strong) NSManagedObjectContext *context;

@end

@implementation IDAdditionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //Setup Context
    self.context = [(AppDelegate *)[[UIApplication sharedApplication] delegate] testingManagedObjectContext];
    NSLog(@"Context = %@", self.context);
    
    //Add ID's
    [self.context performBlockAndWait:^{
        ID *newID = [[ID alloc] initWithEntity:[NSEntityDescription entityForName:@"ID" inManagedObjectContext:self.context] insertIntoManagedObjectContext:self.context];
        newID.identifier = @"test1";
        newID.identifier = @"test2";
    }];
    
    [self.context save:nil];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
    
    [self.context performBlockAndWait:^{
       
        NSFetchRequest *fr = [NSFetchRequest fetchRequestWithEntityName:@"ID"];
        NSArray *allIDs = [self.context executeFetchRequest:fr error:nil];
        for (ID *userID in allIDs)
        {
            [self.context deleteObject:userID];
        }
        [self.context save:nil];
    }];
}

- (void)testUserIDFetchRequest
{
    NSError *error = nil;
    
    NSArray *ids = [self.context executeFetchRequest:[ID requestUserID] error:&error];
    
    XCTAssert(error == nil, @"Error requesting users = %@", [error localizedDescription]);
    XCTAssert(ids.count == 2, @"Users should be equal to 2");
}

@end
