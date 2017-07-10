//
//  UserInfo+CoreDataProperties.h
//  loterryTicket
//
//  Created by gleeeli on 2017/6/25.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "UserInfo+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface UserInfo (CoreDataProperties)

+ (NSFetchRequest<UserInfo *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *password;
@property (nullable, nonatomic, copy) NSString *qq;
@property (nullable, nonatomic, copy) NSString *headImage;
@property (nullable, nonatomic, copy) NSString *telephone_number;
@property (nullable, nonatomic, copy) NSString *id_card;
@property (nullable, nonatomic, copy) NSString *address;
@property (nullable, nonatomic, copy) NSString *person_introduce;

@end

NS_ASSUME_NONNULL_END
