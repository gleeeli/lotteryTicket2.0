//
//  SuperDataBaseHandle.h
//  loterryTicket
//
//  Created by gleeeli on 2017/6/25.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SuperDataBaseHandle : NSObject
@property (nonatomic, readwrite, strong) NSManagedObjectContext *context;

// 用上下文初始化
- (instancetype)initWithContext:(NSManagedObjectContext *)context;
@end
