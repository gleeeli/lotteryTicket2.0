//
//  PersonInfoViewController.m
//  loterryTicket
//
//  Created by gleeeli on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "PersonInfoViewController.h"
#import "PersonInfoTableViewCell.h"
#import "PersonInfoModel.h"
#import "CommHeader.h"
#import "DataBaseManager.h"
#import "UserDataManager.h"
#import "LLAlbumPicker.h"


@interface PersonInfoViewController ()<UITableViewDelegate,UITableViewDataSource,PersonInfoCellDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UIButton *headButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *headImageHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (strong, nonatomic) NSMutableArray *muarray;
@property (weak, nonatomic) IBOutlet UIView *headerView;
@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end

@implementation PersonInfoViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.muarray = [[NSMutableArray alloc] init];
    NSArray *leftArray = [[NSArray alloc] initWithObjects:@"身份证",@"手机号码",@"QQ",@"联系地址",@"邮政编码",@"个人简介", nil];
    NSArray *placeHolderArray = [[NSArray alloc] initWithObjects:@"请输入身份证号码",@"请输入手机号码",@"请输入QQ",@"请输入联系地址",@"请输入邮政编码",@"请输入个人简介", nil];
    UserInfo *userInfo =  [UserDataManager shareManager].userInfo;
    NSArray *contentArray = [[NSArray alloc] initWithObjects:@"",@"",@"",@"",@"",@"", nil];
    if (userInfo != nil)
    {
        NSString *id_card = userInfo.id_card == nil? @"":userInfo.id_card;
        NSString *telephone_number = userInfo.telephone_number == nil? @"":userInfo.telephone_number;
        NSString *qq = userInfo.qq == nil? @"":userInfo.qq;
        NSString *address = userInfo.address == nil? @"":userInfo.address;
        NSString *person_introduce = userInfo.person_introduce == nil? @"":userInfo.person_introduce;
        
        contentArray = [[NSArray alloc] initWithObjects:id_card,telephone_number,qq,address,@"",person_introduce, nil];
    }
    
    for (int index = 0; index < [leftArray count]; index++)
    {
        PersonInfoModel *model = [[PersonInfoModel alloc] init];
        model.leftTitle = leftArray[index];
        model.placeHoleder = placeHolderArray[index];
        model.content = contentArray[index];
        [self.muarray addObject:model];
    }
    
    self.headerView.backgroundColor = MainColor;
    self.headImageView.layer.cornerRadius = self.headImageHeightConstraint.constant * 0.5;
    self.headImageView.layer.masksToBounds = YES;
    self.saveBtn.backgroundColor = MainColor;
    self.saveBtn.layer.cornerRadius = 5.0;
}

// 更改头像
- (IBAction)headerButtonClick:(id)sender
{
    
    NSString *heaImagePathDev = @"";
    UserInfo *userInfo =  [UserDataManager shareManager].userInfo;
    userInfo.headImage = heaImagePathDev;
    kSelfWeak;
    [[LLAlbumPicker shareImagePicker]showActionSheetWithPresentViewController:self didFinishWithCompletion:^(UIImagePickerController *picker, NSDictionary *mediaInfo, UIImage *image, NSData *imageData) {
        NSLog(@"mediaInfo:%@",mediaInfo);
        if (image) {
            GCDMain(^{
            [weakSelf.headButton setBackgroundImage:image forState:UIControlStateNormal];
            });
            
        }
    }];
}

// 保存用户信息
- (IBAction)saveBtnClick:(id)sender
{
    UserInfo *userInfo =  [UserDataManager shareManager].userInfo;
    
    NSString *name = userInfo.name;
    NSString *password = userInfo.password;
    NSString *qq = userInfo.password;
    NSString *headImage = userInfo.headImage;
    NSString *telephone_number = userInfo.telephone_number;
    NSString *id_card = userInfo.id_card;
    NSString *address = userInfo.address;
    NSString *person_introduce = userInfo.person_introduce;
    
    for (PersonInfoModel *model in self.muarray)
    {
        if ([model.leftTitle isEqualToString:@"身份证"])
        {
            id_card = model.content;
        }
        else if ([model.leftTitle isEqualToString:@"手机号码"])
        {
            telephone_number = model.content;
        }
        else if ([model.leftTitle isEqualToString:@"QQ"])
        {
            qq = model.content;
        }
        else if ([model.leftTitle isEqualToString:@"联系地址"])
        {
            address = model.content;
        }
        else if ([model.leftTitle isEqualToString:@"邮政编码"])
        {
            
        }
        else if ([model.leftTitle isEqualToString:@"个人简介"])
        {
            person_introduce = model.content;
        }
    }
    
    BOOL success = [[DataBaseManager shareManager].userInfoHandle saveUserInfoWithName:name password:password qq:qq headImage:headImage telephoneNumber:telephone_number idCard:id_card address:address personIntroduce:person_introduce];
    
    if (success)
    {
        userInfo.id_card = id_card;
        userInfo.password = password;
        userInfo.qq = qq;
        userInfo.address = address;
        userInfo.person_introduce = person_introduce;
        
        [ViewCode showMessageWithTitle:nil message:@"保存成功"];
    }
    else
    {
         [ViewCode showMessageWithTitle:nil message:@"保存失败"];
    }
}

#pragma mark <UITableViewDelegate,UITableViewDataSource>
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.muarray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    PersonInfoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonInfoTableViewCell"];
    
    PersonInfoModel *model = self.muarray[indexPath.row];
    cell.contentTextField.text = model.content;
    cell.leftTitleLabel.text = model.leftTitle;
    cell.contentTextField.placeholder = model.placeHoleder;
    cell.delegate = self;
    cell.indexPath = indexPath;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark PersonInfoCellDelegate
- (void)textfieldChange:(PersonInfoTableViewCell *)cell
{
    PersonInfoModel *model = self.muarray[cell.indexPath.row];
    model.content = cell.contentTextField.text;
    
    [self.muarray replaceObjectAtIndex:cell.indexPath.row withObject:model];
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
