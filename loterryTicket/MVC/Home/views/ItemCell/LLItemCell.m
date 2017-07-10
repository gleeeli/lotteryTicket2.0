//
//  LLItemCell.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLItemCell.h"
#import "LLItemModel.h"

@interface LLItemCell()
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;

@property (weak, nonatomic) IBOutlet UILabel *descriptLabel;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;


@end

@implementation LLItemCell

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
    self.contentView.layer.cornerRadius=5;
    self.contentView.layer.masksToBounds=YES;
    self.contentView.layer.borderWidth=1;
    self.contentView.layer.borderColor=UIColorHex(0xe5e5e5).CGColor;
//    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
//    label.font = [UIFont fontWithName:@"iconfont" size:12];
//    label.text = @"哈哈哈哈";
//    label.backgroundColor = [UIColor magentaColor];
//    
//    [self addSubview:label];
    
    
    
}

+ (CGSize)cellSizetByWidth:(CGFloat)width{
    
    return CGSizeMake(width, width*9.0/16.0+54.0);//底部标题的高度54
}

- (void)cellWithModel:(NSObject*)model{
    if ([model isKindOfClass:[LLItemModel class]]) {
       //刷新cell
        [self setItemModelUpdate:(LLItemModel *)model];
    }

}

-(void)setItemModelUpdate:(LLItemModel *)model
{
    if (model.imageName) {
//        self.typeImageView.image = [UIImage imageNamed:model.imageName];
        self.typeLabel.font = [UIFont fontWithName:@"iconfont" size:64];
        self.typeLabel.text = model.imageName;
    }
    self.descriptLabel.text = model.descript?model.descript:@"";
    self.nameLabel.text = model.title?model.title:@"";
    
    [self layoutIfNeeded];
}

@end
