//
//  DataBaseManager.h
//  loterryTicket
//
//  Created by gleeeli on 2017/6/25.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfoHandle.h"

@interface DataBaseManager : NSObject
@property (strong, nonatomic) UserInfoHandle *userInfoHandle;

+ (instancetype)shareManager;
@end
