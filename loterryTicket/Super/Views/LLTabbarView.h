//
//  LLTabbarView.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/18.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LLTabbarView;
@protocol LLTabbarViewDelegate <NSObject>

- (void)tabbarView:(LLTabbarView *)tabbarView
  didSelectAtIndex:(NSInteger)index;
@end

@interface LLTabbarView : UIView{
    NSInteger _selectIndex;
}

@property (nonatomic, weak) id<LLTabbarViewDelegate> tabBarDelegate;
@end

