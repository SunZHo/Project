//
//  TakeOutCashVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "TakeOutCashVC.h"

// view
#import "TakeOutCashBankView.h"
#import "TakeCashResultView.h"

// vc
#import "CashRecordViewController.h"
#import "AddBankCardVC.h"

@interface TakeOutCashVC ()<UITextFieldDelegate>

@property (nonatomic , strong) TakeOutCashBankView *bankView;

/** 可提现金额 */
@property (nonatomic , strong) UILabel *aviliableLabel;

/** 输入金额 */
@property (nonatomic , strong) UITextField *inputMoneyTF;

/** 全部提现 */
@property (nonatomic , strong) UIButton *takeAllButton;

/** 手续费 */
@property (nonatomic , strong) UILabel *cashFeeLabel;

/** 确认提现 */
@property (nonatomic , strong) UIButton *sureButton;

/**  */
@property (nonatomic , strong) UILabel *explanLabel;

@property (nonatomic , copy) NSString *member_cash;// 提现手续费
@property (nonatomic , copy) NSString *account_money; // 可提现金额min_money
@property (nonatomic , copy) NSString *min_money; // 起提金额
@end

@implementation TakeOutCashVC

- (void)viewWillAppear:(BOOL)animated{
    [self loadBankData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = WhiteColor;
    self.title = @"提现";
    [self setNavRightBarItem];
    
    [self makeUI];
    
    [self loadData];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFiledTextDidChanged) name:UITextFieldTextDidChangeNotification object:nil];
}


- (void)setNavRightBarItem{
    UIButton *billCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billCardBtn addTarget:self action:@selector(takeOutRecord) forControlEvents:UIControlEventTouchUpInside];
    [billCardBtn setTitle:@"提现记录" forState:UIControlStateNormal];
    billCardBtn.titleLabel.font = kFont(15);
    [billCardBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
    [billCardBtn sizeToFit];
    UIBarButtonItem *billItem = [[UIBarButtonItem alloc] initWithCustomView:billCardBtn];
    self.navigationItem.rightBarButtonItems  = @[billItem];
}


