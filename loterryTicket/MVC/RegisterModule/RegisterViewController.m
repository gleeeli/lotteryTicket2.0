//
//  RegisterViewController.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "RegisterViewController.h"
#import "CommHeader.h"
#import "DataBaseManager.h"
#import "ViewCode.h"

@interface RegisterViewController ()
@property (weak, nonatomic) IBOutlet UIView *mainView;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UITextField *userNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *userPasswordTextField;
@property (weak, nonatomic) IBOutlet UITextField *surePasswordTextField;

@end

@implementation RegisterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.mainView.layer.backgroundColor = [UIColor whiteColor].CGColor;
    self.mainView.layer.cornerRadius = 5.0;
    
    self.registerBtn.layer.backgroundColor = MainColor.CGColor;
    self.registerBtn.layer.cornerRadius = 5.0;
}

- (IBAction)registerBtnClick:(id)sender
{
    NSString *password = self.userPasswordTextField.text;
    NSString *surePassword = self.surePasswordTextField.text;
    if ([password isEqualToString:surePassword])
    {
       BOOL isSuccess = [[DataBaseManager shareManager].userInfoHandle registerUserInfo:self.userNameTextField.text password:password];
        
        if (isSuccess)
        {
            [ViewCode showMessageWithTitle:@"注册成功" message:@"请前往登录"];
        }
    }
    else
    {
        [ViewCode showMessageWithTitle:@"注册失败" message:@"用户名与密码不一致"];
    }
}

- (void)didReceiveMemoryWarning
{
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
