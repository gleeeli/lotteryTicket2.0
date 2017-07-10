//
//  MyServiceTableViewCell.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "MyServiceTableViewCell.h"

@implementation MyServiceTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.headImageView.layer.cornerRadius = self.headViewWidthConstraint.constant * 0.5;
    self.headImageView.layer.masksToBounds = YES;
    
    self.leftIconLabel.font = [UIFont fontWithName:@"iconfont" size:20];
    self.leftIconLabel.layer.cornerRadius = 3.0;
    self.leftIconLabel.layer.masksToBounds = YES;
    
    self.rightIconLabel.font = [UIFont fontWithName:@"iconfont" size:20];
    self.rightIconLabel.text = @"\U0000e694";
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

}

@end