- (void)loadData{
    NSDictionary *dic = @{@"userid":UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:takeOutCashInfo withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        self.account_money = [infoDic objectForKey:@"account_money"]; // 账户余额
        self.member_cash = [infoDic objectForKey:@"member_cash"]; // 提现手续费 3表示3%
        self.min_money = [infoDic objectForKey:@"min_money"];
        self.aviliableLabel.text = [NSString stringWithFormat:@"可提现金额￥%@",self.account_money];
        self.explanLabel.text = [NSString stringWithFormat:@"说明：手续费为提现金额的%@%%",self.member_cash];
//        [self loadBankData];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
}

- (void)loadBankData{
    NSDictionary *dic = @{@"userid":UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:CashCardInfo withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        NSString *cardnum = [infoDic objectForKey:@"bank_num"];
        NSString *bankname = [infoDic objectForKey:@"bank_name"];
        self.bankView.bankCard = [NSString stringWithFormat:@"尾号%@储蓄卡",[cardnum substringFromIndex:cardnum.length - 4]];
        self.bankView.bankName = bankname;
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}

- (void)changeBankCard{
    AddBankCardVC *vc = [[AddBankCardVC alloc]init];
    PUSHVC(vc);
}

- (void)makeUI{
    [self.view addSubview:self.bankView];
    
    [self.view addSubview:self.aviliableLabel];
    
    UILabel *symbolLabel = [AppUIKit labelWithTitle:@"￥" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
    [self.view addSubview:symbolLabel];
    
    [self.view addSubview:self.inputMoneyTF];
    
    [self.view addSubview:self.takeAllButton];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = HEXACOLOR(0xdddddd);
    [self.view addSubview:lineV];
    
    [self.view addSubview:self.cashFeeLabel];
    
    [self.view addSubview:self.sureButton];
    
    _explanLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0xf68029) backgroundColor:nil alignment:0];
    [self.view addSubview:_explanLabel];
    
    
    self.aviliableLabel.sd_layout.topSpaceToView(self.bankView, 35).leftSpaceToView(self.view, 12).heightIs(12).rightSpaceToView(self.view, 12);
    
    symbolLabel.sd_layout.topSpaceToView(self.aviliableLabel, 37).leftEqualToView(self.aviliableLabel).heightIs(15).widthIs(12);
    
    self.inputMoneyTF.sd_layout.topSpaceToView(self.aviliableLabel, 30).leftSpaceToView(symbolLabel, 5).heightIs(22).rightSpaceToView(self.view, 75);
    
    self.takeAllButton.sd_layout.topSpaceToView(self.aviliableLabel, 37).widthIs(50).heightIs(15).rightSpaceToView(self.view, 12);
    lineV.sd_layout.topSpaceToView(self.inputMoneyTF, 14).leftSpaceToView(self.view, 12).heightIs(1).rightSpaceToView(self.view, 12);
    
    self.cashFeeLabel.sd_layout.topSpaceToView(lineV, 20).leftEqualToView(self.aviliableLabel).heightIs(12).rightEqualToView(self.aviliableLabel);
    
    self.sureButton.sd_layout.topSpaceToView(self.cashFeeLabel, 50).leftEqualToView(self.aviliableLabel).heightIs(44).rightEqualToView(self.aviliableLabel);
    
    _explanLabel.sd_layout.topSpaceToView(self.sureButton, 20).leftEqualToView(self.aviliableLabel).heightIs(12).rightEqualToView(self.aviliableLabel);
    
}












#pragma mark - 按钮点击

// 提现记录
- (void)takeOutRecord{
    [self.view endEditing:YES];
    CashRecordViewController *recordVC = [[CashRecordViewController alloc]init];
    [self.navigationController pushViewController:recordVC animated:YES];
}

// 确认提现
- (void)sureTakeOut{
    [self.view endEditing:YES];
    if ([self.account_money floatValue] <= 0) {
        [self showErrorText:@"余额不足"];
        return;
    }
    if ([self.inputMoneyTF.text floatValue] < [self.min_money floatValue]) {
        [self showErrorText:[NSString stringWithFormat:@"最少提现%@元",self.min_money]];
        return;
    }
    
    MJWeakSelf;
    
    NSDictionary *dic = @{@"userid":UserID,
                          @"money":self.inputMoneyTF.text,
                          @"type":@"T1"
                          };
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:takeOutCashApply withParaments:dic withSuccessBlock:^(id json) {
        self.title = @"提现结果";
        self.navigationItem.rightBarButtonItems  = @[];
        TakeCashResultView *resultV = [[TakeCashResultView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
        resultV.isSuccess = YES;
        resultV.ClickBlock = ^(blockType type) {
            weakSelf.title = @"提现";
            [weakSelf setNavRightBarItem];
            if (type == blockTypeReset) {
                
            }else if (type == blockTypeGoback){
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else if (type == blockTypeRecord){
                CashRecordViewController *recordVC = [[CashRecordViewController alloc]init];
                [weakSelf.navigationController pushViewController:recordVC animated:YES];
            }
        };
        [resultV showInView:self.view];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        self.title = @"提现结果";
        self.navigationItem.rightBarButtonItems  = @[];
        TakeCashResultView *resultV = [[TakeCashResultView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT)];
        resultV.isSuccess = NO;
        resultV.ClickBlock = ^(blockType type) {
            weakSelf.title = @"提现";
            [weakSelf setNavRightBarItem];
            if (type == blockTypeReset) {
                
            }else if (type == blockTypeGoback){
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }else if (type == blockTypeRecord){
                CashRecordViewController *recordVC = [[CashRecordViewController alloc]init];
                [weakSelf.navigationController pushViewController:recordVC animated:YES];
            }
        };
        [resultV showInView:self.view];
    }];
    
}

// 全部提现
- (void)takeOutAllMoney{
    self.inputMoneyTF.text = self.account_money;
    [self textFiledTextDidChanged];
}

#pragma mark - TF 变动通知
- (void)textFiledTextDidChanged{
    
    self.cashFeeLabel.text = [NSString stringWithFormat:@"手续费￥%.2f",[self.inputMoneyTF.text floatValue] * [self.member_cash floatValue] / 100];
}



#pragma mark - textFildDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    if ([self.inputMoneyTF.text floatValue] == 0) {
        self.inputMoneyTF.text = @"";
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    if ([self.inputMoneyTF.text floatValue] == 0) {
        self.inputMoneyTF.text = @"0.00";
    }
}






#pragma mark - LazyLoad

- (TakeOutCashBankView *)bankView{
    if (!_bankView) {
        _bankView = [[TakeOutCashBankView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, 88)];
        UITapGestureRecognizer *tapG = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(changeBankCard)];
        _bankView.userInteractionEnabled = YES;
        [_bankView addGestureRecognizer:tapG];
    }
    return _bankView;
}

- (UILabel *)aviliableLabel{
    if (!_aviliableLabel) {
        _aviliableLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:0];
    }
    return _aviliableLabel;
}

- (UITextField *)inputMoneyTF{
    if (!_inputMoneyTF) {
        _inputMoneyTF = [[UITextField alloc]init];
        _inputMoneyTF.font = kFont(30);
        _inputMoneyTF.textColor = defaultTextColor;
        _inputMoneyTF.keyboardType = UIKeyboardTypeNumberPad;
        _inputMoneyTF.clearButtonMode = UITextFieldViewModeWhileEditing;
        _inputMoneyTF.delegate = self;
        _inputMoneyTF.text = @"0.00";
//        NSAttributedString *attrStr = [[NSAttributedString alloc]initWithString:@"0.00" attributes:                                              @{NSForegroundColorAttributeName:defaultTextColor,                                                       NSFontAttributeName:[UIFont systemFontOfSize:30]}];
//        _inputMoneyTF.attributedPlaceholder = attrStr;
    }
    return _inputMoneyTF;
}

- (UIButton *)takeAllButton{
    if (!_takeAllButton) {
        _takeAllButton = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(takeOutAllMoney) target:self title:@"全部提现" image:nil font:12 textColor:HEXACOLOR(0x5cb7ff)];
    }
    return _takeAllButton;
}

- (UILabel *)cashFeeLabel{
    if (!_cashFeeLabel) {
        _cashFeeLabel = [AppUIKit labelWithTitle:@"手续费￥0.00" titleFontSize:12 textColor:HEXACOLOR(0xff5c5c) backgroundColor:nil alignment:0];
    }
    return _cashFeeLabel;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureTakeOut) target:self title:@"确认提现" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        _sureButton.layer.cornerRadius = 5;
    }
    return _sureButton;
}




@end
