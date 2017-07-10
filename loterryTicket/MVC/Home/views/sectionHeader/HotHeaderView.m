//
//  HotHeaderView.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "HotHeaderView.h"

@interface HotHeaderView ()
@property (weak, nonatomic) IBOutlet UIImageView *headerTag;
@property (weak, nonatomic) IBOutlet UILabel *headerTitle;
@property (weak, nonatomic) IBOutlet UIButton *actionBtn;

@property (nonatomic,copy) clickMoreBlock action;
@end

@implementation HotHeaderView
+ (id)initWithFrameByXib:(CGRect)frame{
    
    HotHeaderView *headerView = [[[NSBundle mainBundle] loadNibNamed:@"HotHeaderView" owner:nil options:nil] firstObject];
    headerView.frame=frame;
    
    return headerView;
}

- (void)setIconType:(LLSectionHeaderIconType)iconType title:(NSString *)title action:(clickMoreBlock)action{
    
    self.headerTitle.text=title;
    self.action=action;
    
    [self setHeaderTagView:iconType];
    
    [self setActionButton:iconType];
}


- (void)setHeaderTagView:(LLSectionHeaderIconType)iconType{
    
    if (iconType==LLSectionHeaderIconTypeHot) {
//        self.headerTag.image=nil;
    }else if (iconType==LLSectionHeaderIconTypeOriginal) {
//        self.headerTag.image= nil;
    }else{
        self.headerTag.image=nil;
    }
}

- (void)setActionButton:(LLSectionHeaderIconType)iconType{
    
    if (iconType==LLSectionHeaderIconTypeOriginal) {
        [self.actionBtn setTitle:@"换一批" forState:UIControlStateNormal];
        [self.actionBtn setImage:[UIImage imageNamed:@"livelist_section_refresh"] forState:UIControlStateNormal];
        self.actionBtn.hidden = YES;
    }else{
        self.actionBtn.hidden = YES;
        [self.actionBtn setTitle:@"更多" forState:UIControlStateNormal];
        [self.actionBtn setImage:[UIImage imageNamed:@"videolist_header_more"] forState:UIControlStateNormal];
    }
}



- (IBAction)moreBtnClick:(UIButton *)sender {
    
    if (self.action) {
        self.action();
    }
}

@end
