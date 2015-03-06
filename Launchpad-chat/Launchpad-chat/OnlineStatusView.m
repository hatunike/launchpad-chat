//
//  OnlineStatusView.m
//  Launchpad-chat
//
//  Created by STUDENT #6 on 2/26/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import "OnlineStatusView.h"

@implementation OnlineStatusView

- (void)setIs_circle:(BOOL) is_Circle
{
    self.layer.cornerRadius = self.frame.size.width/2;
    self.backgroundColor = [UIColor redColor];
    _is_circle = is_Circle;
}

- (void)setIs_online:(BOOL)is_online
{
    if (is_online == YES)
    {
        self.backgroundColor = [UIColor greenColor];
    }
    else
    {
        self.backgroundColor = [UIColor redColor];
    }
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
