//
//  AddReceiptBankCardVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/8.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AddReceiptBankCardVC.h"
#import "PickAreaModel.h"

#define provinceTag 1000
#define cityTag     1001
#define bankTag     1002

@interface AddReceiptBankCardVC ()<UITableViewDelegate,UITableViewDataSource,STPickerSingleDelegate>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView *tableFootView;

@property (nonatomic , copy) NSString *provinceID; // 省份id
@property (nonatomic , copy) NSString *cityID; // 城市id
@property (nonatomic , strong) NSMutableArray *provinceDataArr; // 省数据
@property (nonatomic , strong) NSMutableArray *cityDataArr; // 城市数据

@property (nonatomic , strong) NSMutableArray *bankDataArr; // 银行数据
@property (nonatomic , assign) NSInteger      indexPathRow; // 选择第几行
@property (nonatomic , copy  ) NSString       *bankCode; // 银行联行号
@property (nonatomic , copy  ) NSString       *verifyCode; // 验证码

@end

@implementation AddReceiptBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"添加收款储蓄卡";
    
    [self loadFormData];
    
    [self makeUI];
}

- (void)makeUI{
    [self.view addSubview:self.table];
    
    
}

- (void)loadFormData{
    NSArray *titleArray = @[@"真实姓名",@"身份证号",@"储蓄卡号",
                            @"开户行",
                            @"开户行省份",
                            @"开户行城市",
                            @"开户行地址",
                            @"手机号",
                            @"验证码"];
    
    NSArray *placeHoldArray = @[@"请输入真实姓名",@"请输入身份证号",@"请输入储蓄卡卡号",
                                @"请选择开户行",
                                @"请选择开户行省份",
                                @"请选择开户行城市",
                                @"请输入开户行地址",
                                @"请输入银行预留手机号码",
                                @"请输入验证码"];
    
    //    NSArray *keyArray = @[@"1",@"2",@"3",@"4",@"5"];
    
    for (int i = 0; i < titleArray.count; i ++) {
        FormCellModel *model = [[FormCellModel alloc]init];
        model.title = titleArray[i];
        model.placeHolder = placeHoldArray[i];
        //        model.reqKey = keyArray[i];
        model.boardType = UIKeyboardTypeDefault;
        model.cellType = cellTypeTitle_FieldType;
        model.canEdit = YES;
        model.text = @"";
        if (i == 0) {
            model.text = [UserInfoDic objectForKey:@"realname"];
        }else if (i == 1){
            model.text = [UserInfoDic objectForKey:@"idcard"];
        }else if (i == 3 || i == 4 || i == 5) {
            model.cellType = cellTypeTitle_FieldSelection;
            model.canEdit = NO;
            model.text = @"";
        }else if (i == 2 || i == 7 ){
            model.boardType = UIKeyboardTypeNumberPad;
        }else if (i == 8){
            model.cellType = cellTypeTitle_FieldVeirfyCodeType;
            model.boardType = UIKeyboardTypeNumberPad;
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
    if ([model.title isEqualToString:@"开户行省份"]) {
        [self loadProvinceData];
    }
    if ([model.title isEqualToString:@"开户行城市"]) {
        if ([self.provinceID isEqualToString:@""] || self.provinceID == nil) {
            [self showErrorText:@"请先选择省份"];
        }else{
            [self loadCityData];
        }
        
    }
    if ([model.title isEqualToString:@"开户行"]) {
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
            single.tag = bankTag;
            [single setTitleUnit:@""];
            single.widthPickerComponent = 200;
            [single setDelegate:self];
            [single show];
        } withFailureBlock:^(NSString *errorMessage, int code) {
            
        }];
        
    }
    
}

