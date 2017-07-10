//
//  LLItemModel.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLBaseModel.h"

@interface LLItemModel : LLBaseModel
@property (nonatomic,copy) NSString *imageName;
@property (nonatomic,copy) NSString *descript;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,assign)DetailType type;
@end
