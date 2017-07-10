//
//  SuperDataBaseHandle.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/25.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "SuperDataBaseHandle.h"

@implementation SuperDataBaseHandle

- (instancetype)initWithContext:(NSManagedObjectContext *)context
{
    self = [super init];
    if (self)
    {
        self.context = context;
    }
    return self;
}
@end
