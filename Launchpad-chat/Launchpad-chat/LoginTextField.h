//
//  LoginTextField.h
//  Launchpad-chat
//
//  Created by STUDENT #6 on 2/24/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface LoginTextField : UITextField

@property (nonatomic, strong) IBInspectable UIColor* borderColor;
@property (nonatomic) IBInspectable CGFloat borderWidth;
@property (nonatomic) IBInspectable CGFloat cornerRadius;

@end
