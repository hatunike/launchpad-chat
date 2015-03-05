//
//  UIUserTableViewCell.h
//  Launchpad-chat
//
//  Created by Marchelle Lundquist on 3/3/15.
//  Copyright (c) 2015 lernu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OnlineStatusView.h"
#import "ProfilePicturesImageView.h"

@interface UIUserTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet ProfilePicturesImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *latestMessageTextLabel;
@property (weak, nonatomic) IBOutlet OnlineStatusView *userStatusCircleView;


//Color Scheme
//Purple/red color: A90196
//Muted greenish blue color: 24B3B8
//

@end
