//
//  LLHelp.h
//  loterryTicket
//
//  Created by gleeeli on 2017/7/9.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LLHelp : NSObject
+ (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize;
+ (UIImage *)fixOrientation:(UIImage *)aImage ;
@end
