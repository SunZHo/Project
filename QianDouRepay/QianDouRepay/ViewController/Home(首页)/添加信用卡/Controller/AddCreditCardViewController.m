//
//  AddCreditCardViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AddCreditCardViewController.h"
#import "calenderView.h"

#define pickDateTag 100
#define pickValidityTag 101
#define pickBankTag 102

@interface AddCreditCardViewController ()<UITableViewDelegate,UITableViewDataSource,STPickerSingleDelegate>

@property (nonatomic , strong) BaseTableView  *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView         *tableFootView;

@property (nonatomic , strong) NSMutableArray *bankDataArr; // 银行数据
@property (nonatomic , assign) NSInteger      indexPathRow; // 选择第几行
@property (nonatomic , copy  ) NSString       *bankCode; // 银行联行号
@property (nonatomic , copy  ) NSString       *verifyCode; // 验证码

@end

@implementation AddCreditCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加信用卡";
    self.view.backgroundColor = WhiteColor;
    
    [self loadFormData];
    
    [self makeUI];
}

- (void)makeUI{
    [self.view addSubview:self.table];
    
    
}

- (void)loadFormData{
    NSArray *titleArray = @[@"真实姓名",@"身份证号",@"信用卡号",
                            @"开户行",
                            @"CVN2",
                            @"有效期",
                            @"账单日",
                            @"还款日",
                            @"手机号码",@"验证码"];
    
    NSArray *placeHoldArray = @[@"请输入真实姓名",@"请输入身份证号",@"请输入信用卡卡号",
                                @"请选择开户行",
                                @"请输入信用卡背面三位CVN2",
                                @"请选择信用卡有效期",
                                @"请选择账单日",
                                @"请选择还款日",
                                @"请输入银行预留手机号码",@"请输入短信验证码"];
    
    NSArray *keyArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    
    for (int i = 0; i < titleArray.count; i ++) {
        FormCellModel *model = [[FormCellModel alloc]init];
        model.title = titleArray[i];
        model.placeHolder = placeHoldArray[i];
        model.reqKey = keyArray[i];
        model.boardType = UIKeyboardTypeDefault;
        if (i == 3 || i == 5 || i == 6 || i == 7) {
            model.cellType = cellTypeTitle_FieldSelection;
            model.canEdit = NO;
            model.text = @"";
        }else if (i == 2 || i == 8){
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = YES;
            model.text = @"";
            model.boardType = UIKeyboardTypeNumberPad;
        }else if(i == 9){
            model.cellType = cellTypeTitle_FieldVeirfyCodeType;
            model.canEdit = YES;
            model.text = @"";
            model.boardType = UIKeyboardTypeNumberPad;
        }else if(i == 0){
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = NO;
            model.text = [UserInfoDic objectForKey:@"realname"];
        }else if(i == 1){
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = NO;
            model.text = [UserInfoDic objectForKey:@"idcard"];
        }else{
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = YES;
            model.text = @"";
            model.boardType = UIKeyboardTypeDefault;
        }
        
        [self.formData addObject:model];
    }
}


