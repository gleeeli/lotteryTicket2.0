//
//  TypeDetailVC.m
//  loterryTicket
//
//  Created by gleeeli on 2017/7/1.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "TypeDetailVC.h"
#import "ExeplainVC.h"

@interface TypeDetailVC ()<UIScrollViewDelegate>
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UILabel *selectNameLabel;

@end

@implementation TypeDetailVC{
    UIScrollView *_bgSv;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initRightNavigationItem];
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

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    int placeCount = 0;
    switch (self.itemModel.type) {
        case DetailTypeSix:
        {
            placeCount = 0;
        }
            break;
        case DetailTypeTime:
        {
            placeCount = 4;
        }
            break;
        case DetailTypeEleven:
        {
            placeCount = 0;
        }
            break;
        case DetailTypeQuikely:
        {
            placeCount = 0;
        }
            break;
        default:
            break;
    }
    
    [self createSelectButtonUI:placeCount];
    
    [self.view bringSubviewToFront:self.bottomView];
}

-(NSArray <NSString *>*)getNumber
{
    NSMutableArray  *array = [[NSMutableArray alloc]init];
    int count = 0;
    switch (self.itemModel.type) {
        case DetailTypeSix:
        {
            count = 7;
        }
            break;
            case DetailTypeTime:
        {
            count = 10;
        }
            break;
            case DetailTypeEleven:
        {
            count = 11;
        }
            break;
            case DetailTypeQuikely:
        {
            count = 80;
        }
            break;
        default:
            break;
    }
    
    for (int i=0; i<count; i++) {
        [array addObject:[NSString stringWithFormat:@"%d",self.itemModel.type==DetailTypeTime?i:i+1]];
    }
    
    return array;
}

#pragma mark UI
-(void)initRightNavigationItem
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 5, 70, 34)];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 34);
    btn.backgroundColor = [UIColor clearColor];
    [btn setTitle:@"说 明" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:12];
    [btn addTarget:self action:@selector(leftNavigationItemClick) forControlEvents:UIControlEventTouchUpInside];
    
    [view addSubview:btn];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:view];
    
    self.navigationItem.rightBarButtonItem = item;
}


-(void)createSelectButtonUI:(NSInteger)placeCount
{
    UIScrollView *bgView = InsertScrollView(self.view, CGRectMake(0, 0, kScreenWidth, 50), 0, self);
    _bgSv = bgView;
//     InsertView(self.view, CGRectMake(0, 64, kScreenWidth, 50), [UIColor clearColor]);
    NSArray *numbers = [self getNumber];
    int buttonWidth = (kScreenWidth-80)/5.0;
    
    UIButton *lastButton = nil;
    for (int i=0; i<=placeCount; i++) {
        int origHeight = lastButton?LL_AUTO_ORINGY(lastButton):0;
        UILabel *nameLabel = InsertLabel(bgView, CGRectMake(0, origHeight+ 10, 25, buttonWidth), NSTextAlignmentCenter, [self titleName:i], FitFontSize(8), [UIColor blackColor], NO);
        nameLabel.adjustsFontSizeToFitWidth = YES;
        nameLabel.hidden = placeCount>0?NO:YES;
        
        for (int i=0; i<numbers.count; i++) {
            
            UIButton *button = InsertButtonWithType(bgView, CGRectMake(30+(i%5)*(buttonWidth+10), origHeight+ 10+(i/5)*(buttonWidth+10), buttonWidth, buttonWidth), 100, self, @selector(buttonClick:), UIButtonTypeCustom);
            [button setTitle:numbers[i] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
            [button setTitleColor:[UIColor whiteColor] forState:UIControlStateSelected];
            [button setBackgroundImage:[UIImage imageNamed:@"selectBg"] forState:UIControlStateSelected];
            button.backgroundColor = kCommongroundColor;
            button.layer.cornerRadius = LL_mmHeight(button)/2.0;
            button.clipsToBounds = YES;
            button.tag = i+1;
            if (i==numbers.count-1) {
                lastButton = button;
                bgView.frame = CGRectMake(0, 0, kScreenWidth, LL_AUTO_ORINGY(button)+80);
                bgView.contentSize = CGSizeMake(kScreenWidth, LL_AUTO_ORINGY(button)+80);
            }
        }
    }
    
    
    
    
}

#pragma mark 点击事件

-(void)buttonClick:(UIButton *)button
{
    button.selected = !button.selected;
    
}

-(void)leftNavigationItemClick
{
    ExeplainVC *exeplaiVc = [[UIStoryboard storyboardWithName:@"LLMain" bundle:nil] instantiateViewControllerWithIdentifier:@"ExeplainVC"];
    exeplaiVc.itemModel = self.itemModel;
    [self.navigationController pushViewController:exeplaiVc animated:NO];
}
- (IBAction)cancelAction:(UIButton *)sender {
    
    [self backToSuperView];
}
- (IBAction)sureAction:(UIButton *)sender {
    
    NSMutableString *string = [[NSMutableString alloc]init];
    for (UIView *view in _bgSv.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            if (button.isSelected) {
               [string appendString:[NSString stringWithFormat:@" %@",button.titleLabel.text]];
            }
        }
    }
    self.selectNameLabel.text = string;
    
    NSLog(@"恭喜你选择成功等待获奖");
}

#pragma mark 其它
-(NSString *)titleName:(int)place
{
    NSString *placeName;
    switch (place) {
        case 0:
            placeName = @"个位";
            break;
        case 1:
            placeName = @"十位";
            break;
        case 2:
            placeName = @"百位";
            break;
        case 3:
            placeName = @"千位";
            break;
        case 4:
            placeName = @"万位";
            break;
            
        default:
            break;
    }
    return placeName;
}

@end
