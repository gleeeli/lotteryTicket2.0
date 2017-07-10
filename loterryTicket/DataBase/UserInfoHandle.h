//
//  UserInfoHandle.h
//  loterryTicket
//
//  Created by gleeeli on 2017/6/25.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "SuperDataBaseHandle.h"
#import "UserInfo+CoreDataProperties.h"

@interface UserInfoHandle : SuperDataBaseHandle
/**
 *  注册用户
 *  @param userInfo 用户信息
 */
- (BOOL)registerUserInfo:(NSString *)name password:(NSString *)password;

- (UserInfo *)loginWithUserName:(NSString *)userName password:(NSString *)password;

// 保存用户信息
- (BOOL)saveUserInfoWithName:(NSString *)name password:(NSString *)password qq:(NSString *)qq headImage:(NSString *)headImage telephoneNumber:(NSString *)telephoneNumber idCard:(NSString *)idCard address:(NSString *)address personIntroduce:(NSString *)personIntroduce;
@end