#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.formData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    static NSString *identifier1 = @"formCelladdCreditCard";
    FormCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier1];
    if (!cell) {
        cell = [[FormCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier1];
    }
    cell.cellTextFieldBlock = ^(NSString *text) {
        [self notiTextField:text andIndex:indexPath];
    };
    cell.getVerifyCodeBlock = ^{
        [self getVerifyCode];
    };
    
    [cell setFormcellModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didse");
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    _indexPathRow = indexPath.row;
    if (indexPath.row == 3) {
        [self showLoading];
        [self.bankDataArr removeAllObjects];
        [AppNetworking requestWithType:HttpRequestTypeGet withUrlString:getBankData withParaments:nil withSuccessBlock:^(id json) {
            [self dismissLoading];
            
            NSArray *info = [json objectForKey:@"info"];
            for (NSDictionary *dic in info) {
                BankInfoModel *model = [BankInfoModel mj_objectWithKeyValues:dic];
                [self.bankDataArr addObject:model];
            }
            NSMutableArray *bankA = [NSMutableArray array];
            for (BankInfoModel *model in self.bankDataArr) {
                [bankA addObject:model.name];
            }
            STPickerSingle *single = [[STPickerSingle alloc]init];
            [single setArrayData:bankA];
            [single setTitle:@""];
            single.tag = pickBankTag;
            [single setTitleUnit:@""];
            single.widthPickerComponent = 200;
            [single setDelegate:self];
            [single show];
        } withFailureBlock:^(NSString *errorMessage, int code) {
            
        }];
    }
    if (indexPath.row == 5 ) {// 信用卡有效期
        NSDate *minDate = [NSDate br_setYear:1990 month:3 day:12];
        NSDate *maxDate = [NSDate br_setYear:2990 month:3 day:12];
        [BRDatePickerView showDatePickerWithTitle:@"" dateType:BRDatePickerModeYM defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
            NSArray *arr = [selectValue componentsSeparatedByString:@"-"];
            model.text = [NSString stringWithFormat:@"%@%@",[arr[0] substringFromIndex:2],arr[1]];
            NSLog(@"%@",[NSString stringWithFormat:@"%@%@",[arr[0] substringFromIndex:2],arr[1]]);
            [self.table reloadData];
        } cancelBlock:^{
            NSLog(@"点击了背景或取消按钮");
        }];
    }
    
    if ( indexPath.row == 6 || indexPath.row == 7) {
        STPickerSingle *single = [[STPickerSingle alloc]init];
        [single setArrayData:[NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"]]];
        [single setTitle:@""];
        [single setTitleUnit:@""];
        single.tag = pickDateTag;
        single.widthPickerComponent = 200;
        [single setDelegate:self];
        [single show];
    }
    
    
}

#pragma mark - STPickerSingle 代理
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle{
    FormCellModel *model = [self.formData objectAtIndex:_indexPathRow];
    model.text = selectedTitle;
    [self.table reloadData];
    if (pickerSingle.tag == pickBankTag) {
        for (BankInfoModel *model in self.bankDataArr) {
            if ([model.name isEqualToString:selectedTitle]) {
                NSLog(@"code == %@",model.number);
                self.bankCode = model.number;
            }
        }
    }
    
}

- (void)notiTextField:(NSString *)text andIndex:(NSIndexPath *)indexPath{
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    model.text = text;
}



- (void)sureCommit{
    FormCellModel *model = self.formData[2]; // 信用卡号
    FormCellModel *model1 = self.formData[3]; // 开户行
    FormCellModel *model2 = self.formData[4]; // CVN2
    FormCellModel *model3 = self.formData[5]; // 有效期
    FormCellModel *model4 = self.formData[6]; // 账单日
    FormCellModel *model5 = self.formData[7]; // 还款日
    FormCellModel *model6 = self.formData[8]; // 手机号
    FormCellModel *model7 = self.formData[9]; // 验证码
    if ([model.text isEqualToString:@""]) {
        [self showErrorText:@"请输入信用卡号"];
        return;
    }
    if ([model1.text isEqualToString:@""]) {
        [self showErrorText:@"请选择开户行"];
        return;
    }
    if ([model2.text isEqualToString:@""]) {
        [self showErrorText:@"请输入CVN2"];
        return;
    }
    if ([model3.text isEqualToString:@""]) {
        [self showErrorText:@"请选择有效期"];
        return;
    }
    if ([model4.text isEqualToString:@""]) {
        [self showErrorText:@"请选择账单日"];
        return;
    }
    if ([model5.text isEqualToString:@""]) {
        [self showErrorText:@"请选择还款日"];
        return;
    }
    if ([model6.text isEqualToString:@""]) {
        [self showErrorText:@"请输入手机号"];
        return;
    }
    if ([model7.text isEqualToString:@""]) {
        [self showErrorText:@"请输入验证码"];
        return;
    }
    if (![model7.text isEqualToString:self.verifyCode]) {
        [self showErrorText:@"验证码不正确"];
        return;
    }
    NSDictionary *dic = @{@"userid":UserID,
                          @"bank_num":model.text,
                          @"bank_name":model1.text,
                          @"bank_number":self.bankCode,
                          @"cvn2":model2.text,
                          @"date":model3.text,
                          @"phone":model6.text,
                          @"statement":model4.text,
                          @"repayment":model5.text
                          };
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:creditcard_addCard withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"添加成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            POPVC;
        });
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}

- (void)getVerifyCode{
    FormCellModel *model6 = self.formData[8]; // 手机号
    if ([model6.text isEqualToString:@""]) {
        [self showErrorText:@"请输入手机号"];
        return;
    }
    NSDictionary *dic = @{@"phone":model6.text};
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:creditcard_addCardSMS withParaments:dic withSuccessBlock:^(id json) {
        [self dismissLoading];
        NSDictionary *infoDic = [json objectForKey:@"info"];
        self.verifyCode = [NSString stringWithFormat:@"%ld",[[infoDic objectForKey:@"code"] integerValue]];
        [[NSNotificationCenter defaultCenter]postNotificationName:CountingDownNotiName object:nil];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}


#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT - (64 + SafeAreaTopHeight))];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.tableFooterView = self.tableFootView;
    }
    return _table;
}

-(NSMutableArray *)formData{
    if (!_formData) {
        _formData = [[NSMutableArray alloc]init];
    }
    return _formData;
}

-(NSMutableArray *)bankDataArr{
    if (!_bankDataArr) {
        _bankDataArr = [[NSMutableArray alloc]init];
    }
    return _bankDataArr;
}



- (UIView *)tableFootView{
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 78)];
        _tableFootView.backgroundColor = Default_BackgroundGray;
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureCommit) target:self title:@"确定" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        sure.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).centerYEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}

@end
