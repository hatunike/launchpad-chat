//
//  UserPictureImageView.m
//  Launchpad-chat
//
//  Created by STUDENT #6 on 2/26/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "UserPictureImageView.h"

@implementation UserPictureImageView

- (void)setIs_circle:(BOOL) isCircle
{
    self.layer.cornerRadius = self.frame.size.width/2;
    _isCircle = isCircle;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
