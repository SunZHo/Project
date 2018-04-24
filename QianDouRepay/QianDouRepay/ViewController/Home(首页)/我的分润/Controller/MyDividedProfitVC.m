//
//  MyDividedProfitVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MyDividedProfitVC.h"
#import "DivideRecordViewController.h"
@interface MyDividedProfitVC ()

@property (nonatomic , strong) UIScrollView *backGroundScrollV;
@property (nonatomic , strong) UIView *topBlueView;  // 公告view
@property (nonatomic , strong) UIView *collectionV;
@property (nonatomic , strong) UIButton *recordBtn;
@property (nonatomic , copy) NSArray *nameArray;
@property (nonatomic , copy) NSArray *valueArray;
@property (nonatomic , copy) NSString *totalMoney;


@end

@implementation MyDividedProfitVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的分润";
    [super setNavAlphaZero];
    [self wr_setNavBarTitleColor:WhiteColor];
    
    [self loadData];
}

- (void)makeUI{
    
    [self.view addSubview:self.backGroundScrollV];
    
    [self.backGroundScrollV addSubview:self.topBlueView];
    
    [self.backGroundScrollV addSubview:self.collectionV];
    
    [self.backGroundScrollV addSubview:self.recordBtn];
    self.recordBtn.sd_layout.topSpaceToView(self.collectionV, 10).leftSpaceToView(self.backGroundScrollV, 12).heightIs(44).rightSpaceToView(self.backGroundScrollV, 12);
    self.recordBtn.sd_cornerRadius = @(5);
    
}



- (void)loadData{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//
//    });
    [self.topBlueView removeFromSuperview];
    [self.collectionV removeFromSuperview];
    self.totalMoney = @"100.00";
    self.topBlueView = nil;
    self.collectionV = nil;
    [self.backGroundScrollV addSubview:self.topBlueView];
    [self.backGroundScrollV addSubview:self.collectionV];
    
    [self.view layoutSubviews];
    [self makeUI];
    [_backGroundScrollV.mj_header endRefreshing];
    
}

- (void)recordClick{
    
//    pageViewController *vc = [[pageViewController alloc]init];
//    PUSHVC(vc);
    
    DivideRecordViewController *divideVC = [[DivideRecordViewController alloc]init];
    PUSHVC(divideVC);
}


#pragma mark - LazyLoad

- (UIScrollView *)backGroundScrollV{
    if (!_backGroundScrollV) {
        _backGroundScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, -(64 + SafeAreaTopHeight), SCREEN_WIDTH, SCREEN_HEIGHT + (64 + SafeAreaTopHeight))];
        _backGroundScrollV.backgroundColor = WhiteColor;
        _backGroundScrollV.contentSize = CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT);
        _backGroundScrollV.showsVerticalScrollIndicator = NO;
        _backGroundScrollV.showsHorizontalScrollIndicator = NO;
        MJWeakSelf
        _backGroundScrollV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadData];
        }];
    }
    return _backGroundScrollV;
}

- (UIView *)topBlueView{
    if (!_topBlueView) {
        _topBlueView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 200)];
        _topBlueView.backgroundColor = HEXACOLOR(0x36b4fc);
        UILabel *name = [AppUIKit labelWithTitle:@"累计收益(元)" titleFontSize:12 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        UILabel *value = [AppUIKit labelWithTitle:self.totalMoney titleFontSize:30 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        [_topBlueView sd_addSubviews:@[name,value]];
        name.sd_layout.topSpaceToView(_topBlueView, 100).leftEqualToView(_topBlueView).rightEqualToView(_topBlueView).heightIs(12);
        value.sd_layout.topSpaceToView(name, 23).leftEqualToView(_topBlueView).rightEqualToView(_topBlueView).heightIs(23);
    }
    return _topBlueView;
}

- (UIView *)collectionV{
    if (!_collectionV) {
        _collectionV = [[UIView alloc]initWithFrame:CGRectMake(0, 200, SCREEN_WIDTH, 200)];
        NSInteger columnNum = 2;
        
        CGFloat btnW = _collectionV.frame.size.width / 2;
        CGFloat btnH = _collectionV.frame.size.height / 2;
        CGFloat margin = (_collectionV.frame.size.width - columnNum * btnW) / (columnNum + 1);
        
        for (int i = 0; i < self.nameArray.count; i ++) {
            int row = i/columnNum;//行号
            //     1/3=0,  2/3=0,  3/3=1;
            int loc = i%columnNum;//列号
            CGFloat btnX = margin + (margin + btnW) * loc;
            CGFloat btnY = margin + (margin + btnH) * row;
            UIButton *bottomView = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
            bottomView.tag = 10 + i;
//            [bottomView addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
            UILabel *nameL = [AppUIKit labelWithTitle:self.nameArray[i] titleFontSize:13 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:NSTextAlignmentCenter];
            
            [bottomView addSubview:nameL];
            
            nameL.sd_layout.topSpaceToView(bottomView, 32).centerXEqualToView(bottomView).widthIs(btnW).heightIs(13);
            
            UILabel *label = [[UILabel alloc]init];
            label.text = self.valueArray[i];
            label.textAlignment = NSTextAlignmentCenter;
            label.textColor = defaultTextColor;
            label.font = kFont(18);
            [bottomView addSubview:label];
            
            label.sd_layout.topSpaceToView(nameL, 12).widthIs(btnW).leftEqualToView(bottomView).heightIs(15);
            
            [_collectionV addSubview:bottomView];
        }
    }
    return _collectionV;
}

- (UIButton *)recordBtn{
    if (!_recordBtn) {
        _recordBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(recordClick) target:self title:@"分润记录" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
    }
    return _recordBtn;
}

- (NSArray *)nameArray{
    if (!_nameArray) {
        _nameArray = @[@"可提现分润(元)",@"冻结金额(元)",@"收款分润(元)",@"还款金额(元)",];
    }
    return _nameArray;
}

- (NSArray *)valueArray{
    if (!_valueArray) {
        _valueArray = @[@"0.00",@"0.00",@"0.00",@"0.00",];
    }
    return _valueArray;
}




@end
