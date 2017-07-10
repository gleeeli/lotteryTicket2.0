//
//  LoginViewController.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/23.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LoginViewController.h"
#import "CommHeader.h"
#import "RegisterViewController.h"
#import "UserInfoHandle.h"
#import "DataBaseManager.h"
#import "UserDataManager.h"
#import "MyServiceViewController.h"

@interface LoginViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UILabel *topIconLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topIconLabHeightConstraint;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgetBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mainView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.mainView.layer.cornerRadius = 5.0;
    
    self.loginBtn.layer.backgroundColor = MainColor.CGColor;
    self.loginBtn.layer.cornerRadius = 5.0;
    
    CGFloat iconWidth = 75;
    self.topIconLabHeightConstraint.constant = iconWidth;
    self.topIconLabel.numberOfLines = 0;
    self.topIconLabel.textAlignment = NSTextAlignmentCenter;
    self.topIconLabel.font = [UIFont fontWithName:@"iconfont" size:35];//  iconfont
    self.topIconLabel.layer.cornerRadius = iconWidth/2.0;
    self.topIconLabel.layer.borderWidth = 1.0;
    self.topIconLabel.layer.borderColor = MainColor.CGColor;
    self.topIconLabel.text = @"\U0000e636";//&#xe636;
    self.topIconLabel.textColor = MainColor;

    self.userNameTextField.delegate = self;
    self.passwordTextField.delegate = self;
}

- (IBAction)loginBtnClick:(id)sender
{
    NSString *name = self.userNameTextField.text;
    NSString *password = self.passwordTextField.text;
    UserInfo *userInfo = [[DataBaseManager shareManager].userInfoHandle loginWithUserName:name password:password];
    if (userInfo != nil)
    {
        [UserDataManager shareManager].userInfo = userInfo;
        
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"PersonModule" bundle:nil];
        MyServiceViewController *serviceVC = [storyboard instantiateViewControllerWithIdentifier:@"MyServiceViewController"];
        [self.navigationController pushViewController:serviceVC animated:YES];
        
        NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:name,@"name",password,@"password", nil];
        [kUserDefault setObject:dict forKey:LOGIN_KEY];
        [kUserDefault synchronize];
    }
}

- (IBAction)registerBtnClick:(id)sender
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RegisterViewController *registerVc = [storyboard instantiateViewControllerWithIdentifier:@"RegisterViewController"];
    [self.navigationController pushViewController:registerVc animated:YES];
}

- (IBAction)forgetBtnClick:(id)sender
{
    
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
