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

// controller
#import "LoginViewController.h"
#import "CreditCardRepayVC.h"
#import "BillViewController.h"
#import "QuickCollectionVC.h"
#import "MyDividedProfitVC.h"
#import "MyFeeRateViewController.h"

#import "TabBarVC.h"


@interface HomeViewController ()<HomeCollentViewDelegate,HomeAboveViewDelegate>

@property (nonatomic , strong) UIScrollView *backGroundScrollV;
@property (nonatomic , strong) UIImageView *bannerView;
@property (nonatomic , strong) XBTextLoopView *textLoopView; // 公告滚动
@property (nonatomic , strong) UIView *reportView;  // 公告view


@end

@implementation HomeViewController

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
    self.bannerView.sd_layout.topEqualToView(self.backGroundScrollV).leftEqualToView(self.backGroundScrollV).rightEqualToView(self.backGroundScrollV).heightIs(225);
    
    HomeAboveView *aboveView = [[HomeAboveView alloc]initWithFrame:CGRectMake(kScaleWidth(12), 200,kScaleWidth(351), 73)];
    aboveView.delegate = self;
    [self.backGroundScrollV addSubview:aboveView];
    
    [self.backGroundScrollV addSubview:self.reportView];
    self.textLoopView = [XBTextLoopView textLoopViewinitWithFrame:CGRectMake(100, 0, SCREEN_WIDTH - 100, 44) selectBlock:^(NSString *selectString, NSInteger index) {
        
        NSLog(@"%@===index%ld", selectString, index);
        
    }];
    [self.reportView addSubview:self.textLoopView];
    
    HomeCollectView *collView = [[HomeCollectView alloc]initWithFrame:CGRectMake(kScaleWidth(12), 335,kScaleWidth(351), 266)];
    collView.delegate = self;
    [self.backGroundScrollV addSubview:collView];
    
    
}



- (void)loadData{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.textLoopView.dataSource = @[@"我是跑马灯"];
    });
    
}


#pragma mark - 导航按钮
- (void)setupRightBarButtonItem
{
    self.navigationItem.rightBarButtonItem =({
        [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                                     target:self
                                                     action:@selector(rightBarButtonItemClicked)];
    });
}

- (void)rightBarButtonItemClicked{
//    LoginViewController *loginVc = [[LoginViewController alloc]init];
//    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
//    [self presentViewController:nav animated:NO completion:nil];
    
    TabBarVC *vc = [[TabBarVC alloc]init];
    [self presentViewController:vc animated:YES completion:nil];
}



#pragma mark - HomeCollectViewDelegate

- (void)didSelectHomeCollentViewAtIndex:(NSInteger)index{
    NSLog(@"SelectIndex == %ld",index);
    
    if (index == 0) { // 我的账单
        BillViewController *billVc = [[BillViewController alloc]init];
        PUSHVC(billVc);
    }else if (index == 1){ // 我的分润
        MyDividedProfitVC *devidePro = [[MyDividedProfitVC alloc]init];
        PUSHVC(devidePro);
    }else if (index == 2){ // 我的费率
        MyFeeRateViewController *feeVc = [[MyFeeRateViewController alloc]init];
        PUSHVC(feeVc);
    }else if (index == 3){ // 申请信用卡
        
    }else if (index == 4){ // 保险
        
    }else if (index == 5){ // 贷款
        
    }
    
    
}


#pragma mark - HomeAboveViewDelegate
- (void)didSeleHomeAboveViewAtIndex:(NSInteger)index{
    NSLog(@"SelectIndex == %ld",index);
    if (index == 0) { // 信用卡代还
        CreditCardRepayVC *repayVC = [[CreditCardRepayVC alloc]init];
        PUSHVC(repayVC);
    }else{ // 快捷收款
        QuickCollectionVC *quickVC = [[QuickCollectionVC alloc]init];
        PUSHVC(quickVC);
    }
}


#pragma mark - LazyLoad

- (UIScrollView *)backGroundScrollV{
    if (!_backGroundScrollV) {
        _backGroundScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -(64 + SafeAreaTopHeight), SCREEN_WIDTH, SCREEN_HEIGHT + 20)];
        _backGroundScrollV.backgroundColor = Default_BackgroundGray;
        _backGroundScrollV.contentSize = CGSizeMake(SCREEN_WIDTH, 618);
        _backGroundScrollV.showsVerticalScrollIndicator = NO;
        _backGroundScrollV.showsHorizontalScrollIndicator = NO;
        _backGroundScrollV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [_backGroundScrollV.mj_header endRefreshing];
            });
        }];
    }
    return _backGroundScrollV;
}


- (UIImageView *)bannerView{
    if (!_bannerView) {
        _bannerView = [[UIImageView alloc]init];
        _bannerView.image = IMG(@"home_banner");
//        _bannerView.contentMode = UIViewContentModeScaleAspectFit;
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
