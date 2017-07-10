//
//  UserDataManager.m
//  loterryTicket
//
//  Created by gleeeli on 2017/7/1.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "UserDataManager.h"

static UserDataManager *ubManager = nil;
@implementation UserDataManager
+ (instancetype)shareManager
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ubManager = [[UserDataManager alloc] init];
    });
    return ubManager;
}
@end
