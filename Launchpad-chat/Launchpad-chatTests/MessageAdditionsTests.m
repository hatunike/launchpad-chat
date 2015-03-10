//
//  MessageAdditionsTests.m
//  Launchpad-chat
//
//  Created by STUDENT #1 on 3/3/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "Message+Additions.h"
#import "Conversation+Additions.h"
#import "User+Additions.h"
#import "AppDelegate.h"
#import <CoreData/CoreData.h>

@interface MessageAdditionsTests : XCTestCase

@property (nonatomic, strong) NSManagedObjectContext* context;

@end

@implementation MessageAdditionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //Setup our Context
    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] testingManagedObjectContext];
    
    NSLog(@"Context = %@",self.context);

    User *newUser1 = [User createUserWithName:@"User1" onlineStatus:YES inContext:self.context];
    
    User *newUser2 = [User createUserWithName:@"User2" onlineStatus:YES inContext:self.context];
    
    Conversation *newConversation1 = [Conversation createConvertationWithUser1:newUser1 AndUser2:newUser2 lastMessage:[NSDate dateWithTimeIntervalSince1970:0] inContext:self.context];
    
    Message *newMessage1 = [Message createMessageWithText:@"testing" onDate:[NSDate dateWithTimeIntervalSince1970:0] fromUser:newUser1 inConversation:newConversation1 withState:YES inContext:self.context];

    
    [self.context save:nil];
    
    
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
        //[self.context save:nil];
        
        NSFetchRequest* fr2 = [NSFetchRequest fetchRequestWithEntityName:@"Message"];
        NSArray* allMessages = [self.context executeFetchRequest:fr2 error:nil];
        for (Message* message in allMessages)
        {
            [self.context deleteObject:message];
        }
        //[self.context save:nil];
        
        NSFetchRequest* fr3 = [NSFetchRequest fetchRequestWithEntityName:@"Conversation"];
        NSArray* allConversations = [self.context executeFetchRequest:fr3 error:nil];
        for (Conversation* conversation in allConversations)
        {
            [self.context deleteObject:conversation];
        }
        [self.context save:nil];
    }];
}

- (void)testMessageFetchRequest
{
    NSError *error = nil;
    
    NSArray *messages = [self.context executeFetchRequest:[Message requestMessagesFromUser:@"User1"] error:&error];
    
    XCTAssert(error == nil, @"Error requesting Message = %@",[error localizedDescription]);
    XCTAssert(messages.count == 1, @"Messages should be equal to 1");
    
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
