//
//  LLBaseModule.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LLBaseModeleConst.h"


/**
 Module接口protocol
 */
@protocol LLModuleAdapter <NSObject>

@required
- (instancetype)initWithViewFrame:(CGRect)frame;

@optional
- (void)reloadModuleData;

@end


@interface LLBaseModule : NSObject<NSCopying,LLModuleAdapter>
//视图相关
@property (nonatomic,strong) UIView *moduleView;    //模块视图
@property (nonatomic,assign) CGSize moduleViewSize; //模块视图size
@property (nonatomic,strong) NSString *moduleIdent; //模块标识,唯一
@property (nonatomic,assign) CGSize nativeSize;     //原始视图size

//视图section相关
@property (nonatomic,strong) NSString *moduleTitle; //模块section标题
@property (nonatomic,assign) NSInteger moduleSectionIcon; //模块section图标
@property (nonatomic,copy)  SectionActionBlcok moduleSectionAction;//模块section点击动作

@end


/**
 以下分类只为方便Module调用方法
 */
@interface UIView (LLBaseModuleView)

- (void)updateModuleDatas:(NSArray *)datalist;

- (void)updateModuleData:(NSObject *)model;

@end

@interface NSObject (LLBaseModule)

- (void)addModuleViewToSuperView:(UIView*)superView ;


@end
