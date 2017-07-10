//
//  LLCommonDefine.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//
#import "UIInitMethod.h"
#import "ViewCode.h"
#import "TypeDefine.h"
#import "AppDelegate.h"
#import "UIView+Addition.h"

#ifndef LLCommonDefine_h
#define LLCommonDefine_h

/// block self
#define kSelfWeak __weak typeof(self) weakSelf = self
#define kSelfStrong __strong __typeof__(self) strongSelf = weakSelf

/// Height/Width
#define kScreenWidth        [UIScreen mainScreen].bounds.size.width
#define kScreenHeight       ([UIScreen mainScreen].bounds.size.height - 20.0)
#define kAllHeight          [UIScreen mainScreen].bounds.size.height
#define kBodyHeight         ([UIScreen mainScreen].bounds.size.height - 64.0)

// 方便写接口
#define ParamsDic dic
#define CreateParamsDic NSMutableDictionary *ParamsDic = [NSMutableDictionary dictionary]
#define DicObjectSet(obj,key) [ParamsDic setObject:obj forKey:key]
#define DicValueSet(value,key) [ParamsDic setValue:value forKey:key]

#define ISIOS7 ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) // IOS7的系统

//主线程
#define GCDMain(block)       dispatch_async(dispatch_get_main_queue(),block)

///字体的适配
#define FitFontSize(S) [UIFont systemFontOfSize:(S)*FIT_WIDTH]

///Point的适配
#define FitCGPointMake(X,Y) CGPointMake((X)*FIT_WIDTH,(Y)*FIT_HEIGHT)

///Size的适配
#define FitCGSizeMake(W,H) CGSizeMake((W)*FIT_WIDTH,(H)*FIT_HEIGHT)

/// *号字体
#define kFontSize(size) [UIFont systemFontOfSize:size]
/// *号粗体
#define kFontSizeBold(size) [UIFont boldSystemFontOfSize:size]

/// 设置颜色
#define UIColorRGB(R,G,B) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:1.0]

/// 设置颜色 示例：UIColorHex(0x26A7E8)
#define UIColorHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

/// 设置颜色与透明度 示例：UIColorHEX_Alpha(0x26A7E8, 0.5)
#define UIColorHex_Alpha(rgbValue, al) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:al]
// 主题背景色
#define kBackgroundColor UIColorRGB(238,241,241)
#define kCommongroundColor UIColorRGB(219,217,219)
/// 透明色
#define kColorClear [UIColor clearColor]

/*---------------------------  适配屏幕☟  ---------------------------*/
//frame 相关
#define LL_ORINGX(X) X.frame.origin.x
#define LL_ORINGY(Y) Y.frame.origin.y
#define LL_mmWidth(x) x.frame.size.width
#define LL_mmHeight(y) y.frame.size.height
#define LL_AUTO_ORINGX(w) (w.frame.origin.x+w.frame.size.width)
#define LL_AUTO_ORINGY(h) (h.frame.origin.y + h.frame.size.height)

#define ORIGINAL_WIDTH 320.0      //当前原型图基准iOS设备的逻辑分辨率的宽
#define ORIGINAL_HEIGHT 568.0     //当前原型图基准iOS设备的逻辑分辨率的高

///水平方向适配系数
#define FIT_WIDTH (([UIScreen mainScreen].bounds.size.width > [UIScreen mainScreen].bounds.size.height ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)/ORIGINAL_WIDTH)
///竖直方向适配系数
#define FIT_HEIGHT (([UIScreen mainScreen].bounds.size.height > [UIScreen mainScreen].bounds.size.width ? [UIScreen mainScreen].bounds.size.height : [UIScreen mainScreen].bounds.size.width)/ORIGINAL_HEIGHT)

///非图标控件frame的适配
#define FitCGRectMake(X,Y,W,H) CGRectMake((X)*FIT_WIDTH,(Y)*FIT_HEIGHT,(W)*FIT_WIDTH,(H)*FIT_HEIGHT)

///图标控件frame的适配
#define PitCGRectMake(X,Y,W,H) CGRectMake((X)*FIT_WIDTH,(Y)*FIT_HEIGHT,(W)*FIT_WIDTH,(H)*FIT_WIDTH)

///图标控件frame的适配(仅宽度)
#define IitCGRectMake(X,Y,W,H) CGRectMake((X)*FIT_WIDTH,(Y)*FIT_WIDTH,(W)*FIT_WIDTH,(H)*FIT_WIDTH)

//----end

#endif /* LLCommonDefine_h */
