//
//  LLItemCell.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLBaseCollectionViewCell.h"
#import "LLItemModel.h"

@interface LLItemCell : LLBaseCollectionViewCell

+ (CGSize)cellSizetByWidth:(CGFloat)width;

- (void)cellWithModel:(NSObject*)model;

@end
