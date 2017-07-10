//
//  MyServiceTableViewCell.h
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyServiceTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *leftIconLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *rightIconLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headViewWidthConstraint;

@end
