//
//  LLNavgationVC.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/18.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLNavgationVC.h"

@interface LLNavgationVC ()<UIGestureRecognizerDelegate>

@end

@implementation LLNavgationVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIGestureRecognizer *gesture = self.interactivePopGestureRecognizer;
    gesture.enabled = NO;
    UIView *gestureView = gesture.view;
    
    _popRecognizer = [[UIPanGestureRecognizer alloc] init];
    _popRecognizer.delegate = self;
    _popRecognizer.maximumNumberOfTouches = 1;
    [gestureView addGestureRecognizer:_popRecognizer];
    
    /**
     *  获取系统手势的target数组
     */
    NSMutableArray *_targets = [gesture valueForKey:@"_targets"];
    /**
     *  获取它的唯一对象，我们知道它是一个叫UIGestureRecognizerTarget的私有类，它有一个属性叫_target
     */
    id gestureRecognizerTarget = [_targets firstObject];
    /**
     *  获取_target:_UINavigationInteractiveTransition，它有一个方法叫handleNavigationTransition:
     */
    id navigationInteractiveTransition = [gestureRecognizerTarget valueForKey:@"_target"];
    /**
     *  通过前面的打印，我们从控制台获取出来它的方法签名。
     */
    SEL handleTransition = NSSelectorFromString(@"handleNavigationTransition:");
    /**
     *  创建一个与系统一模一样的手势，我们只把它的类改为UIPanGestureRecognizer
     */
    [_popRecognizer addTarget:navigationInteractiveTransition action:handleTransition];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    
    // Prevent calling the handler when the gesture begins in an opposite direction.
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *panGest = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [panGest translationInView:panGest.view];
        if (translation.x <= 0 && self.viewControllers.count != 1) {//不是第一页并且不是从左往右划的，
            return NO;
        }
    }
    
    /**
     *  这里有两个条件不允许手势执行，1、当前控制器为根控制器；2、如果这个push、pop动画正在执行（私有属性）
     */
    return self.viewControllers.count != 1 && ![[self valueForKey:@"_isTransitioning"] boolValue];
    
}

#pragma mark 旋转
// New Autorotation support. IOS(6_0);
- (BOOL)shouldAutorotate
{
    UIViewController *viewController = self.topViewController;
    return [viewController shouldAutorotate];
}

//IOS(6_0)
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIViewController *viewController = self.topViewController;
    return [viewController supportedInterfaceOrientations];
}
//// Returns interface orientation masks. IOS(6_0);
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    UIViewController *viewController = self.topViewController;
    return [viewController preferredInterfaceOrientationForPresentation];
}


@end
