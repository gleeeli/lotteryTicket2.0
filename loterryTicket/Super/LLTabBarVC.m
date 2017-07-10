//
//  LLTabBarVC.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/19.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLTabBarVC.h"
#import "LLTabbarView.h"

@interface LLTabBarVC ()<LLTabbarViewDelegate>
//system tabBarView
@property (nonatomic, strong) UIView *tabBarView;
//自定义tabbarview
@property (nonatomic, strong) LLTabbarView *cusTomerTabBar;
@end

@implementation LLTabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSArray *subViews = self.view.subviews;
    for (UIView *subView in subViews) {
        
        if ([subView isKindOfClass:[UITabBar class]]) {
            self.tabBarView = subView;
            break;
        }
    }
    
    UIStoryboard *liveListStoryboard = [UIStoryboard storyboardWithName:@"LLMain" bundle:nil];
    UIViewController *homeVC = [liveListStoryboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    
    UIStoryboard *personModuleStoryboard = [UIStoryboard storyboardWithName:@"PersonModule" bundle:nil];
    UIViewController *myseviceVC = [personModuleStoryboard instantiateViewControllerWithIdentifier:@"MyServiceViewController"];
    
    UIStoryboard *loginStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginVC = [loginStoryboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    self.viewControllers = @[homeVC,myseviceVC,loginVC];//
    
    [self loadCustomerTabbar];
}

- (void)loadCustomerTabbar{
    
    
    
    self.cusTomerTabBar = [[[NSBundle mainBundle] loadNibNamed:@"LLTabbarView" owner:nil options:nil] firstObject];
    
    self.cusTomerTabBar.frame = self.tabBarView.bounds;
    
    CGRect frame=self.cusTomerTabBar.frame;
    frame.origin.y=frame.origin.y-12;
    frame.size.height=frame.size.height+12;
    self.cusTomerTabBar.frame=frame;
    
    [self.tabBarView addSubview:self.cusTomerTabBar];
    
    self.cusTomerTabBar.tabBarDelegate = self;
    
    
    [((UITabBar*)self.tabBarView) setShadowImage:[[UIImage alloc] init]];
    [((UITabBar*)self.tabBarView) setBackgroundImage:[[UIImage alloc] init]];
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

#pragma mark LLTabbarViewDelegate
-(void)tabbarView:(LLTabbarView *)tabbarView
didSelectAtIndex:(NSInteger)index
{
    self.selectedIndex = index;
}


#pragma mark 旋转
// New Autorotation support. IOS(6_0);
- (BOOL)shouldAutorotate
{
    UIViewController *viewController = self.selectedViewController;
    return [viewController shouldAutorotate];
}

//IOS(6_0)
- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    UIViewController *viewController = self.selectedViewController;
    return [viewController supportedInterfaceOrientations];
}
//// Returns interface orientation masks. IOS(6_0);
- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    UIViewController *viewController = self.selectedViewController;
    return [viewController preferredInterfaceOrientationForPresentation];
}

@end
