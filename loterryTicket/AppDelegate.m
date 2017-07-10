//
//  AppDelegate.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/19.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "AppDelegate.h"
#import "DataBaseManager.h"
#import "UserDataManager.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self autoLogin];
    return YES;
}

// 登录过则自动登录
- (void)autoLogin
{
    if ([UserDataManager shareManager].userInfo == nil)
    {
        NSDictionary *dict = [kUserDefault objectForKey:LOGIN_KEY];
        if (dict != nil)
        {
            NSString *name = [dict objectForKey:@"name"];
            NSString *password = [dict objectForKey:@"password"];
            UserInfo *userInfo = [[DataBaseManager shareManager].userInfoHandle loginWithUserName:name password:password];
            if (userInfo != nil)
            {
                [UserDataManager shareManager].userInfo = userInfo;
            }
        }
    }
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

+ (AppDelegate *)shareAppDelegate
{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


#pragma mark - 获取根视图
- (LLNavgationVC *)rootNavigationController{
    if (!_rootNavigationController) {
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController * rootViewController = [story instantiateInitialViewController];
        _rootNavigationController = (LLNavgationVC *)rootViewController;
        self.tabBarViewController = [_rootNavigationController.viewControllers firstObject];
    }
    return _rootNavigationController;
}

-(LLTabBarVC *)tabBarViewController
{
    if (!_tabBarViewController) {
        UIStoryboard * story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController * rootViewController = [story instantiateInitialViewController];
        _rootNavigationController = (LLNavgationVC *)rootViewController;
         _tabBarViewController = [_rootNavigationController.viewControllers firstObject];
       
    }
    return _tabBarViewController;
    
}


@end
