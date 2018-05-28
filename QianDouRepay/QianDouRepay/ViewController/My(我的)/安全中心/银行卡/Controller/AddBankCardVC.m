//
//  AddBankCardVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AddBankCardVC.h"

@interface AddBankCardVC ()<UITableViewDelegate,UITableViewDataSource,STPickerSingleDelegate>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView *tableFootView;

@property (nonatomic , strong) NSMutableArray *bankDataArr; // 银行数据
@property (nonatomic , assign) NSInteger      indexPathRow; // 选择第几行
@property (nonatomic , copy  ) NSString       *bankCode; // 银行联行号
@property (nonatomic , copy  ) NSString       *verifyCode; // 验证码

@end

@implementation AddBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"银行卡";
    self.view.backgroundColor = WhiteColor;
    [self loadFormData];
    
    [self makeUI];
}

- (void)makeUI{
    [self.view addSubview:self.table];
    
    
}

- (void)loadFormData{
    NSArray *titleArray = @[@"真实姓名",@"身份证号",@"银行卡卡号",
                            @"发卡银行",
                            @"预留手机号",
                            @"验证码"];
    
    NSArray *placeHoldArray = @[@"请输入真实姓名",@"请输入身份证号",@"请输入银行卡卡号",
                                @"请选择",
                                @"请输入银行预留手机号码",
                                @"请输入短信验证码"];
    
    NSArray *keyArray = @[@"1",@"2",@"3",@"4",@"5",@"6"];
    
    for (int i = 0; i < titleArray.count; i ++) {
        FormCellModel *model = [[FormCellModel alloc]init];
        model.title = titleArray[i];
        model.placeHolder = placeHoldArray[i];
        model.reqKey = keyArray[i];
        model.boardType = UIKeyboardTypeDefault;
        if (i == 0) {
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = NO;
            model.text = [UserInfoDic objectForKey:@"realname"];
        }else if (i == 1){
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = NO;
            model.text = [UserInfoDic objectForKey:@"idcard"];
        }else if(i == 3){
            model.cellType = cellTypeTitle_FieldSelection;
            model.canEdit = NO;
            model.text = @"";
        }else if(i == 5){
            model.cellType = cellTypeTitle_FieldVeirfyCodeType;
            model.canEdit = YES;
            model.text = @"";
            model.boardType = UIKeyboardTypeNumberPad;
        }else if (i == 2 || i == 4){
            model.cellType = cellTypeTitle_FieldType;
            model.boardType = UIKeyboardTypeNumberPad;
            model.canEdit = YES;
            model.text = @"";
        }else{
            model.cellType = cellTypeTitle_FieldType;
            model.boardType = UIKeyboardTypeDefault;
            model.canEdit = YES;
            model.text = @"";
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
            [single setTitleUnit:@""];
            single.widthPickerComponent = 200;
            [single setDelegate:self];
            [single show];
        } withFailureBlock:^(NSString *errorMessage, int code) {
            
        }];
    }
}


- (void)notiTextField:(NSString *)text andIndex:(NSIndexPath *)indexPath{
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    model.text = text;
}

#pragma mark - STPickerSingle 代理
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle{
    FormCellModel *model = [self.formData objectAtIndex:_indexPathRow];
    model.text = selectedTitle;
    [self.table reloadData];
    
    for (BankInfoModel *model in self.bankDataArr) {
        if ([model.name isEqualToString:selectedTitle]) {
            NSLog(@"code == %@",model.number);
            self.bankCode = model.number;
        }
    }
}

#pragma mark - 确定
- (void)sureCommit{
    FormCellModel *model2 = self.formData[2]; // 银行卡号
    FormCellModel *model3 = self.formData[3]; // 开户行
    FormCellModel *model4 = self.formData[4]; // 手机号
    FormCellModel *model5 = self.formData[5]; // 验证码
    if ([model2.text isEqualToString:@""]) {
        [self showErrorText:@"请输入银行卡号"];
        return;
    }
    if (![AppCommon isBankCard:model2.text]) {
        [self showErrorText:@"请输入正确的银行卡号"];
        return;
    }
    if ([model3.text isEqualToString:@""]) {
        [self showErrorText:@"请选择银行"];
        return;
    }
    if ([model4.text isEqualToString:@""]) {
        [self showErrorText:@"请输入手机号"];
        return;
    }
    if ([model5.text isEqualToString:@""]) {
        [self showErrorText:@"请输入验证码"];
        return;
    }
    if (![model5.text isEqualToString:self.verifyCode]) {
        [self showErrorText:@"验证码不正确"];
        return;
    }
    
    NSDictionary *dic = @{@"userid":UserID,
                          @"bank_num":model2.text,
                          @"bank_name":model3.text,
                          @"bank_number":self.bankCode,
                          @"phone":model4.text,
                          };
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:add_CashCard withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"绑定成功"];
        // 提现卡 1-已绑卡，0-未绑卡
        [UserInfoDic setObject:@"1" forKey:@"cash_bank"];
        [UserInfoCache archiveUserInfo:UserInfoDic keyedArchiveName:USER_INFO_CACHE];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            POPVC;
        });
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
}

- (void)getVerifyCode{
    
    FormCellModel *model6 = self.formData[4]; // 手机号
    if ([model6.text isEqualToString:@""]) {
        [self showErrorText:@"请输入手机号"];
        return;
    }
    [self showLoading];
    NSDictionary *dic = @{@"phone":model6.text};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:add_cashCardSMS withParaments:dic withSuccessBlock:^(id json) {
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


- (UIView *)tableFootView{
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        _tableFootView.backgroundColor = Default_BackgroundGray;
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureCommit) target:self title:@"确定" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        sure.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).bottomEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}


- (NSMutableArray *)bankDataArr{
    if (!_bankDataArr) {
        _bankDataArr = [NSMutableArray array];
    }
    return _bankDataArr;
}

@end
