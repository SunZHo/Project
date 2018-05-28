//
//  HomeViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "HomeViewController.h"

// view
#import "HomeCollectView.h"
#import "HomeAboveView.h"
#import "XBTextLoopView.h"
#import "UplevelView.h"

// controller
#import "LoginViewController.h"
#import "CreditCardRepayVC.h"
#import "BillViewController.h"
#import "QuickCollectionVC.h"
#import "MyDividedProfitVC.h"
#import "MyFeeRateViewController.h"
#import "ChoosePayWayVC.h"
#import "MessageViewController.h"
#import "NoticeDetailVC.h"
#import "UploadPicViewController.h"


@interface HomeViewController ()<HomeCollentViewDelegate,HomeAboveViewDelegate,SDCycleScrollViewDelegate,UIAlertViewDelegate>

@property (nonatomic , strong) UIScrollView *backGroundScrollV;
@property (nonatomic , strong) SDCycleScrollView *bannerView;
@property (nonatomic , strong) XBTextLoopView *textLoopView; // 公告滚动
@property (nonatomic , strong) UIView *reportView;  // 公告view
@property (nonatomic , copy) NSArray *bannerData;
@property (nonatomic , assign) NSInteger pay_status ;// 升级VIP付费状态 ：付费状态:0未付费，1已付费，2-审核中
@property (nonatomic , copy) NSArray *newsArray;


@end

@implementation HomeViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if ([LoginStatus integerValue] == 1) {
        [self checkPayStatus];
        [self loadNewsData];
    }else{
        [self.navigationItem.rightBarButtonItem pp_hiddenBadge];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = Default_BackgroundGray;
    
    [super setNavAlphaZero];
    
    [self setupRightBarButtonItem];
    
    [self makeUI];
    
    [self loadData];
    
}

- (void)makeUI{
    
    [self.view addSubview:self.backGroundScrollV];
    
    [self.backGroundScrollV addSubview:self.bannerView];
//    self.bannerView.sd_layout.topEqualToView(self.backGroundScrollV).leftEqualToView(self.backGroundScrollV).rightEqualToView(self.backGroundScrollV).heightIs(225);
    
    HomeAboveView *aboveView = [[HomeAboveView alloc]initWithFrame:CGRectMake(kScaleWidth(12), 200,kScaleWidth(351), 73)];
    aboveView.delegate = self;
    [self.backGroundScrollV addSubview:aboveView];
    
    [self.backGroundScrollV addSubview:self.reportView];
    self.textLoopView = [XBTextLoopView textLoopViewinitWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 100, 44) selectBlock:^(NSString *selectString, NSInteger index) {
        NSDictionary *dic = self.newsArray[index];
//        NSLog(@"%@===index%ld", dic, index);
        NoticeDetailVC *detailVc = [[NoticeDetailVC alloc]init];
        detailVc.notiID = [dic objectForKey:@"id"];
        detailVc.isNoti = YES;
        PUSHVC(detailVc);
        
    }];
    [self.reportView addSubview:self.textLoopView];
    
    HomeCollectView *collView = [[HomeCollectView alloc]initWithFrame:CGRectMake(kScaleWidth(12), 335,kScaleWidth(351), 266)];
    collView.delegate = self;
    [self.backGroundScrollV addSubview:collView];
    
}



- (void)loadData{
    [self loadBannerData];
    [self loadReportData];
}



