//
//  SuperVC.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/18.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "SuperVC.h"

@interface SuperVC ()

@end

@implementation SuperVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (ISIOS7)
    {
        //        self.tabBarController.tabBar.translucent = NO;
        self.edgesForExtendedLayout = UIRectEdgeNone;
        self.extendedLayoutIncludesOpaqueBars = NO;
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


/**
 *  集成刷新控件
 */
- (void)setupRefresh:(UIScrollView *)scrollView
  withHeaderCallBack:(void (^)())headerCallback
   andFooterCallback:(void (^)())footerCallBack
{
    [self addHeader:scrollView withCallback:headerCallback];
    [self addFooter:scrollView withCallback:footerCallBack];
}

- (void)addHeader:(UIScrollView *)scrollView
     withCallback:(void (^)())callback
{
    _scrollView = scrollView;
    
    // 设置文字(也可以不设置,默认的文字在MJRefreshConst中修改)
    
    //    _scrollView.headerPullToRefreshText = @"下拉可以刷新了";
    //    _scrollView.headerReleaseToRefreshText = @"松开马上刷新了";
    //    _scrollView.headerRefreshingText = @"游视秀正在帮你刷新中...";
    //    _scrollView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:callback];
    //    if (callback) {
    //        [_scrollView addHeaderWithCallback:callback];
    //    }
    //
    
    MJRefreshHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:callback];
    
    /*
     // 设置普通状态的动画图片
     NSMutableArray *idleImages = [NSMutableArray array];
     for (NSUInteger i = 1; i<=60; i++) {
     UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
     [idleImages addObject:image];
     }
     
     [header setImages:idleImages forState:MJRefreshStateIdle];
     
     // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
     NSMutableArray *refreshingImages = [NSMutableArray array];
     for (NSUInteger i = 1; i<=3; i++) {
     UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
     [refreshingImages addObject:image];
     }
     [header setImages:refreshingImages forState:MJRefreshStatePulling];
     
     // 设置正在刷新状态的动画图片
     [header setImages:refreshingImages forState:MJRefreshStateRefreshing];
     //*/
    
    _scrollView.header = header;
}

- (void)addFooter:(UIScrollView *)scrollView
     withCallback:(void (^)())callback
{
    _scrollView = scrollView;
    
    
    MJRefreshBackNormalFooter *footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:callback];
    
    /*
     // 设置普通状态的动画图片
     NSMutableArray *idleImages = [NSMutableArray array];
     for (NSUInteger i = 1; i<=60; i++) {
     UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_anim__000%zd", i]];
     [idleImages addObject:image];
     }
     
     [footer setImages:idleImages forState:MJRefreshStateIdle];
     
     // 设置即将刷新状态的动画图片（一松开就会刷新的状态）
     NSMutableArray *refreshingImages = [NSMutableArray array];
     for (NSUInteger i = 1; i<=3; i++) {
     UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"dropdown_loading_0%zd", i]];
     [refreshingImages addObject:image];
     }
     [footer setImages:refreshingImages forState:MJRefreshStatePulling];
     
     // 设置正在刷新状态的动画图片
     [footer setImages:refreshingImages forState:MJRefreshStateRefreshing];
     
     // 隐藏状态
     //    footer.stateLabel.hidden = YES;
     
     //*/
    
    _scrollView.footer = footer;
    
}

- (void)endRefreshing
{
    [_scrollView.header endRefreshing];
    [_scrollView.footer endRefreshing];
}

- (void)backToSuperView
{
    // 取消网络请求
    [self.view endEditing:YES];
    
    if (self.navigationController.viewControllers.firstObject == self)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else
    {
        if (self.presentedViewController)
        {
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        else
        {
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
