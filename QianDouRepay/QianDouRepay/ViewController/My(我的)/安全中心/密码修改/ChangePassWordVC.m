//
//  ChangePassWordVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChangePassWordVC.h"

@interface ChangePassWordVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView *tableFootView;

@end

@implementation ChangePassWordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"密码修改";
    self.view.backgroundColor = WhiteColor;
    [self loadFormData];
    
    [self makeUI];
}

- (void)makeUI{
    [self.view addSubview:self.table];
    
    
}

- (void)loadFormData{
    NSArray *titleArray = @[@"原密码",@"新密码",@"确认密码"];
    
    NSArray *placeHoldArray = @[@"请输入原密码",@"请输入新密码",@"请再次输入新密码"];
    
    NSArray *keyArray = @[@"1",@"2",@"3"];
    
    for (int i = 0; i < titleArray.count; i ++) {
        FormCellModel *model = [[FormCellModel alloc]init];
        model.title = titleArray[i];
        model.placeHolder = placeHoldArray[i];
        model.reqKey = keyArray[i];
        model.boardType = UIKeyboardTypeNumberPad;
        model.canEdit = YES;
        model.text = @"";
        model.cellType = cellTypeTitle_FieldType;
        model.isSecureText = YES;
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
    FormCellModel *model = self.formData[0]; // 原密码
    FormCellModel *model1 = self.formData[1]; // 新密码
    FormCellModel *model2 = self.formData[2]; // 确认密码
    
    if ([model.text isEqualToString:@""]) {
        [self showErrorText:@"请输入原密码"];
        return;
    }
    if ([model1.text isEqualToString:@""]) {
        [self showErrorText:@"请输入新密码"];
        return;
    }
    if (![model1.text isEqualToString:model2.text]) {
        [self showErrorText:@"两次输入不一致"];
        return;
    }
    
    NSDictionary *dic = @{@"userid":UserID,
                          @"oldpass":model.text,
                          @"newpass":model1.text
                          };
    
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_changePwd withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"修改成功"];
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
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
