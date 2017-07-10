//
//  SuperWebViewController.h
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "SuperVC.h"

@interface SuperWebViewController : SuperVC
@property (copy, nonatomic) NSURL *webURL;

- (void)loadLocalURL:(NSString *)locaUrl;

- (void)loadServiceURL:(NSString *)serviceUrl;
@end
