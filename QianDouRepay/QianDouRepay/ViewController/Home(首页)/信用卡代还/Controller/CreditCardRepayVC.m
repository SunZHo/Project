//
//  CreditCardRepayVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/11.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "CreditCardRepayVC.h"

// view
#import "TYCyclePagerViewCell.h"
#import <TYCyclePagerView.h>
#import "CreditCardRepayView.h"
#import "MeunViewHorizon.h"
#import "NoCreditCardView.h"


// model
#import "CreditCardModel.h"

// controller
#import "AddRepayPlanViewController.h"
#import "AddCreditCardViewController.h"
#import "RepaymentPlanListVC.h"
#import "BillViewController.h"
#import "ChangeCreditCardVC.h"
#import "AuthorizedView.h"


@interface CreditCardRepayVC ()<TYCyclePagerViewDelegate,TYCyclePagerViewDataSource,MeunViewDelegate>

@property (nonatomic , strong) NSMutableArray *creditCardData;
@property (nonatomic , strong) TYCyclePagerView *pagerView;
@property (nonatomic , strong) CreditCardRepayView *cardRepyView;
@property (nonatomic , strong) UIButton *moreActionBtn; // 更多操作
@property (nonatomic , strong) UIButton *addRepayBtn;   // 新增还款计划
@property (nonatomic , strong) UIButton *repayListBtn;  // 还款计划列表
@property (nonatomic , strong) NoCreditCardView *noCreditView;
@property (nonatomic , copy) NSString *cardID;// 信用卡id
@property (nonatomic , copy) NSString *cardNum;// 信用卡号
@property (nonatomic , assign) BOOL isConfirm ; // 信用卡是否授权
@property (nonatomic , strong) CreditCardModel *credit_CardModel;

@end

@implementation CreditCardRepayVC

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"信用卡代还";
    self.view.backgroundColor = WhiteColor;
    
    [self setRightBarItems];
    
//    [self makeUI];
    
    
//    NSArray *arr = @[@"1000元",@"2000元",@"3000元"];
//    NSArray *arr1 = @[@"每月1日",@"每月2日",@"每月3日"];
//    NSArray *arr2 = @[@"每月11日",@"每月12日",@"每月13日"];
//    for (int i = 0; i < arr.count; i ++) {
//        CreditCardModel *model = [[CreditCardModel alloc]init];
//        model.money = arr[i];
//        model.statement_date = arr1[i];
//        model.repayment_date = arr2[i];
//        [self.creditCardData addObject:model];
//    }
//    [self makeUI];
//    if (self.creditCardData.count <= 1) {
//        self.pagerView.isInfiniteLoop = NO;
//    }
//    [self.pagerView reloadData];
    
}



