//
//  PersonInfoTableViewCell.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "PersonInfoTableViewCell.h"

@interface PersonInfoTableViewCell ()<UITextFieldDelegate>

@end

@implementation PersonInfoTableViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.contentTextField.delegate = self;
    self.contentTextField.borderStyle = UITextBorderStyleNone;
//    self.isEdit = NO;
}

//- (void)setIsEdit:(BOOL)isEdit
//{
//    _isEdit = isEdit;
//    
//    if (isEdit)
//    {
//        self.contentTextField.borderStyle = UITextBorderStyleRoundedRect;
//    }
//    else
//    {
//        self.contentTextField.borderStyle = UITextBorderStyleNone;
//    }
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
//    self.isEdit = YES;
    return YES;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
//    self.isEdit = NO;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(textfieldChange:)])
    {
        [self.delegate textfieldChange:self];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
