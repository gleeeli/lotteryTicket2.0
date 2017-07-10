//
//  LLBannerModule.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLBannerModule.h"
#import "CPImageRunView.h"
#import "LLBannerModel.h"

@implementation LLBannerModule

+ (id)initWithViewWidth:(CGFloat)width{
    //宽高比为 16:9  用父类属性记住frame
    LLBannerModule *module=[[LLBannerModule alloc] initWithViewFrame:CGRectMake(0, 0, width, width/16.0*9.0)];
    return module;
}

//多态返回属性标识
- (NSString *)moduleIdent{
    return @"LLBannerModule";
}

//关联modle和内部view
- (void)addModuleViewToSuperView:(UIView*)superView{
    if (self.moduleView) {
        return;
    }
    
    //initView
    [superView layoutIfNeeded];
    self.moduleView=[LLBannerView initViewWithFrame:CGRectMake(0, 0, self.moduleViewSize.width,self.moduleViewSize.height)];
    [superView addSubview:self.moduleView];
    
    //data
    [self getDataFromServer];
}

#pragma mark --- 数据
- (void)getDataFromServer{
    
   //添加假数据
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<3; i++) {
        LLBannerModel *model = [[LLBannerModel alloc]init];
        model.adImageUrl = @"http://imgsrc.baidu.com/imgad/pic/item/caef76094b36acaf0accebde76d98d1001e99ce7.jpg";
        [array addObject:model];
    }
    
    //刷新模块内部的view
    [self.moduleView updateModuleDatas:[array mutableCopy]];
    
}

#pragma mark LLModuleAdapter
- (void)reloadModuleData{
    [self getDataFromServer];
}


@end

//模块内部view
@interface LLBannerView ()<CPImageRunViewDelegate>

@property (nonatomic,strong) CPImageRunView *runBannerView;
@property (nonatomic,strong) NSArray <LLBannerModel *>*dataList;

@end

@implementation LLBannerView

+ (id)initViewWithFrame:(CGRect)frame{
    
    LLBannerView *view=[[LLBannerView alloc] initWithFrame:frame];
    //添加环形view
    view.runBannerView=[[CPImageRunView alloc] initWithFrame:frame];
    view.runBannerView.size=frame.size;
    view.runBannerView.delegate=view;
    view.runBannerView.placeholderImage = [UIImage imageNamed:@"defaultBanner"];
    [view addSubview:view.runBannerView];
    
    return view;
}

#pragma mark 分类方法
- (void)updateModuleDatas:(NSArray *)datalist{
    
    self.dataList=datalist;
    
    NSMutableArray *imageList = [NSMutableArray array];
    for (LLBannerModel *item in self.dataList) {
        NSString *imageUrl = item.adImageUrl;
        if (!item.adImageUrl) {
            imageUrl = @"";
        }
        [imageList addObject:imageUrl];
    }
    //环形显示图片数组加入
    self.runBannerView.images=[imageList copy];
    
    [self.runBannerView run];
}

//滚动scorllview 选中某个
- (void)imageRunView:(CPImageRunView*)view didSelectedIndex:(NSInteger)index{
    NSLog(@"点击:%d",(int)index);
    LLBannerModel *bannerModel;
    if (index < self.dataList.count) {
        bannerModel = self.dataList[index];
    }
    
    
//    if (![YSXHelper isNull:bannerModel.adUrl]) {
//        YSXWebViewController *webVC=[YSXWebViewController webViewControllerWithUrl:bannerModel.adUrl];
//        [[AppDelegate shareAppDelegate].ysxNavigationController pushViewController:webVC animated:YES];
//    }else{
//        [YSXMessageHint showToolMessage:@"没有相关内容!" hideAfter:2.0 yOffset:0 parentView:nil];
//    }
    
}

@end
