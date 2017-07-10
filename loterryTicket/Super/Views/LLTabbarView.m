//
//  LLTabbarView.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/18.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLTabbarView.h"

@interface LLTabbarView()
@property (weak, nonatomic) IBOutlet UIButton *hotButton;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (weak, nonatomic) IBOutlet UIButton *ownButton;

@property (weak, nonatomic) IBOutlet UILabel *hotLabel;
@property (weak, nonatomic) IBOutlet UILabel *hotDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *midLabel;
@property (weak, nonatomic) IBOutlet UILabel *midDetailLabel;

@property (weak, nonatomic) IBOutlet UILabel *ownLabel;
@property (weak, nonatomic) IBOutlet UILabel *myDetailLabel;


@end

@implementation LLTabbarView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.hotLabel.font = [UIFont fontWithName:@"iconfont" size:36];
    self.hotLabel.text = @"\U0000e63a";
    self.hotLabel.textColor = MainColor;
    self.hotDetailLabel.textColor = MainColor;
    self.midLabel.font = [UIFont fontWithName:@"iconfont" size:36];
    self.midLabel.text = @"\U0000e60d";
    self.ownLabel.font = [UIFont fontWithName:@"iconfont" size:36];
    self.ownLabel.text = @"\U0000e602";
}



- (IBAction)tabBarClick:(UIButton *)sender {
    NSInteger index = sender.tag - 100;
    [self setSelectIndex:index];
}

- (void)setSelectIndex:(NSInteger)index{
    if (index == _selectIndex) {
        return;
    }
    
    UIButton *button = [self viewWithTag:100 + _selectIndex];
    if (button) {
        button.selected = NO;
    }
    
    _selectIndex = index;
    button = [self viewWithTag:100 + _selectIndex];
    if (button) {
        button.selected = YES;
    }
    
    self.hotLabel.textColor = [UIColor whiteColor];
    self.hotDetailLabel.textColor = [UIColor whiteColor];
    self.midLabel.textColor = [UIColor whiteColor];
    self.midDetailLabel.textColor = [UIColor whiteColor];
    self.ownLabel.textColor = [UIColor whiteColor];
    self.myDetailLabel.textColor = [UIColor whiteColor];
    //改变选中颜色
    switch (index) {
        case 0:
        {
            self.hotLabel.textColor = MainColor;
            self.hotDetailLabel.textColor = MainColor;
            
            self.midLabel.textColor = [UIColor whiteColor];
            self.midDetailLabel.textColor = [UIColor whiteColor];
            self.ownLabel.textColor = [UIColor whiteColor];
            self.myDetailLabel.textColor = [UIColor whiteColor];
        }
            break;
            case 1:
        {
            self.midLabel.textColor = MainColor;
            self.midDetailLabel.textColor = MainColor;
        }
            break;
            case 2:
        {
            self.ownLabel.textColor = MainColor;
            self.myDetailLabel.textColor = MainColor;
        }
            break;
            
        default:
            break;
    }
    
    
    if (self.tabBarDelegate && [self.tabBarDelegate respondsToSelector:@selector(tabbarView:didSelectAtIndex:)]) {
        [self.tabBarDelegate tabbarView:self didSelectAtIndex:_selectIndex];
    }
}

@end