- (void)makeUI{
    [self.view.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
//    [self.pagerView removeFromSuperview];
    self.pagerView = nil;
    self.moreActionBtn = nil;
    self.cardRepyView = nil;
    self.addRepayBtn = nil;
    self.repayListBtn = nil;
    [self.view addSubview:self.pagerView];
    [self.view addSubview:self.moreActionBtn];
    [self.view addSubview:self.cardRepyView];
    // (self.view, 64 + SafeAreaTopHeight+ kScaleWidth(200))
    self.moreActionBtn.sd_layout.topSpaceToView(self.pagerView, 0).centerXEqualToView(self.view).heightIs(40).widthIs(64);
    
    UIImageView *rowImg =[[UIImageView alloc]initWithImage:IMG(@"hjtou_Down")];
    [self.moreActionBtn addSubview:rowImg];
    
    UILabel *moreLabel = [AppUIKit labelWithTitle:@"更多操作" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
    [self.moreActionBtn addSubview:moreLabel];
    
    rowImg.sd_layout.topEqualToView(self.moreActionBtn).centerXEqualToView(self.moreActionBtn).widthIs(12).heightIs(7);
    moreLabel.sd_layout.topSpaceToView(rowImg, 12).centerXEqualToView(self.moreActionBtn).widthIs(64).heightIs(15);
    
    
    self.cardRepyView.sd_layout.topSpaceToView(self.moreActionBtn, kScaleWidth(20)).leftEqualToView(self.view).rightEqualToView(self.view).heightIs(kScaleWidth(200));
    
    [self.view addSubview:self.addRepayBtn];
    [self.view addSubview:self.repayListBtn];
    
    self.addRepayBtn.sd_layout.topSpaceToView(self.cardRepyView, kScaleWidth(25)).leftSpaceToView(self.view, 12).rightSpaceToView(self.view, 12).heightIs(kScaleWidth(40));
    self.addRepayBtn.sd_cornerRadius = @(5);
    
    self.repayListBtn.sd_layout.topSpaceToView(self.addRepayBtn, kScaleWidth(20)).leftSpaceToView(self.view, 100).rightSpaceToView(self.view, 100).heightIs(kScaleWidth(15));
    
}


- (void)loadData{
    [self.creditCardData removeAllObjects];
    NSDictionary *dic = @{@"userid" : UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:creditcard_list withParaments:dic withSuccessBlock:^(id json) {
        NSArray *infoArr = [json objectForKey:@"info"];
        if (infoArr.count > 0) {
            for (NSDictionary *cardDic in infoArr) {
                CreditCardModel *model = [CreditCardModel mj_objectWithKeyValues:cardDic];
                [self.creditCardData addObject:model];
            }
            [self makeUI];
            if (self.creditCardData.count <= 1) {
                self.pagerView.isInfiniteLoop = NO;
            }
            [self.pagerView reloadData];
        }else{
            [self.noCreditView removeFromSuperview];
            self.noCreditView = nil;
            [self.view addSubview:self.noCreditView];
        }
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        [self.noCreditView removeFromSuperview];
        self.noCreditView = nil;
        [self.view addSubview:self.noCreditView];
    }];
    
    
}




- (void)setRightBarItems{
    UIButton *billCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billCardBtn addTarget:self action:@selector(billClick) forControlEvents:UIControlEventTouchUpInside];
    [billCardBtn setTitle:@"账单" forState:UIControlStateNormal];
    billCardBtn.titleLabel.font = kFont(15);
    [billCardBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
    [billCardBtn sizeToFit];
    UIBarButtonItem *billItem = [[UIBarButtonItem alloc] initWithCustomView:billCardBtn];
    UIBarButtonItem *fixedSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    fixedSpaceBarButtonItem.width = 2;
    UIButton *plusBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [plusBtn addTarget:self action:@selector(plusClick) forControlEvents:UIControlEventTouchUpInside];
    [plusBtn setImage:[UIImage imageNamed:@"tj"] forState:UIControlStateNormal];
    [plusBtn sizeToFit];
    UIBarButtonItem *plusItem = [[UIBarButtonItem alloc] initWithCustomView:plusBtn];
    self.navigationItem.rightBarButtonItems  = @[plusItem,fixedSpaceBarButtonItem,billItem];
}

#pragma mark - 按钮点击

- (void)moreActionClick:(UIButton *)sender{
    UIButton *button = (UIButton *)sender;
    CGRect newRect = [button convertRect:button.bounds toView:[UIApplication sharedApplication].keyWindow];
    MeunViewHorizon *meun =[[MeunViewHorizon alloc]initWithFrame:CGRectMake(0, 0, 290, 70)];
    meun.delegate = self;
    [meun showInView:self.view targetRect:newRect animated:YES];
    
    
}

#pragma mark - 新增还款计划
- (void)pushRepayPlanVC{
    if (self.isConfirm) {
        AddRepayPlanViewController *repayPlanVc = [[AddRepayPlanViewController alloc]init];
        repayPlanVc.cardid = self.cardID;
        PUSHVC(repayPlanVc);
    }else{
        AuthorizedView *authView = [[AuthorizedView alloc]initWithFrame:CGRectZero andModel:self.credit_CardModel];
        authView.AuthorizedBlock = ^{
            [self loadData];
        };
        [authView show];
    }
}



#pragma mark - 还款计划列表
- (void)pushRepayListVC{
    RepaymentPlanListVC *repaymentListVc = [[RepaymentPlanListVC alloc]init];
    repaymentListVc.cardid = self.cardID;
    repaymentListVc.isFinish = NO;
    PUSHVC(repaymentListVc);
}

#pragma mark - 账单
- (void)billClick{
    BillViewController *billVc = [[BillViewController alloc]init];
    PUSHVC(billVc);
}

#pragma mark - 添加信用卡
- (void)plusClick{
    AddCreditCardViewController *addCreditVc = [[AddCreditCardViewController alloc]init];
    PUSHVC(addCreditVc);
}

#pragma mark - MeunView代理

- (void)meunViewDidSelectedIndex:(NSInteger)index{
    if (index == 0) { // 修改资料
        ChangeCreditCardVC *changeVc = [[ChangeCreditCardVC alloc]init];
        changeVc.cardid = self.cardID;
        changeVc.cardnum = self.cardNum;
        PUSHVC(changeVc);
    }else if (index == 1){ // 删除信用卡
        
        [self deleteCreditCard];
        
    }else if (index == 2){ // 已执行计划
        RepaymentPlanListVC *repaymentListVc = [[RepaymentPlanListVC alloc]init];
        repaymentListVc.cardid = self.cardID;
        repaymentListVc.isFinish = YES;
        PUSHVC(repaymentListVc);
    }
}

#pragma mark - 删除信用卡
- (void)deleteCreditCard{
    NSDictionary *dic = @{@"cardid":self.cardID,
                          @"userid":UserID
                          };
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:creditcard_delCard withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"删除成功"];
         [self loadData];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
    
}

#pragma mark - TYCyclePagerViewDataSource

- (NSInteger)numberOfItemsInPagerView:(TYCyclePagerView *)pageView {
    return self.creditCardData.count;
}

- (UICollectionViewCell *)pagerView:(TYCyclePagerView *)pagerView cellForItemAtIndex:(NSInteger)index {
    CreditCardModel *model = [self.creditCardData objectAtIndex:index];
    TYCyclePagerViewCell *cell = [pagerView dequeueReusableCellWithReuseIdentifier:@"cellId" forIndex:index];
    [cell setCardModel:model];
    
    return cell;
}

- (TYCyclePagerViewLayout *)layoutForPagerView:(TYCyclePagerView *)pageView {
    TYCyclePagerViewLayout *layout = [[TYCyclePagerViewLayout alloc]init];
    layout.itemSize = CGSizeMake(kScaleWidth(300), kScaleWidth(150));
    layout.itemSpacing = 16;
    //layout.minimumAlpha = 0.3;
    layout.layoutType = TYCyclePagerTransformLayoutLinear;
    layout.itemHorizontalCenter = YES;
    return layout;
}

- (void)pagerView:(TYCyclePagerView *)pageView didScrollFromIndex:(NSInteger)fromIndex toIndex:(NSInteger)toIndex {
    //[_pageControl setCurrentPage:newIndex animate:YES];
    NSLog(@"fromIndex-%ld ->  toIndex-%ld",fromIndex,toIndex);
    CreditCardModel *model = [self.creditCardData objectAtIndex:toIndex];
    self.cardRepyView.cardModel = model;
    self.cardID = model.ID;
    self.cardNum = model.bank_num;
    self.isConfirm = [model.is_confirm integerValue] == 0 ? NO : YES;
    self.credit_CardModel = model;
}

- (void)pagerView:(TYCyclePagerView *)pageView didSelectedItemCell:(__kindof UICollectionViewCell *)cell atIndex:(NSInteger)index{
    
}



#pragma mark - LazyLoad

- (TYCyclePagerView *)pagerView{
    if (!_pagerView) {
        _pagerView = [[TYCyclePagerView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, kScaleWidth(200))];
        
        _pagerView.isInfiniteLoop = YES;
        _pagerView.autoScrollInterval = 0;
        _pagerView.dataSource = self;
        _pagerView.delegate = self;
        [_pagerView registerClass:[TYCyclePagerViewCell class] forCellWithReuseIdentifier:@"cellId"];
    }
    return _pagerView;
}

- (CreditCardRepayView *)cardRepyView{
    if (!_cardRepyView) {
        _cardRepyView = [[CreditCardRepayView alloc]init];
    }
    return _cardRepyView;
}

- (UIButton *)moreActionBtn{
    if (!_moreActionBtn) {
        _moreActionBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:WhiteColor action:@selector(moreActionClick:) target:self title:@"" image:nil font:0 textColor:WhiteColor];
        
    }
    return _moreActionBtn;
}

- (UIButton *)addRepayBtn{
    if (!_addRepayBtn) {
        _addRepayBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(pushRepayPlanVC) target:self title:@"新增还款计划" image:nil font:13 textColor:HEXACOLOR(0x1e2674)];
    }
    return _addRepayBtn;
}

- (UIButton *)repayListBtn{
    if (!_repayListBtn) {
        _repayListBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:WhiteColor action:@selector(pushRepayListVC) target:self title:@"还款计划列表" image:nil font:13 textColor:defaultTextColor];
    }
    return _repayListBtn;
}

- (NSMutableArray *)creditCardData{
    if (!_creditCardData) {
        _creditCardData = [[NSMutableArray alloc]init];
    }
    return _creditCardData;
}

- (NoCreditCardView *)noCreditView{
    if (!_noCreditView) {
        _noCreditView = [[NoCreditCardView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - 64 - SafeAreaTopHeight)];
    }
    return _noCreditView;
}

@end
