//
//  MyServiceModel.h
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyServiceModel : NSObject
@property (copy, nonatomic) UIColor *backColor;
@property (copy, nonatomic) NSString *iconText;
@property (copy, nonatomic) NSString *contentText;

- (instancetype)initWithTitle:(NSString *)title backColor:(UIColor *)color iconText:(NSString *)iconText;
@end
