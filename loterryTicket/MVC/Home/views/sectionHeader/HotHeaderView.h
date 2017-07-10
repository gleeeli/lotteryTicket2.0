//
//  HotHeaderView.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLBaseModeleConst.h"

typedef void(^clickMoreBlock)();

@interface HotHeaderView : UICollectionReusableView

+ (id)initWithFrameByXib:(CGRect)frame;
- (void)setIconType:(LLSectionHeaderIconType)iconType title:(NSString *)title action:(clickMoreBlock)action;

@end
