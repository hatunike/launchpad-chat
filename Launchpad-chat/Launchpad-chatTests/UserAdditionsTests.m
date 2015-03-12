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
@property (nonatomic, strong) User *user1;

@end

@implementation UserAdditionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //Setup our Context
    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] testingManagedObjectContext];
    
    NSLog(@"Context = %@",self.context);
    
    [self.context performBlockAndWait:^{
        
        self.user1 = [[User alloc] initWithEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context] insertIntoManagedObjectContext:self.context];
        self.user1.name = @"testA";
        self.user1.onlineStatus = @YES;
        self.user1.lastUploadDate = [NSDate dateWithTimeIntervalSinceNow:0]; //Exactly Now and online #1 by date
        
        User* newUser2 = [[User alloc] initWithEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context] insertIntoManagedObjectContext:self.context];
        newUser2.name = @"Beta";
        newUser2.onlineStatus = @NO;
        newUser2.lastUploadDate = [NSDate dateWithTimeIntervalSinceNow:-30]; //Thirty Seconds ago and offline #3 by date
        
        User* newUser3 = [[User alloc] initWithEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context] insertIntoManagedObjectContext:self.context];
        newUser3.name = @"testB";
        newUser3.onlineStatus = @YES;
        newUser3.lastUploadDate = [NSDate dateWithTimeIntervalSinceNow:-20]; //Twenty Seconds ago and online #2 by date
        
        User* newUser4 = [[User alloc] initWithEntity:[NSEntityDescription entityForName:@"User" inManagedObjectContext:self.context] insertIntoManagedObjectContext:self.context];
        newUser4.name = @"Alpha";
        newUser4.onlineStatus = @NO;
        newUser4.lastUploadDate = [NSDate dateWithTimeIntervalSinceNow:-40]; //Forty Seconds ago and offline #4 by date
        
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

- (void)testChangeUserStatus
{
    [User changeStatusOf:self.user1 inContext:self.context];
    
    User *user = [User requestUserWithName:self.user1.name inContext:self.context];
    
    XCTAssert([user.name isEqualToString:@"testA"], @"User name should be UserName");
    XCTAssert([user.onlineStatus  isEqualToNumber:[NSNumber numberWithBool:NO]], @"OnlineStatus should be NO");
}

- (void)testUserNameFetchRequest
{
    User *user = [User requestUserWithName:@"testA" inContext:self.context];
    
    XCTAssert([user isKindOfClass:[User class]], @"User should be of class User");
}

- (void)testCurrentUserNotIncluded //Same fetch request as testUserSortByOnlineStatusAndLastUploadDate but passing testA as current user
{
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:[User requestUsersOrderedByStatusAndLastUploadDateWithoutCurrentUser:@"testA"] error:&error];
    
    XCTAssert(error == nil, @"Error requesting users = %@", [error localizedDescription]);
    XCTAssert(![[users[0] name] isEqualToString:@"testA"], @"users should be sorted by status THEN lastUploadDate");
}

- (void)testUserSortByOnlineStatusAndLastUploadDate
{
    NSError *error;
    NSArray *users = [self.context executeFetchRequest:[User requestUsersOrderedByStatusAndLastUploadDateWithoutCurrentUser:@"name"] error:&error];
    
    XCTAssert(error == nil, @"Error requesting users = %@", [error localizedDescription]);
    XCTAssert([[users[0] name] isEqualToString:@"testA"], @"users should be sorted by status THEN lastUploadDate");
    XCTAssert([[users[1] name] isEqualToString:@"testB"], @"users should be sorted by status THEN lastUploadDate");
    XCTAssert([[users[2] name] isEqualToString:@"Beta"], @"users should be sorted by status THEN lastUploadDate");
    XCTAssert([[users[3] name] isEqualToString:@"Alpha"], @"users should be sorted by status THEN lastUploadDate");
}

- (void)testAllUsersSortedByStatusAndName
{
    NSError* error = nil;
    
    NSArray* users = [self.context executeFetchRequest:[User requestUsersOrderedByStatusAndNameWithoutCurrentUser:nil] error:&error];
    
    XCTAssert([[users[0] name] isEqualToString:@"testA"], @"users should be sorted by status THEN name");
    XCTAssert([[users[1] name] isEqualToString:@"testB"], @"users should be sorted by status THEN name");
    XCTAssert([[users[2] name] isEqualToString:@"Alpha"], @"users should be sorted by status THEN name");
    XCTAssert([[users[3] name] isEqualToString:@"Beta"], @"users should be sorted by status THEN name");
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
