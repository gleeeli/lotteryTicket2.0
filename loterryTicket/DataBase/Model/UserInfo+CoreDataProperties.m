//
//  UserInfo+CoreDataProperties.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/25.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "UserInfo+CoreDataProperties.h"

@implementation UserInfo (CoreDataProperties)

+ (NSFetchRequest<UserInfo *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"UserInfo"];
}

@dynamic name;
@dynamic password;
@dynamic qq;
@dynamic headImage;
@dynamic telephone_number;
@dynamic id_card;
@dynamic address;
@dynamic person_introduce;

@end
