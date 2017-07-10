//
//  MyServiceViewController.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "MyServiceViewController.h"
#import "CommHeader.h"
#import "MyServiceModel.h"
#import "MyServiceTableViewCell.h"
#import "PersonInfoViewController.h"
#import "AboutViewController.h"
#import "UserDataManager.h"
#import "LoginViewController.h"
#import "LoginViewController.h"

@interface MyServiceViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) NSMutableArray *muarray;
@end

@implementation MyServiceViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSString *name = @"登录";
    NSString *headImage = @"";
    if ([UserDataManager shareManager].userInfo != nil)
    {
        name = [UserDataManager shareManager].userInfo.name;
        headImage = [UserDataManager shareManager].userInfo.headImage;
        headImage = headImage ==nil? @"":headImage;
    }
    
    self.navigationItem.title = @"我的";
    
    self.muarray = [[NSMutableArray alloc] init];
    // section 0
    NSArray *section0TitleArray = [[NSArray alloc] initWithObjects:name, nil];
    NSArray *section0BackColorArray = [[NSArray alloc] initWithObjects:
                                       [UIColor colorWithRed:0 green:163/255.0 blue:169/255.0 alpha:1], nil];
    NSArray *section0IconArray = [[NSArray alloc] initWithObjects:headImage,nil];
    [self.muarray addObject:[self getSectionModelArray:section0TitleArray backColorArray:section0BackColorArray iconArray:section0IconArray]];
    
    // section 1
    NSArray *section1TitleArray = [[NSArray alloc] initWithObjects:@"安全中心",@"身份认证",@"手机服务", nil];
    NSArray *section1BackColorArray = [[NSArray alloc] initWithObjects:
                                       [UIColor colorWithRed:0 green:163/255.0 blue:169/255.0 alpha:1],
                                       [UIColor colorWithRed:189/255.0 green:101/255.0 blue:202/255.0 alpha:1],
                                       [UIColor colorWithRed:0 green:189/255.0 blue:36/255.0 alpha:1], nil];
    NSArray *section1IconArray = [[NSArray alloc] initWithObjects:@"\U0000e669",@"\U0000e652",@"\U0000e692", nil];
    
    [self.muarray addObject:[self getSectionModelArray:section1TitleArray backColorArray:section1BackColorArray iconArray:section1IconArray]];
    
    // section 2
    NSArray *section2TitleArray = [[NSArray alloc] initWithObjects:@"站内信息",@"帮助反馈",@"客户服务", nil];
    NSArray *section2BackColorArray = [[NSArray alloc] initWithObjects:
                                       [UIColor colorWithRed:24/255.0 green:142/255.0 blue:221/255.0 alpha:1],
                                       [UIColor colorWithRed:0 green:163/255.0 blue:169/255.0 alpha:1],
                                       [UIColor colorWithRed:136/255.0 green:173/255.0 blue:214/255.0 alpha:1], nil];
    NSArray *section2IconArray = [[NSArray alloc] initWithObjects:@"\U0000e647",@"\U0000e6a7",@"\U0000e6c2", nil];
    
    [self.muarray addObject:[self getSectionModelArray:section2TitleArray backColorArray:section2BackColorArray iconArray:section2IconArray]];
    
    // section 3
    NSArray *section3TitleArray = [[NSArray alloc] initWithObjects:@"分享好友",@"关于MY彩票", nil];
    NSArray *section3BackColorArray = [[NSArray alloc] initWithObjects:
                                       [UIColor colorWithRed:157/255.0 green:90/255.0 blue:174/255.0 alpha:1],
                                       [UIColor colorWithRed:234/255.0 green:94/255.0 blue:33/255.0 alpha:1], nil];
    NSArray *section3IconArray = [[NSArray alloc] initWithObjects:@"\U0000e600",@"\U0000e696", nil];
    
    [self.muarray addObject:[self getSectionModelArray:section3TitleArray backColorArray:section3BackColorArray iconArray:section3IconArray]];
    
