//
//  CertifyNameVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "CertifyNameVC.h"
#import "UploadPicViewController.h"

@interface CertifyNameVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView *tableFootView;

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
    
    [cell setFormcellModel:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didse");
//    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    
    if (indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7) { // 信用卡有效期
//        calenderView *calenderV = [[calenderView alloc]initWithFrame:self.view.frame];
//        calenderV.isMutiChoose = NO;
//        calenderV.selectDateBlock = ^(NSString *date) {
//            model.text = date;
//            [self.table reloadData];
//        };
//        [calenderV show];
    }
    
}


- (void)notiTextField:(NSString *)text andIndex:(NSIndexPath *)indexPath{
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    model.text = text;
}



- (void)sureCommit{
    UploadPicViewController *uploadvc = [[UploadPicViewController alloc]init];
    PUSHVC(uploadvc);
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
