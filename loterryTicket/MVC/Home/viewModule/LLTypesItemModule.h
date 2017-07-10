//
//  LLTypesItemModule.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLBaseModule.h"

typedef enum : NSUInteger {
    
    LLItemModuleTypeHot     =1,//最热
    LLItemModuleTypeNew   =2,//最新
} LLItemModuleType;


@interface LLTypesItemModule : LLBaseModule
@property (nonatomic,assign) LLItemModuleType moduleType;
//类型如LLItemModel
@property (nonatomic,strong) NSMutableArray <LLBaseModel *> *datalist;    //传入整个模块的数据 刷新内部Cell用 单独设置
//@property (nonatomic,assign) BOOL isDirty;


+ (id)initWithViewWidth:(CGFloat)width moduleType:(LLItemModuleType)type;

//刷新首页所有游戏直播列表,用于点击更多时创建页面
//- (void)updateAllGameLive:(NSArray *)gamelist;


@end

@interface LLItemView : UIView

+ (id)initViewWithFrame:(CGRect)frame;

//- (void)sortData;

@end
