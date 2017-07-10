//
//  LLBaseModeleConst.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#ifndef LLBaseModeleConst_h
#define LLBaseModeleConst_h

//enum
typedef enum : NSUInteger {
    LLSectionHeaderIconTypeHot,//热点
    LLSectionHeaderIconTypeOriginal    =1,//原创推荐
} LLSectionHeaderIconType;

//block
typedef void(^SectionActionBlcok)();
typedef void(^UPdataSucessBlcok)();
typedef void(^UPdataFailBlcok)();

#endif /* LLBaseModeleConst_h */
