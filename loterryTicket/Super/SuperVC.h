//
//  SuperVC.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/18.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CommHeader.h"

@interface SuperVC : UIViewController{
@public
    UIScrollView *_scrollView;
}

/**
 *  集成刷新控件
 */
- (void)setupRefresh:(UIScrollView *)scrollView
  withHeaderCallBack:(void (^)())headerCallback
   andFooterCallback:(void (^)())footerCallBack;

- (void)addHeader:(UIScrollView *)scrollView
     withCallback:(void (^)())callback;

- (void)addFooter:(UIScrollView *)scrollView
     withCallback:(void (^)())callback;

- (void)endRefreshing;

- (void)backToSuperView;

@end
