//
//  LLTypesItemModule.m
//  loterryTicket
//
//  Created by luoluo on 2017/6/24.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "LLTypesItemModule.h"
#import "LLItemCell.h"
#import "AppDelegate.h"
#import "ViewCode.h"
#import "TypeDetailVC.h"


@implementation LLTypesItemModule

#pragma mark 属性
- (NSString *)moduleIdent{
    return [NSString stringWithFormat:@"LLTypesItemModule_%@",self.moduleTitle];
}


- (NSInteger)moduleSectionIcon{
    if (self.moduleType==LLItemModuleTypeHot) {
        return LLItemModuleTypeHot;
    }else if (self.moduleType==LLItemModuleTypeNew){
        return LLItemModuleTypeNew;
    }
    
    return 0;
}

-(NSMutableArray <LLBaseModel *> *)datalist
{
    if (!_datalist) {
        _datalist = [NSMutableArray array];
    }
    return _datalist;
}

#pragma mark 初始化

+ (id)initWithViewWidth:(CGFloat)width moduleType:(LLItemModuleType)type{
    
    LLTypesItemModule *module=[[LLTypesItemModule alloc] initWithViewFrame:
                               CGRectMake(0, 0, width, [LLItemCell cellSizetByWidth:width/2.0].height*2.0)];
    module.moduleType=type;
    
    //添加假数据
    [module createData];
    return module;
}

- (void)addModuleViewToSuperView:(UIView*)superView{
    
    if (self.moduleView==nil) {
        //[superView layoutIfNeeded];
        self.moduleView=[LLItemView initViewWithFrame:CGRectMake(0, 0, superView.frame.size.width,superView.frame.size.height)];
        [superView addSubview:self.moduleView];
    }
    
    [self.moduleView updateModuleDatas:self.datalist];
}



#pragma mark 数据
-(NSArray *)localData
{
    NSArray *array = @[@{@"imageName":@"\U0000e608",@"descript":@"7个号码",@"title":@"六合彩",@"type":@(DetailTypeSix)},
  @{@"imageName":@"\U0000e60e",@"descript":@"7位数",@"title":@"时时彩",@"type":@(DetailTypeTime)},
  @{@"imageName":@"\U0000e633",@"descript":@"3位数",@"title":@"十一选五",@"type":@(DetailTypeEleven)},
  @{@"imageName":@"\U0000e604",@"descript":@"1-80个号码",@"title":@"快乐8",@"type":@(DetailTypeQuikely)}];
    return array;
}
-(void)createData
{
    self.moduleTitle = @"热点关注";
}

- (void)getDataFromServer{
    
    //添加假数据
    NSArray *lists = [self localData];
    
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i<lists.count; i++) {
        NSDictionary *dict = lists[i];
        LLItemModel *model = [[LLItemModel alloc]init];
        model.imageName = [dict objectForKey:@"imageName"];
        model.descript = [dict objectForKey:@"descript"];
        model.title = [dict objectForKey:@"title"];
        model.type = [[dict objectForKey:@"type"]integerValue];
        
        [array addObject:model];
    }
    [self.datalist setArray:array];
    //刷新模块内部的view
    [self.moduleView updateModuleDatas:self.datalist];
    
}

- (void)reloadModuleData{
    [self getDataFromServer];
}

//- (void)reloadModuleData{
//    [self.moduleView updateModuleDatas:self.datalist];
//}


#pragma mark 点击事件
//返回点击section
-(SectionActionBlcok)moduleSectionAction
{
    if (self.moduleType == LLItemModuleTypeHot) {
        return ^{
            NSLog(@"点击更多热点...");
        };
    }
    
    return nil;
}

@end

@interface LLItemView ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) NSMutableArray <LLBaseModel *> *dataList;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,strong) NSArray *initialList;

@end

@implementation LLItemView

-(NSMutableArray <LLBaseModel *> *)dataList
{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}
+ (id)initViewWithFrame:(CGRect)frame{
    
    NSArray *views=[[UINib nibWithNibName:@"LLItemView" bundle:nil] instantiateWithOwner:nil options:nil];
    LLItemView *videoItemView=views[0];
    //更新下模块view的尺寸
    videoItemView.frame=frame;
    
    return videoItemView;
}

- (void)awakeFromNib{
    [super awakeFromNib];
    
    self.autoresizesSubviews=YES;
    //[self layoutIfNeeded];
    self.collectionView.alwaysBounceVertical = YES;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"LLItemCell" bundle:nil]
          forCellWithReuseIdentifier:@"LLItemCell"];
}

#pragma mark 分类方法
- (void)updateModuleDatas:(NSArray *)datalist{
    
    if (self.dataList!=datalist) {
//        self.dataList=datalist;
        [self.dataList setArray:datalist];
        self.initialList=datalist;
        self.index=1;
        
        [self.collectionView reloadData];
    }
}

//- (void)sortData{
//    
//    if (self.initialList.count<= 4) return;
//    
//    if (self.initialList.count<(self.index+1)*4) self.index=0; //下一组不够4个时回到第一组
//    
//    self.dataList=@[self.initialList[(self.index*4)],
//                    self.initialList[(self.index*4)+1],
//                    self.initialList[(self.index*4)+2],
//                    self.initialList[(self.index*4)+3]];
//    [self.collectionView reloadData];
//    
//    self.index++;
//    self.index=self.index>=self.initialList.count/4?0:self.index;
//}

#pragma mark UICollectionViewDelegate
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"itemCellCount:%d",(int)self.dataList.count);
    return self.dataList.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    LLItemCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"LLItemCell" forIndexPath:indexPath];
    
    if (indexPath.item<self.dataList.count) {
        [cell cellWithModel:self.dataList[indexPath.item]];
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.item<self.dataList.count) {
        
        NSLog(@"点击Itemcell...");
        LLItemModel *model = (LLItemModel *)self.dataList[indexPath.item];
        
        TypeDetailVC *detailVc = [[UIStoryboard storyboardWithName:@"LLMain" bundle:nil] instantiateViewControllerWithIdentifier:@"TypeDetailVC"];
        detailVc.itemModel = model;

        [self.viewController.navigationController pushViewController:detailVc animated:NO];
    }
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    CGFloat width=(collectionView.bounds.size.width-10)/2.0;
    return [LLItemCell cellSizetByWidth:width];
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    
    return 10;
}
@end


