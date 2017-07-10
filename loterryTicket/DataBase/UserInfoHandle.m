//
//  UserInfoHandle.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/25.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "UserInfoHandle.h"

@implementation UserInfoHandle


/**
 *  注册用户
 *  @param userInfo 用户信息
 */
- (BOOL)registerUserInfo:(NSString *)name password:(NSString *)password
{
    UserInfo *curUserInfo = [NSEntityDescription insertNewObjectForEntityForName:@"UserInfo" inManagedObjectContext:self.context];
    curUserInfo.name = name;
    curUserInfo.password = password;
//    curUserInfo.name = userInfo.name;
//    curUserInfo.password = userInfo.password;
//    curUserInfo.qq = userInfo.qq;
//    curUserInfo.headImage = userInfo.headImage;
//    curUserInfo.telephone_number = userInfo.telephone_number;
//    curUserInfo.id_card = userInfo.id_card;
//    curUserInfo.address = userInfo.address;
//    curUserInfo.person_introduce = userInfo.person_introduce;
    
    //保存,用 save 方法
    NSError *error = nil;
    BOOL success = [self.context save:&error];
    if (!success)
    {
        [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
    }
    
    return success;
}


- (UserInfo *)loginWithUserName:(NSString *)userName password:(NSString *)password
{
    //以上代码简写成下边
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserInfo"];
    
    // 设置排序（按照age降序）
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:NO];
    request.sortDescriptors = [NSArray arrayWithObject:sort];
    // 设置条件过滤(搜索name中包含字符串"zhang"的记录，注意：设置条件过滤时，数据库SQL语句中的%要用*来代替，所以%Itcast-1%应该写成*zhang*)
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@ and password like %@", userName,password];
    request.predicate = predicate;
    
    // 执行请求
    NSError *error = nil;
    NSArray *objs = [self.context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    NSLog(@"-----------------------------------");
    
    for (UserInfo *userInfo in objs) {
        NSLog(@"登录成功，用户名：%@---密码=%@", userInfo.name,userInfo.password);
        return userInfo;
    }
    return nil;
}

// 保存用户信息
- (BOOL)saveUserInfoWithName:(NSString *)name password:(NSString *)password qq:(NSString *)qq headImage:(NSString *)headImage telephoneNumber:(NSString *)telephoneNumber idCard:(NSString *)idCard address:(NSString *)address personIntroduce:(NSString *)personIntroduce
{
    //以上代码简写成下边
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"UserInfo"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@ and password like %@", name,password];
    request.predicate = predicate;
    
    // 执行请求
    NSError *error = nil;
    NSArray *objs = [self.context executeFetchRequest:request error:&error];
    if (error) {
        [NSException raise:@"查询错误" format:@"%@", [error localizedDescription]];
    }
    
    NSLog(@"-----------------------------------");
    if ([objs count] > 0)
    {
        UserInfo *curUserInfo = objs[0];
        curUserInfo.name = name;
        curUserInfo.password = password;
        curUserInfo.qq = qq;
        curUserInfo.headImage = headImage;
        curUserInfo.telephone_number = telephoneNumber;
        curUserInfo.id_card = idCard;
        curUserInfo.address = address;
        curUserInfo.person_introduce = personIntroduce;
    }

    //保存,用 save 方法
    BOOL success = [self.context save:&error];
    if (!success)
    {
        [NSException raise:@"访问数据库错误" format:@"%@",[error localizedDescription]];
    }
    
    return success;
}

@end
