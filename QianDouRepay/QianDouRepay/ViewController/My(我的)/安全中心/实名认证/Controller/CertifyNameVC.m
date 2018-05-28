//
//  CertifyNameVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "CertifyNameVC.h"
#import "UploadPicViewController.h"
#import "PickAreaModel.h"
#import "SafeCenterViewController.h"
#import "HomeViewController.h"

#define provinceTag 100
#define cityTag     101
#define bankTag     102

@interface CertifyNameVC ()<UITableViewDelegate,UITableViewDataSource,STPickerSingleDelegate>

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

@implementation CertifyNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    
    self.view.backgroundColor = WhiteColor;
    [self loadFormData];
    
    [self makeUI];
}

- (void)makeUI{
    [self.view addSubview:self.table];
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
    if ([model.title isEqualToString:@"户籍所在省"]) {
        [self loadProvinceData];
    }
    if ([model.title isEqualToString:@"户籍所在市"]) {
        [self loadCityData];
    }
    if ([model.title isEqualToString:@"发卡银行"]) {
        
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


#pragma mark -  提交
- (void)sureCommit{
//    FormCellModel *model1 = self.formData[1]; // 账户
    FormCellModel *model2 = self.formData[2]; // 验证码
    FormCellModel *model3 = self.formData[3]; // 真实姓名
    FormCellModel *model4 = self.formData[4]; // 身份证号
    FormCellModel *model5 = self.formData[5]; // 省
    FormCellModel *model6 = self.formData[6]; // 市
    FormCellModel *model7 = self.formData[7]; // 身份证地址
    FormCellModel *model9 = self.formData[9]; // 信用卡号
    FormCellModel *model10 = self.formData[10]; // 发卡银行
    FormCellModel *model11 = self.formData[11]; // 预留手机号
    if ([model2.text isEqualToString:@""]) {
        [self showErrorText:@"请输入验证码"];
        return;
    }
    if (![model2.text isEqualToString:self.verifyCode]) {
        [self showErrorText:@"验证码不正确"];
        return;
    }
    if ([model3.text isEqualToString:@""]) {
        [self showErrorText:@"请输入真实姓名"];
        return;
    }
    if ([model4.text isEqualToString:@""]) {
        [self showErrorText:@"请输入身份证号"];
        return;
    }
    if ([model5.text isEqualToString:@""]) {
        [self showErrorText:@"请选择省份"];
        return;
    }
    if ([model6.text isEqualToString:@""]) {
        [self showErrorText:@"请选择市"];
        return;
    }
    if ([model7.text isEqualToString:@""]) {
        [self showErrorText:@"请输入身份证地址"];
        return;
    }
    if ([model9.text isEqualToString:@""]) {
        [self showErrorText:@"请输入信用卡号"];
        return;
    }
    if ([model10.text isEqualToString:@""]) {
        [self showErrorText:@"请选择发卡银行"];
        return;
    }
    if ([model11.text isEqualToString:@""]) {
        [self showErrorText:@"请输入预留手机号"];
        return;
    }
    
    NSDictionary *dic = @{@"userid":UserID,
                          @"realname":model3.text,
                          @"idcard":model4.text,
                          @"province":model5.text,
                          @"city":model6.text,
                          @"addr":model7.text,
                          @"bank_num":model9.text,
                          @"bank_name":model10.text,
                          @"bank_number":self.bankCode,
                          @"phone":model11.text
                          };
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_RealName withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"认证成功"];
        [UserInfoDic setObject:@"1" forKey:@"is_confirm"];
        [UserInfoCache archiveUserInfo:UserInfoDic keyedArchiveName:USER_INFO_CACHE];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[SafeCenterViewController class]]) {
                    SafeCenterViewController *revise =(SafeCenterViewController *)controller;
                    [self.navigationController popToViewController:revise animated:YES];
                }else if ([controller isKindOfClass:[HomeViewController class]]) {
                    HomeViewController *revise =(HomeViewController *)controller;
                    [self.navigationController popToViewController:revise animated:YES];
                }
            }
        });
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
}


- (void)getVerifyCode{
    FormCellModel *model1 = self.formData[1]; // 手机号
    [self showLoading];
    NSDictionary *dic = @{@"phone":model1.text};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_realNameSMS withParaments:dic withSuccessBlock:^(id json) {
        [self dismissLoading];
        NSDictionary *infoDic = [json objectForKey:@"info"];
        self.verifyCode = [NSString stringWithFormat:@"%ld",[[infoDic objectForKey:@"code"] integerValue]];
        [[NSNotificationCenter defaultCenter]postNotificationName:CountingDownNotiName object:nil];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}


#pragma mark -  loadData

- (void)loadFormData{
    NSArray *titleArray = @[@"个人信息",
                            @"账户",@"验证码",@"真实姓名",@"身份证号",
                            @"户籍所在省",
                            @"户籍所在市",
                            @"身份证地址",
                            @"信用卡信息",
                            @"信用卡号",
                            @"发卡银行",
                            @"预留手机号"];
    
    NSArray *placeHoldArray = @[@"",
                                @"请输入账户名称",@"请输入短信验证码",@"请输入真实姓名",@"请输入您的身份证号，“X”请大写",
                                @"请选择户籍所在省",
                                @"请选择户籍所在市",
                                @"请输入您的身份证地址",
                                @"",
                                @"请输入信用卡号",
                                @"请选择发卡银行",
                                @"请输入银行预留手机号"];
    
    NSArray *keyArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12"];
    
    for (int i = 0; i < titleArray.count; i ++) {
        FormCellModel *model = [[FormCellModel alloc]init];
        model.title = titleArray[i];
        model.placeHolder = placeHoldArray[i];
        model.reqKey = keyArray[i];
        model.boardType = UIKeyboardTypeDefault;
        if (i == 0 || i == 8) {
            model.canEdit = NO;
            model.cellType = cellTypeSectionHeaderType;
        }else if(i == 2){
            model.cellType = cellTypeTitle_FieldVeirfyCodeType;
            model.canEdit = YES;
            model.text = @"";
            model.boardType = UIKeyboardTypeNumberPad;
        }else if ( i == 5 || i == 6 || i == 10) {
            model.cellType = cellTypeTitle_FieldSelection;
            model.canEdit = NO;
            model.text = @"";
        }else if ( i == 11) {
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = YES;
            model.text = @"";
            model.boardType = UIKeyboardTypeNumberPad;
        }else if(i == 1){
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = YES;
            model.text = [UserInfoDic objectForKey:@"phone"];
            model.boardType = UIKeyboardTypeNumberPad;
        }else{
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = YES;
            model.text = @"";
            model.boardType = UIKeyboardTypeDefault;
        }
        [self.formData addObject:model];
    }
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
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 78)];
        _tableFootView.backgroundColor = Default_BackgroundGray;
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureCommit) target:self title:@"提交" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        sure.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).centerYEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}

@end
