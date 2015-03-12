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

@property (nonatomic, strong) Conversation *conversation1;
@property (nonatomic, strong) Message *message1;
@property (nonatomic, strong) Message *message2;
@property (nonatomic, strong) User *user1;
@property (nonatomic, strong) User *user2;

@end

@implementation MessageAdditionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //Setup our Context
    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] testingManagedObjectContext];
    
    NSLog(@"Context = %@",self.context);

    self.user1 = [User createUserWithName:@"User1" onlineStatus:YES inContext:self.context];
    
    self.user2 = [User createUserWithName:@"User2" onlineStatus:YES inContext:self.context];
    
    self.conversation1 = [Conversation createConvertationWithUser1:self.user1 AndUser2:self.user2 lastMessage:[NSDate dateWithTimeIntervalSince1970:0] inContext:self.context];
    
    self.message1 = [Message createMessageWithText:@"testing" onDate:[NSDate dateWithTimeIntervalSince1970:0] fromUser:self.user1 inConversation:self.conversation1 withState:YES inContext:self.context];
    
    self.message2 = [Message createMessageWithText:@"a message" onDate:[NSDate dateWithTimeIntervalSince1970:30] fromUser:self.user1 inConversation:self.conversation1 withState:YES inContext:self.context];

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
    XCTAssert(messages.count == 2, @"Messages should be equal to 2");
    
}

- (void)testMessageFetchRequestLatestMessageFromUser
{
    NSError *error = nil;
    
    NSArray *messages = [self.context executeFetchRequest:[Message requestLastestMessageFromUser:self.user1] error:&error];
    
    XCTAssert(error == nil, @"Error requesting Message = %@",[error localizedDescription]);
    XCTAssert(messages.count == 1, @"Messages count should be 1");
    
    //Test Message
    Message *message0 = messages[0];
    XCTAssert([message0 isKindOfClass:[Message class]], @"Message should be of class Message");
    XCTAssert([message0.text isEqualToString:@"a message"], @"Message Should contain 'Testing'"); //Mesage was created last

}

- (void)testMessageFetchRequestByConversationSortedByDate
{
    NSError *error = nil;
    
    NSArray *messages = [self.context executeFetchRequest:[Message requestMessagesOrderedByDateFromConversation:self.conversation1] error:&error];
    
    XCTAssert(messages.count == 2, @"There should be 1 conversations");
    XCTAssert([messages containsObject:self.message1], @"Messages should contain message1");
    XCTAssert([messages containsObject:self.message1], @"Messages should contain message2");
    
    //Test first message
    Message *message0 = messages[0];
    XCTAssert([message0 isKindOfClass:[Message class]], @"Message should be of class Message");
    XCTAssert([message0.text isEqualToString:@"testing"], @"Message Should contain 'Testing'"); //Mesage was created first
    
    //Test first message
    Message *message1 = messages[1];
    XCTAssert([message1 isKindOfClass:[Message class]], @"Message should be of class Message");
    XCTAssert([message1.text isEqualToString:@"a message"], @"Message Should contain 'Testing'"); //Message was created last
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