#pragma mark - STPickerSingle 代理
- (void)pickerSingle:(STPickerSingle *)pickerSingle selectedTitle:(NSString *)selectedTitle{
    FormCellModel *model = [self.formData objectAtIndex:_indexPathRow];
    model.text = selectedTitle;
    [self.table reloadData];
    
    if (pickerSingle.tag == provinceTag) {
        for (PickAreaModel *model in self.provinceDataArr) {
            if ([model.name isEqualToString:selectedTitle]) {
                NSLog(@"code == %@",model.ID);
                self.provinceID = model.ID;
            }
        }
    }else if (pickerSingle.tag == cityTag){
        for (PickAreaModel *model in self.cityDataArr) {
            if ([model.name isEqualToString:selectedTitle]) {
                NSLog(@"code == %@",model.ID);
                self.cityID = model.ID;
            }
        }
    }else if (pickerSingle.tag == bankTag){
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

- (void)getVerifyCode{
    FormCellModel *model1 = self.formData[7]; // 手机号
    [self showLoading];
    NSDictionary *dic = @{@"phone":model1.text};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:receipt_BankSMS withParaments:dic withSuccessBlock:^(id json) {
        [self dismissLoading];
        NSDictionary *infoDic = [json objectForKey:@"info"];
        self.verifyCode = [NSString stringWithFormat:@"%ld",[[infoDic objectForKey:@"code"] integerValue]];
        [[NSNotificationCenter defaultCenter]postNotificationName:CountingDownNotiName object:nil];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}


- (void)loadProvinceData{
    [self.provinceDataArr removeAllObjects];
    NSDictionary *dic = @{@"pid" : @""};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_getAreaData withParaments:dic withSuccessBlock:^(id json) {
        NSArray *info = [json objectForKey:@"info"];
        for (NSDictionary *dic in info) {
            PickAreaModel *model = [PickAreaModel mj_objectWithKeyValues:dic];
            [self.provinceDataArr addObject:model];
        }
        NSMutableArray *provinceA = [NSMutableArray array];
        for (PickAreaModel *model in self.provinceDataArr) {
            [provinceA addObject:model.name];
        }
        STPickerSingle *single = [[STPickerSingle alloc]init];
        [single setArrayData:provinceA];
        [single setTitle:@""];
        [single setTitleUnit:@""];
        single.tag = provinceTag;
        single.widthPickerComponent = 200;
        [single setDelegate:self];
        [single show];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}

- (void)loadCityData{
    [self.cityDataArr removeAllObjects];
    NSDictionary *dic = @{@"pid" : self.provinceID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_getAreaData withParaments:dic withSuccessBlock:^(id json) {
        NSArray *info = [json objectForKey:@"info"];
        for (NSDictionary *dic in info) {
            PickAreaModel *model = [PickAreaModel mj_objectWithKeyValues:dic];
            [self.cityDataArr addObject:model];
        }
        NSMutableArray *provinceA = [NSMutableArray array];
        for (PickAreaModel *model in self.cityDataArr) {
            [provinceA addObject:model.name];
        }
        STPickerSingle *single = [[STPickerSingle alloc]init];
        [single setArrayData:provinceA];
        [single setTitle:@""];
        [single setTitleUnit:@""];
        single.tag = cityTag;
        single.widthPickerComponent = 200;
        [single setDelegate:self];
        [single show];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}


#pragma mark - 确定
- (void)sureCommit{
    FormCellModel *model2 = self.formData[2]; // 储蓄卡号
    FormCellModel *model3 = self.formData[3]; // 开户行
    FormCellModel *model4 = self.formData[4]; // 开户行省份
    FormCellModel *model5 = self.formData[5]; // 市
    FormCellModel *model6 = self.formData[6]; // 地址
    FormCellModel *model7 = self.formData[7]; // 预留手机号
    FormCellModel *model8 = self.formData[8]; // 验证码
    if ([model2.text isEqualToString:@""]) {
        [self showErrorText:@"请输入卡号"];
        return;
    }
    if ([model3.text isEqualToString:@""]) {
        [self showErrorText:@"请选择开户行"];
        return;
    }
    if ([model4.text isEqualToString:@""]) {
        [self showErrorText:@"请选择省份"];
        return;
    }
    if ([model5.text isEqualToString:@""]) {
        [self showErrorText:@"请选择市"];
        return;
    }
    if ([model6.text isEqualToString:@""]) {
        [self showErrorText:@"请输入开户行地址"];
        return;
    }
    if ([model7.text isEqualToString:@""]) {
        [self showErrorText:@"请输入预留手机号"];
        return;
    }
    if ([model8.text isEqualToString:@""]) {
        [self showErrorText:@"请输入验证码"];
        return;
    }
    if (![model8.text isEqualToString:self.verifyCode]) {
        [self showErrorText:@"验证码不正确"];
        return;
    }
    NSDictionary *dic = @{@"userid":UserID,
                          @"bank_num":model2.text,
                          @"bank_name":model3.text,
                          @"bank_number":self.bankCode,
                          @"phone":model7.text,
                          @"province":model4.text,
                          @"city":model5.text,
                          @"address":model6.text
                          };
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:receipt_AddBankCard withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"添加成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            POPVC;
        });
        
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

-(NSMutableArray *)provinceDataArr{
    if (!_provinceDataArr) {
        _provinceDataArr = [[NSMutableArray alloc]init];
    }
    return _provinceDataArr;
}

-(NSMutableArray *)cityDataArr{
    if (!_cityDataArr) {
        _cityDataArr = [[NSMutableArray alloc]init];
    }
    return _cityDataArr;
}

- (UIView *)tableFootView{
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _tableFootView.backgroundColor = Default_BackgroundGray;
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureCommit) target:self title:@"确定" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        sure.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).centerYEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}

@end
