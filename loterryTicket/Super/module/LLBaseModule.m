//
//  LLBaseModule.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLBaseModule.h"

@implementation LLBaseModule

- (id)copyWithZone:(nullable NSZone *)zone{
    return self;
}

- (instancetype)initWithViewFrame:(CGRect)frame{
    self=[super init];
    if (self) {
        
        self.nativeSize=frame.size;
        self.moduleViewSize=self.nativeSize;
        
    }
    return self;
}

- (void)reloadModuleData{
    
}

@end



