//
//  ProfilePictureImageView.m
//  Launchpad-chat
//
//  Created by STUDENT #6 on 2/26/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "ProfilePictureImageView.h"

@implementation ProfilePictureImageView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)setCornerRadius:(CGFloat)cornerRadius
{
    self.layer.cornerRadius = cornerRadius;
    _cornerRadius = cornerRadius;
}


@end