//    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.navigationController.navigationBar.translucent = NO;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // 更新section0
    NSString *name = @"登录";
    NSString *headImage = @"";
    if ([UserDataManager shareManager].userInfo != nil)
    {
        name = [UserDataManager shareManager].userInfo.name;
        headImage = [UserDataManager shareManager].userInfo.headImage;
        headImage = headImage ==nil? @"":headImage;
    }
    
    self.navigationItem.title = @"我的";
    // section 0
    NSArray *section0TitleArray = [[NSArray alloc] initWithObjects:name, nil];
    NSArray *section0BackColorArray = [[NSArray alloc] initWithObjects:
                                       [UIColor colorWithRed:0 green:163/255.0 blue:169/255.0 alpha:1], nil];
    NSArray *section0IconArray = [[NSArray alloc] initWithObjects:headImage,nil];
    
    [self.muarray replaceObjectAtIndex:0 withObject:[self getSectionModelArray:section0TitleArray backColorArray:section0BackColorArray iconArray:section0IconArray]];
}

- (NSMutableArray *)getSectionModelArray:(NSArray *)titleArray backColorArray:(NSArray *)backColorArray iconArray:(NSArray *)iconArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int index = 0; index < [titleArray count]; index ++)
    {
        MyServiceModel *model = [[MyServiceModel alloc] initWithTitle:titleArray[index] backColor:backColorArray[index] iconText:iconArray[index]];
        [array addObject:model];
    }
    return array;
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.muarray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * array = self.muarray[section];
    return [array count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0)
    {
        return 0;
    }
    return 15;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0)
    {
        return 100;
    }
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identifier = indexPath.section == 0? @"MyServiceHeaderTableViewCell":@"MyServiceTableViewCell";
    MyServiceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSArray * array = self.muarray[indexPath.section];
    MyServiceModel *model = array[indexPath.row];
    
    
    if (indexPath.section == 0)
    {
        NSString *imageName = @"";
        if (model.iconText == nil || [model.iconText isEqualToString:@""])
        {
            imageName = @"header_default.jpg";
        }
        else
        {
            imageName = model.iconText;
        }
        cell.headImageView.image = [UIImage imageNamed:imageName];
        cell.userNameLabel.text = model.contentText;
        cell.backgroundColor = MainColor;
    }
    else
    {
        cell.leftIconLabel.backgroundColor = model.backColor;
        cell.leftIconLabel.text = model.iconText;
        cell.contentLabel.text = model.contentText;
        
    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PersonModule" bundle:nil];
    NSArray * array = self.muarray[indexPath.section];
    MyServiceModel *model = array[indexPath.row];
    
    if (indexPath.section == 0)
    {
        if ([UserDataManager shareManager].userInfo == nil)
        {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            LoginViewController *registerVc = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
            [self.navigationController pushViewController:registerVc animated:YES];
        }
        else
        {
            PersonInfoViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"PersonInfoViewController"];
            //        [self presentViewController:vc animated:NO completion:nil];
            [self.navigationController pushViewController:vc animated:YES];
        }
        
    }
    else if ([model.contentText isEqualToString:@"客户服务"])
    {
        NSMutableString * str=[[NSMutableString alloc] initWithFormat:@"telprompt://%@",@"13760375857"];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
    }
    else if ([model.contentText isEqualToString:@"关于MY彩票"])
    {
        AboutViewController *aboutVC = [[AboutViewController alloc] init];
        [aboutVC loadServiceURL:@"https://www.baidu.com"];
        
        [self.navigationController pushViewController:aboutVC animated:YES];
        //[self presentViewController:aboutVC animated:YES completion:nil];
    }
    else
    {
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:@"此功能尚未开通，敬请期待" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        [alertController addAction:action];
        [self presentViewController:alertController animated:NO completion:nil];
    }
}

//uitableview处理section的不悬浮，禁止section停留的方法，主要是这段代码
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat sectionHeaderHeight = 15;
    if(scrollView.contentOffset.y<=sectionHeaderHeight&&scrollView.contentOffset.y>=0) {
        scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0);
    } else if (scrollView.contentOffset.y>=sectionHeaderHeight) {
        scrollView.contentInset = UIEdgeInsetsMake(-sectionHeaderHeight, 0, 0, 0);
    }
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
