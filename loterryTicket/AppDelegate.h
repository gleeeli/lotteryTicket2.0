//
//  AppDelegate.h
//  loterryTicket
//
//  Created by luoluo on 2017/6/19.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LLNavgationVC.h"
#import "LLTabBarVC.h"
#import "SuperVC.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
+ (AppDelegate *)shareAppDelegate;

@property (nonatomic, strong) LLNavgationVC *rootNavigationController;
@property (nonatomic, strong) LLTabBarVC *tabBarViewController;

@end

