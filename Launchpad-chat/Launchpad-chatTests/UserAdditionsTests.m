//
//  UserAdditionsTests.m
//  Launchpad-chat
//
//  Created by STUDENT #1 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "User+Additions.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>


@interface UserAdditionsTests : XCTestCase

@property (nonatomic, strong) NSManagedObjectContext* context;

@end

@implementation UserAdditionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //Setup our Context
    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] testingManagedObjectContext];
    
    NSLog(@"Context = %@",self.context);
    
    [self.context performBlockAndWait:^{
        
        User* newUser = [[User alloc] initWithEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context] insertIntoManagedObjectContext:self.context];
        newUser.name = @"test1";
        newUser.onlineStatus = @YES;
        
    }];

    [self.context save:nil];
    
    //Create a couple Users
        //Create 3 users that have recentUploads
    
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];

    [self.context performBlockAndWait:^{
        NSFetchRequest* fr = [NSFetchRequest fetchRequestWithEntityName:@"User"];
        NSArray* allUsers = [self.context executeFetchRequest:fr error:nil];
        for (User* user in allUsers)
        {
            [self.context deleteObject:user];
        }
        [self.context save:nil];
    }];
}

- (void)testUserNameFetchRequest
{
    
    NSError* error = nil;
    
    NSArray* users = [self.context executeFetchRequest:[User requestUserWithName:@"test1"] error:&error];
    
    
    XCTAssert(error == nil, @"Error requesting users = %@",[error localizedDescription]);
    XCTAssert(users.count == 1, @"Users should be equal to 1");
}

- (void)testUserFetchRequest
{

    NSError* error = nil;
    
    NSArray* users = [self.context executeFetchRequest:[User requestUsersWithRecentUploads] error:&error];
    
    XCTAssert(error == nil, @"Error requesting users = %@",[error localizedDescription]);
    XCTAssert(users.count == 3, @"Users should be equal to 3");
}




- (void)testExample {
    // This is an example of a functional test case.
    XCTAssert(YES, @"Pass");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
