//
//  AddCreditCardViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AddCreditCardViewController.h"
#import "calenderView.h"

@interface AddCreditCardViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView *tableFootView;

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
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    
    if (indexPath.row == 5 || indexPath.row == 6 || indexPath.row == 7) { // 信用卡有效期
        calenderView *calenderV = [[calenderView alloc]initWithFrame:self.view.frame];
        calenderV.isMutiChoose = NO;
        calenderV.selectDateBlock = ^(NSString *date) {
            model.text = date;
            [self.table reloadData];
        };
        [calenderV show];
    }
    
}


- (void)notiTextField:(NSString *)text andIndex:(NSIndexPath *)indexPath{
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    model.text = text;
}



- (void)sureCommit{
    
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
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureCommit) target:self title:@"确定" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        sure.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).centerYEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}

@end
