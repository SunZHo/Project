//
//  ChangeOldPhoneVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/20.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChangeOldPhoneVC.h"

#import "ChangePhoneVC.h"

@interface ChangeOldPhoneVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView *tableFootView;

@property (nonatomic , copy) NSString *verifyCode;

@end

@implementation ChangeOldPhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更换手机号";
    self.view.backgroundColor = WhiteColor;
    [self loadFormData];
    
    [self makeUI];
    
    
}

- (void)makeUI{
    [self.view addSubview:self.table];
    
    
}

- (void)loadFormData{
    NSArray *titleArray = @[@"手机号",@"验证码"];
    
    NSArray *placeHoldArray = @[@"请输入手机号",@"请输入短信验证码"];
    
    NSArray *keyArray = @[@"1",@"2"];
    
    for (int i = 0; i < titleArray.count; i ++) {
        FormCellModel *model = [[FormCellModel alloc]init];
        model.title = titleArray[i];
        model.placeHolder = placeHoldArray[i];
        model.reqKey = keyArray[i];
        model.boardType = UIKeyboardTypeNumberPad;
        model.canEdit = YES;
        model.text = @"";
        if(i == 1){
            model.cellType = cellTypeTitle_FieldVeirfyCodeType;
        }else{
            model.text = [UserInfoDic objectForKey:@"phone"];
            model.canEdit = NO;
            model.cellType = cellTypeTitle_FieldType;
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
        [self getVeirfyCode];
    };
    
    [cell setFormcellModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}


- (void)notiTextField:(NSString *)text andIndex:(NSIndexPath *)indexPath{
    
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    model.text = text;
}


- (void)getVeirfyCode{
    FormCellModel *model1 = self.formData[0]; // 手机号
    [self showLoading];
    NSDictionary *dic = @{@"phone":model1.text};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_changePhoneOldSMS withParaments:dic withSuccessBlock:^(id json) {
        [self dismissLoading];
        NSDictionary *infoDic = [json objectForKey:@"info"];
        self.verifyCode = [NSString stringWithFormat:@"%ld",[[infoDic objectForKey:@"code"] integerValue]];
        [[NSNotificationCenter defaultCenter]postNotificationName:CountingDownNotiName object:nil];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}


- (void)nextStep{
    FormCellModel *model1 = self.formData[1]; // 手机号
    if (![self.verifyCode isEqualToString:model1.text]) {
        [self showErrorText:@"验证码不正确"];
        return;
    }
    ChangePhoneVC *changePhoneVC = [[ChangePhoneVC alloc]init];
    PUSHVC(changePhoneVC);
}


#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
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
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(nextStep) target:self title:@"下一步" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        sure.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).bottomEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}

@end
