//
//  ConversationAdditionsTests.m
//  Launchpad-chat
//
//  Created by STUDENT #5 on 3/5/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "AppDelegate.h"
#import "User+Additions.h"
#import "Message+Additions.h"
#import "Conversation+Additions.h"

@interface ConversationAdditionsTests : XCTestCase

@property (nonatomic, strong) NSManagedObjectContext *context;
@property (nonatomic, strong) User *user1;
@property (nonatomic, strong) User *user2;
@property (nonatomic, strong) User *user3;
@property (nonatomic, strong) User *user4;
@property (nonatomic, strong) Conversation *nConversation1;
@property (nonatomic, strong) Conversation *nConversation2;
@property (nonatomic, strong) Conversation *nConversation3;
@property (nonatomic, strong) Message *message1;
@property (nonatomic, strong) Message *message2;
@property (nonatomic, strong) Message *message3;
@property (nonatomic, strong) Message *message4;

@end

@implementation ConversationAdditionsTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
    
    //Setup our Context
    self.context = [(AppDelegate*)[[UIApplication sharedApplication] delegate] testingManagedObjectContext];
    
    NSLog(@"Context = %@",self.context);
    
    self.user1 = [User createUserWithName:@"User1" onlineStatus:YES inContext:self.context];
    
    self.user2 = [User createUserWithName:@"User2" onlineStatus:YES inContext:self.context];
    
    self.user3 = [User createUserWithName:@"User3" onlineStatus:YES inContext:self.context];
    
    self.user4 = [User createUserWithName:@"User4" onlineStatus:YES inContext:self.context];
    
    
    //conversation1 between user1 and user2
    self.nConversation1 = [Conversation createConvertationWithUser1:self.user1 AndUser2:self.user2 lastMessage:[NSDate dateWithTimeIntervalSince1970:30] inContext:self.context];
    
    //conversation2 between user1 and user 3
    self.nConversation2 = [Conversation createConvertationWithUser1:self.user1 AndUser2:self.user3 lastMessage:[NSDate dateWithTimeIntervalSince1970:0] inContext:self.context];
    
    //conversation3 between user2 and user4
    self.nConversation3 = [Conversation createConvertationWithUser1:self.user2 AndUser2:self.user4 lastMessage:[NSDate dateWithTimeIntervalSince1970:50] inContext:self.context];
    
    
    //message from user1 in conversation 1
    self.message1 = [Message createMessageWithText:@"testing1" onDate:[NSDate dateWithTimeIntervalSince1970:0] fromUser:self.user1 inConversation:self.nConversation1 withState:YES inContext:self.context];
    
    //message from user2 in conversation3
    self.message2 = [Message createMessageWithText:@"testing2" onDate:[NSDate dateWithTimeIntervalSince1970:0] fromUser:self.user2 inConversation:self.nConversation3 withState:YES inContext:self.context];
    
    //message from user3 in conversation2
    self.message3 = [Message createMessageWithText:@"testing3" onDate:[NSDate dateWithTimeIntervalSince1970:0] fromUser:self.user3 inConversation:self.nConversation2 withState:YES inContext:self.context];
    
    //message from user4 in conversation3
    self.message4 = [Message createMessageWithText:@"testing3" onDate:[NSDate dateWithTimeIntervalSince1970:0] fromUser:self.user4 inConversation:self.nConversation3 withState:YES inContext:self.context];
    
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

- (void)testsConversationFetchRequestWithTwoUsers
{
    NSError *error = nil;
    NSArray *conversations = [self.context executeFetchRequest:[Conversation requestConversationWithTwoUsers:self.user1 AndUser2:self.user2] error:&error];
    
    //Check fetch request
    XCTAssert(error == nil, @"Error requesting conversation = %@", [error localizedDescription]);
    XCTAssert(conversations.count == 1, @"Conversation count should be 1");
    
    //Check to see if conversation is a Conversation
    Conversation* conversation = conversations[0];
    XCTAssert([conversation isKindOfClass:[Conversation class]], @"conversation should be a Conversation object");
    
    //Check User count
    NSSet *users = conversation.user;
    XCTAssert(users.count == 2, @"User count on conversation should equal 2");
    
    //Check Users
    XCTAssert([users containsObject:self.user1], @"Conversation should contain user1");
    XCTAssert([users containsObject:self.user2], @"Conversation should contain user2");
    
    //Check messages for created message
    NSSet *messages = conversation.messages;
    XCTAssert([messages containsObject:self.message1], @"Messages should contain message 'Testing'");
}

-(void)testRequestConversationsForUser
{
    NSError *error = nil;
    NSArray *conversations = [self.context executeFetchRequest:[Conversation requestConversationsForUser:self.user1] error:&error];
    
    //Check fetch request
    XCTAssert(error == nil, @"Error requesting conversation = %@", [error localizedDescription]);
    XCTAssert(conversations.count == 2, @"Conversation count should be 2");
    
    //Check to see if conversation is a Conversation
    Conversation* conversation1 = conversations[0];
    XCTAssert([conversation1 isKindOfClass:[Conversation class]], @"conversation should be a Conversation object");
    Conversation* conversation2 = conversations[1];
    XCTAssert([conversation2 isKindOfClass:[Conversation class]], @"conversation should be a Conversation object");
    
    //Check if conversations are sorted by lastMessageDate
    
    
}

@end
