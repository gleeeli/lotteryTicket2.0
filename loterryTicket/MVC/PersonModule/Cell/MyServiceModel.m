//
//  MyServiceModel.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "MyServiceModel.h"

@implementation MyServiceModel
- (instancetype)initWithTitle:(NSString *)title backColor:(UIColor *)color iconText:(NSString *)iconText
{
    self = [super init];
    if (self)
    {
        self.backColor = color;
        self.iconText = iconText;
        self.contentText = title;
    }
    return self;
}
@end
