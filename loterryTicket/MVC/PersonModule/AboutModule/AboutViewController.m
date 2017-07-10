//
//  AboutViewController.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = @"My彩票";
    NSString *localUrl = [[NSBundle mainBundle] pathForResource:@"About/index" ofType:@"html"];
    //NSString *localUrl = [NSString stringWithFormat:@"%@/%@",[[NSBundle mainBundle] resourcePath],@"About/index.html"];
    [self loadLocalURL:localUrl];
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

@end
