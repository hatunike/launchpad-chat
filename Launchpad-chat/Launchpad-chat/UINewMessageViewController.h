//
//  UINewMessageViewController.h
//  Launchpad-chat
//
//  Created by STUDENT #6 on 2/19/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Message.h"

@interface UINewMessageViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *conversationToUsernameField;
@property (weak, nonatomic) IBOutlet UITextField *messageFieldToNewConversation;
@property (weak, nonatomic) IBOutlet UIButton *sendNewMessageButton;

@property (weak, nonatomic) NSManagedObjectContext *context;

- (BOOL)sendNewMessage:(NSString*)newMessage toUser:(NSString *)username;

@end
