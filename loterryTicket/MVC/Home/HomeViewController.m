//
//  HomeViewController.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/19.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "HomeViewController.h"
#import "LLBannerModule.h"
#import "LLTypesItemModule.h"
#import "HotHeaderView.h"

@interface HomeViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>
@property (nonatomic ,strong) LLBannerModule *bannerModule ;
@property (nonatomic,strong) NSMutableArray <LLBaseModule *>*moduleList;
@property (nonatomic,strong) LLTypesItemModule *itemModule;
@property (nonatomic,strong) NSMutableDictionary <LLBaseModule *,NSString *>*moduleIdDict;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;


@end

@implementation HomeViewController

-(NSMutableArray <LLBaseModule *> *)moduleList
{
    if (!_moduleList) {
        _moduleList = [NSMutableArray array];
    }
    return _moduleList;
    
}

-(NSMutableDictionary <LLBaseModule *,NSString *>*)moduleIdDict
{
    if (!_moduleIdDict) {
        _moduleIdDict = [NSMutableDictionary dictionary];
    }
    return _moduleIdDict;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    ///liguanglei 李光磊
    [self initconmen];
    //加载banner广告模块
    self.bannerModule=[LLBannerModule initWithViewWidth:kScreenWidth];
    
    //加载彩票类型模块
    self.itemModule = [LLTypesItemModule initWithViewWidth:kScreenWidth moduleType:LLItemModuleTypeHot];
    
    [self.moduleList addObject:self.bannerModule];
    [self.moduleList addObject:self.itemModule];
    
    //注册headerView
    [self.collectionView registerNib:[UINib nibWithNibName:@"HotHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HotHeaderView"];
    //添加下拉刷新
    kSelfWeak;
    [self addHeader:self.collectionView withCallback:^{
        [weakSelf getdata];
    }];

    //首次进入刷新
    [self.collectionView.header beginRefreshing];
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
-(void)initconmen
{
//    [AppDelegate shareAppDelegate].rootNavigationController.navigationItem.title = @"rrdddd";
}
#pragma mark 数据
-(void)getdata
{
     [self.bannerModule reloadModuleData];//加载广告模块数据
    [self.itemModule reloadModuleData];
    
    //3秒后结束刷新
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionView reloadData];
        //模拟结束刷新
        [self.collectionView.header endRefreshing];
        
    });
}


#pragma mark - UICollectionView
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSLog(@"count:%d",(int)self.moduleList.count);
    return self.moduleList.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell;
    
    if (indexPath.section<self.moduleList.count) {
        //每个Module对应一个Cell,Cell不复用,保证首页滑动流畅度
        NSString *identifier=[self.moduleIdDict objectForKey:self.moduleList[indexPath.section]];
        if (identifier==nil) {
            identifier=((LLBaseModule*)self.moduleList[indexPath.section]).moduleIdent;
            [self.moduleIdDict setObject:identifier forKey:self.moduleList[indexPath.section]];
            
            [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:identifier];
        }
        
        cell=[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
        //将module的view载入cell
        [self.moduleList[indexPath.section] addModuleViewToSuperView:cell.contentView];
    }
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return ((LLBaseModule*)self.moduleList[indexPath.section]).moduleViewSize;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 0;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusableView;
    
    if (kind == UICollectionElementKindSectionHeader) {
        reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HotHeaderView" forIndexPath:indexPath];
        LLBaseModule *module=self.moduleList[indexPath.section];
        [((HotHeaderView*)reusableView) setIconType:module.moduleSectionIcon title:module.moduleTitle action:module.moduleSectionAction];
        
    }
    
    return reusableView;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    CGSize size = ((LLBaseModule*)self.moduleList[section]).moduleTitle==nil?CGSizeZero:CGSizeMake(collectionView.frame.size.width, 35);
    
    return size;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    return CGSizeMake(collectionView.frame.size.width, 0);
}


@end
