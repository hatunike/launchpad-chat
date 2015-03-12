//
//  ConversationTableViewController.h
//  Launchpad-chat
//
//  Created by STUDENT #4 on 2/24/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ConversationTableViewController : UIViewController < UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UILabel *userNameHeader;
@property (nonatomic, strong) NSString *userName;
@property (nonatomic, strong) NSManagedObjectContext* context;


@end
