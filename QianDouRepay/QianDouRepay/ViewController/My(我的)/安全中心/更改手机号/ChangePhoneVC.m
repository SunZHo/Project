//
//  ChangePhoneVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChangePhoneVC.h"
#import "SafeCenterViewController.h"

@interface ChangePhoneVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView *tableFootView;
@property (nonatomic , copy) NSString *verifyCode;

@end

@implementation ChangePhoneVC

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
    NSArray *titleArray = @[@"新手机号",@"验证码"];
    
    NSArray *placeHoldArray = @[@"请输入新手机号",@"请输入短信验证码"];
    
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



- (void)sureCommit{
    FormCellModel *model0 = self.formData[0]; // 手机号
    FormCellModel *model1 = self.formData[1]; // 验证码
    
    if ([model0.text isEqualToString:@""]) {
        [self showErrorText:@"请输入手机号"];
        return;
    }
    if ([model1.text isEqualToString:@""]) {
        [self showErrorText:@"请输入验证码"];
        return;
    }
    if (![model1.text isEqualToString:self.verifyCode]) {
        [self showErrorText:@"验证码不正确"];
        return;
    }
    
    NSDictionary *dic = @{@"phone":model0.text,
                          @"userid":UserID
                          };
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_changePhoneUrl withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"修改成功"];
        [UserInfoDic setObject:model0.text forKey:@"phone"];
        [UserInfoCache archiveUserInfo:UserInfoDic keyedArchiveName:USER_INFO_CACHE];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            for (UIViewController *controller in self.navigationController.viewControllers) {
                if ([controller isKindOfClass:[SafeCenterViewController class]]) {
                    SafeCenterViewController *revise =(SafeCenterViewController *)controller;
                    [self.navigationController popToViewController:revise animated:YES];
                }
            }
        });
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
    
}


- (void)getVeirfyCode{
    FormCellModel *model1 = self.formData[0]; // 手机号
    [self showLoading];
    NSDictionary *dic = @{@"phone":model1.text};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_changePhoneNewSMS withParaments:dic withSuccessBlock:^(id json) {
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
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureCommit) target:self title:@"确定" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        sure.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).bottomEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}




@end