- (void)loadReportData{
    [AppNetworking requestWithType:HttpRequestTypeGet withUrlString:home_reportUrl withParaments:nil withSuccessBlock:^(id json) {
        NSMutableArray *arr = [NSMutableArray array];
        self.newsArray = [json objectForKey:@"info"];
        for (NSDictionary *dic in self.newsArray) {
            [arr addObject:[dic objectForKey:@"title"]];
        }
        self.textLoopView.dataSource = arr;
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}

- (void)loadBannerData{
    MJWeakSelf;
    [AppNetworking requestWithType:HttpRequestTypeGet withUrlString:home_bannerUrl withParaments:nil withSuccessBlock:^(id json) {
        weakSelf.bannerData = [json objectForKey:@"info"];
        
        NSMutableArray *arr = [[NSMutableArray alloc]init];
        for (NSDictionary *dic in weakSelf.bannerData) {
            if ([[dic objectForKey:@"is_show"]integerValue] == 1) {
                [arr addObject:[dic objectForKey:@"image"]];
            }
        }
        self.bannerView.imageURLStringsGroup = arr;
        [_backGroundScrollV.mj_header endRefreshing];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}

- (void)loadNewsData{
    if ([LoginStatus integerValue] == 1) {
        NSDictionary *dic = @{@"userid" : UserID};
        [AppNetworking requestWithType:HttpRequestTypePost withUrlString:home_newscountUrl withParaments:dic withSuccessBlock:^(id json) {
            NSDictionary *infoDic = [json objectForKey:@"info"];
            NSInteger count = [[infoDic objectForKey:@"count"] integerValue];
            if (count > 0) {
                [self.navigationItem.rightBarButtonItem pp_addDotWithColor:WhiteColor];
            }else{
                [self.navigationItem.rightBarButtonItem pp_hiddenBadge];
            }
        } withFailureBlock:^(NSString *errorMessage, int code) {
            
        }];
    }
}

- (void)checkPayStatus{
    NSDictionary *dic = @{@"userid" : UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:home_VipPayStatusUrl withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        self.pay_status = [[infoDic objectForKey:@"pay_status"] integerValue];
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}

- (void)upgradeInfo{
    NSDictionary *dic = @{@"userid" : UserID};
     MJWeakSelf;
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:home_VipPayInfoUrl withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        NSString *money = [infoDic objectForKey:@"vip_money"];
        NSString *msg= [infoDic objectForKey:@"vip_msg"];
        NSString *moneyStr = [NSString stringWithFormat:@"%@\n%@元",msg,money];
        NSAttributedString *attrStr = [AppCommon getRange:NSMakeRange(msg.length, [NSString stringWithFormat:@"%@元",money].length) labelStr:moneyStr Font:kFont(18) Color:HEXACOLOR(0xff000e)];
        UplevelView *uplevelV = [[UplevelView alloc]init];
        uplevelV.infoStr = attrStr;
        uplevelV.payClickBlock = ^{
            ChoosePayWayVC *payVC = [[ChoosePayWayVC alloc]init];
            payVC.payMoney = money;
            [weakSelf.navigationController pushViewController:payVC animated:YES];
        };
        [uplevelV show];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
}

#pragma mark - 导航按钮
- (void)setupRightBarButtonItem
{
    self.navigationItem.rightBarButtonItem = ({
        [[UIBarButtonItem alloc]initWithImage:IMG(@"xz") style:UIBarButtonItemStylePlain target:self
                                                     action:@selector(rightBarButtonItemClicked)];
    });
}

- (void)rightBarButtonItemClicked{
    if ([LoginStatus integerValue] == 0) {
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [self presentViewController:nav animated:NO completion:nil];
    }else{
        MessageViewController *messageVc = [[MessageViewController alloc]init];
        PUSHVC(messageVc);
    }
    
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        UploadPicViewController *uploadvc = [[UploadPicViewController alloc]init];
        PUSHVC(uploadvc);
    }
}

#pragma mark - HomeCollectViewDelegate

- (void)didSelectHomeCollentViewAtIndex:(NSInteger)index{
    NSLog(@"SelectIndex == %ld",index);
    if ([LoginStatus integerValue] == 0) {
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [self presentViewController:nav animated:NO completion:nil];
    }else{
        if (index == 0) { // 我要升级
            if (self.pay_status == 0) {
                [self upgradeInfo];
            }else if (self.pay_status == 1){
                [self showErrorText:@"您已是VIP"];
            }else if (self.pay_status == 2){
                [self showErrorText:@"审核中"];
            }
            
            
        }else if (index == 1){ // 我的分润
            MyDividedProfitVC *devidePro = [[MyDividedProfitVC alloc]init];
            PUSHVC(devidePro);
        }else if (index == 2){ // 我的费率
            MyFeeRateViewController *feeVc = [[MyFeeRateViewController alloc]init];
            PUSHVC(feeVc);
        }else if (index == 3){ // 申请信用卡
            [self showSuccessText:@"敬请期待"];
//            QDWebViewController *web = [[QDWebViewController alloc]init];
//            web.loadUrl = @"https://www.baidu.com";
//            [self.navigationController pushViewController:web animated:YES];
        }else if (index == 4){ // 保险
            [self showSuccessText:@"敬请期待"];
        }else if (index == 5){ // 贷款
            [self showSuccessText:@"敬请期待"];
        }
    }
    
    
    
}


#pragma mark - HomeAboveViewDelegate
- (void)didSeleHomeAboveViewAtIndex:(NSInteger)index{
    NSLog(@"SelectIndex == %ld",index);
    if ([LoginStatus integerValue] == 1) { // 是否登录
        if ([[UserInfoDic objectForKey:@"is_confirm"] integerValue] == 1) { // 是否实名认证
            if (index == 0) { // 信用卡代还
                CreditCardRepayVC *repayVC = [[CreditCardRepayVC alloc]init];
                PUSHVC(repayVC);
            }else{ // 快捷收款
                QuickCollectionVC *quickVC = [[QuickCollectionVC alloc]init];
                PUSHVC(quickVC);
            }
        }else{
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"未实名认证" message:@"实名认证后方可使用" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
        }
    }else{
        LoginViewController *loginVc = [[LoginViewController alloc]init];
        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
        [self presentViewController:nav animated:NO completion:nil];
    }
    
}

#pragma mark - SDCycleScrollViewDelegate
//轮播图点击，SDCycleScrollView代理方法中点击图片回掉方法
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    //    NSDictionary *dic = [self.bannerData objectAtIndex:index];
    //    NSString *url = [dic safeObjectForKey:@"adurl"];
}

#pragma mark - LazyLoad

- (UIScrollView *)backGroundScrollV{
    MJWeakSelf;
    if (!_backGroundScrollV) {
        _backGroundScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -(64 + SafeAreaTopHeight), SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
        _backGroundScrollV.backgroundColor = Default_BackgroundGray;
        _backGroundScrollV.contentSize = CGSizeMake(SCREEN_WIDTH, 618);
        _backGroundScrollV.showsVerticalScrollIndicator = NO;
        _backGroundScrollV.showsHorizontalScrollIndicator = NO;
        _backGroundScrollV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadData];
        }];
    }
    return _backGroundScrollV;
}



- (SDCycleScrollView *)bannerView{
    if (!_bannerView) {
        _bannerView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 225) delegate:self placeholderImage:[UIImage imageNamed:@"home_banner"]];
        _bannerView.autoScrollTimeInterval = 5.0;
        //        _bannerView.localizationImageNamesGroup = @[@"bannerimg",@"bannerimg"];
    }
    return _bannerView;
}

- (UIView *)reportView{
    if (!_reportView) {
        _reportView = [[UIView alloc]initWithFrame:CGRectMake(0, 281, SCREEN_WIDTH, 44)];
        _reportView.backgroundColor = [UIColor whiteColor];
        UIImageView *leftImg = [[UIImageView alloc]init];
        leftImg.image = IMG(@"hg");
        leftImg.contentMode = UIViewContentModeScaleAspectFit;
        [_reportView addSubview:leftImg];
        
        leftImg.sd_layout.leftSpaceToView(_reportView, 13).centerYEqualToView(_reportView).widthIs(76).heightIs(17);
        
        
    }
    return _reportView;
}





@end
