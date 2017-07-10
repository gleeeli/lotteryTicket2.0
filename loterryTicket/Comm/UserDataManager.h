//
//  UserDataManager.h
//  loterryTicket
//
//  Created by gleeeli on 2017/7/1.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserInfo+CoreDataProperties.h"

@interface UserDataManager : NSObject
@property (strong, nonatomic) UserInfo *userInfo;

+ (instancetype)shareManager;
@end
