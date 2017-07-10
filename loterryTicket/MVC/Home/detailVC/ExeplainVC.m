//
//  ExeplainVC.m
//  loterryTicket
//
//  Created by gleeeli on 2017/7/3.
//  Copyright © 2017年 luoluo. All rights reserved.
//

#import "ExeplainVC.h"

@interface ExeplainVC ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *testView;

@end

@implementation ExeplainVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
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
     [self initCommon];
    [self creatContent];
}
#pragma mark 初始化

-(void)initCommon
{
    self.navigationItem.title = [NSString stringWithFormat:@"%@说明",self.itemModel.title];
}

-(void)creatContent
{
    switch (self.itemModel.type) {
        case DetailTypeSix:
        {
            self.testView.text = @"每注单式投注，从设定数字中选出6个数字。复式”投注: 选出超过6个数字，中奖机会及投注金额需要计算出全部可能的6个数字组合，胆拖”投注: 选出超过6个数字，其中一个或以上作为“胆”。中奖机会及投注金额需要从所选数字中计算出全部可能的6个数字组合，但每个组合中必须包括作“胆”的数字。开彩时以自动机械搅珠，从设定数字彩球中抽出六个中奖号码及一个特别号码。过程由电视台注明“现场直播”。派彩：先从投注彩池中派出所有四至七奖，然后再扣出金多宝累积。剩余彩池按 45%:15%:40% 比例分成头、二、三奖彩池，供中奖人平分。倘若头、或二、三奖无人中，该项彩池进入累积彩池。一般来说，头奖彩池包括之前的累积多宝；唯若该期属金多宝搞珠，则累积多宝会计算入金多宝当中 (举例：若累积多宝少于金多宝，则头奖彩池的多宝仍为原定金多宝数额；若累积多宝多于金多宝，则头奖彩池的多宝会等同多宝的数额)。在以上情况下，任何剩余的多宝会拨入金多宝基金。而根据六合彩奖券规例3.16 有关奖金基金在必要时的重新分配：(a) 如四奖、五奖、六奖及七奖奖金的奖金总额超过奖金基金的60%，将由金多宝彩池拨支支付四奖、五奖、六奖及七奖奖金所款项之余额。(b) 倘若奖金基金60%的款额。加上金多宝彩池现存的总额，仍不足以全数支付全部四奖、五奖、六奖及七奖奖金款额，则四奖、五奖、六奖及七奖的所有奖金将同时按比例调低，且四奖奖金仍应为五奖奖金的15倍，五奖奖金仍应为六奖奖金的2倍，六奖奖金仍应为七奖奖金的8倍。之后，每一奖金必须调低至与注项单位最接近的整数倍数。(c) 倘若奖金基金在扣除金多宝扣数及支付四奖、五奖、六奖及七奖奖金后，其余额不足支付头奖、二奖及三奖奖金的最低款额，则差额部份将由金多宝彩池拨支。而头奖、二奖及三奖奖金应调低至与注项单位最接近的整数倍数。(d) 若奖金基金及金多宝彩池作出支付四奖、五奖、六奖及七奖奖金所需款项之预计扣数后，不足以支付头奖、二奖及三奖奖金的最低款额，则所有的奖金将同时按比例调低。且头奖奖金应为二奖奖金的两倍，二奖奖金应为三奖奖金的2倍，三奖奖金应为四奖奖金的2倍，四奖奖金应为五奖奖生的15倍，五奖奖金应为六奖奖金的2倍，而六奖奖金则应为七奖奖金的8倍。在必要时，所有奖金均应调低至与注项单位最接近的整数倍数，任何因此而产生的余款将拨回金多宝彩池。";
        }
            break;
        case DetailTypeTime:
        {
            self.testView.text = @"时时彩是一种在线即开型彩票玩法，属于基诺型彩票，由福利彩票发行管理中心负责承销。时时彩投注区分为万位、千位、百位、十位和个位，各位号码范围为0～9。每期从各位上开出1个号码作为中奖号码，即开奖号码为5位数。时时彩玩法即是竞猜5位开奖号码的全部号码、部分号码或部分号码特征。时时彩分星彩玩法和大小单双玩法。星彩玩法包括五星、三星、二星和一星。直选：将投注号码以惟一的排列方式进行投注。组选：将投注号码的所有排列方式作为一注投注号码进行投注。示例：123，排列方式有123、132、213、231、312、321，共计6种。组选三：在三星组选中，如果一注组选号码的3个数字有两个数字相同，则有3种不同的排列方式，因而就有3个中奖机会，这种组选投注方式简称组选三。示例：112，排列方式有112、121、211。组选六：在三星组选中，如果一注组选号码的3个数字各不相同，则有6种不同的排列方式，因而就有6个中奖机会，这种组选投注方式简称组选六。示例：123，排列方式有123、132、213、231、312、321，共计6种。大小单双：号码0～9中，0～4为小，5～9为大，1、3、5、7、9为单，0、2、4、6、8为双。";
        }
            break;
        case DetailTypeEleven:
        {
            self.testView.text = @"从11个号码中任选1个号码的投注为“任选一”；选2个号码的投注分为“任选二”、“选前二”；选3个号码的投注分为“任选三”、“选前三”； 选4个号码的投注为“任选四”；选5个号码的投注为“任选五”；选6个号码的投注为“任选六”；选7个号码的投注为“任选七”；选8个号码的投注为“任选八”。第六条 “选前二”、“选前三”投注方式分为直选投注和组选投注。直选投注：所选2个或3个号码与当期顺序摇出的5个号码中的前2个或3个号码一一对应进行的投注。组选投注：所选2个或3个号码与当期顺序摇出的5个号码中的前2个或3个号码不按先后，均作为一注投注号码进行的投注。第七条 除单式投注外、购买者还可进行复式投注、胆拖投注、多倍投注。复式投注是指所选号码个数超过单式投注的号码个数，按该单式投注方式组成多注彩票的投注。胆拖投注是指先选取少于单式投注号码个数的号码作为胆码（即每注彩票均包含的号码），再选取除胆码以外的号码作为拖码，胆码与拖码个数之和须多于单式投注号码个数，由胆码与拖码按该单式投注方式组成多注彩票的投注。多倍投注是指对选定结果不超过99倍的投注。第八条 单张彩票最大投注金额不超过20000元。第九条 购买者可在当地省体育彩票管理中心设置的投注站进行投注。投注号码可由投注机随机产生，也可通过投注单将购买者选定的号码输入投注机确定。投注号码经系统确认后打印出的兑奖凭证即为“11选5”电脑体育彩票，交购买者保存。第十条 “11选5”电脑体育彩票每期全部投注号码的可投注数量实行动态控制，如投注号码受限，则不能投注。第十一条 若因销售终端故障、通讯线路故障和投注站信用额度受限等原因造成投注不成功，应退还投注者投注金额。";
        }
            break;
        case DetailTypeQuikely:
        {
            self.testView.text = @"玩法简单：只需从80个号码中任意选择1-10个号码即可";
        }
            break;
        default:
            break;
    }
}

#pragma mark UITextViewDelegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    return NO;
}
@end
