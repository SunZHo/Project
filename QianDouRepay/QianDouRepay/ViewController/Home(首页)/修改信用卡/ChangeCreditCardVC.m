//
//  ChangeCreditCardVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/4.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChangeCreditCardVC.h"
#import "calenderView.h"

@interface ChangeCreditCardVC ()<UITableViewDelegate,UITableViewDataSource,STPickerSingleDelegate>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView *tableFootView;

@property (nonatomic , assign) NSInteger      indexPathRow; // 选择第几行

@end

@implementation ChangeCreditCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改信用卡";
    self.view.backgroundColor = WhiteColor;
    [self loadFormData];
    
    [self makeUI];
}

- (void)makeUI{
    [self.view addSubview:self.table];
    
    
}

- (void)loadFormData{
    NSArray *titleArray = @[@"信用卡号",
                            @"CVN2",
                            @"有效期",
                            @"账单日",
                            @"还款日"];
    
    NSArray *placeHoldArray = @[@"请输入信用卡卡号",
                                @"请输入信用卡背面三位CVN2",
                                @"请选择信用卡有效期",
                                @"请选择账单日",
                                @"请选择还款日"];
    
    NSArray *keyArray = @[@"1",@"2",@"3",@"4",@"5"];
    
    for (int i = 0; i < titleArray.count; i ++) {
        FormCellModel *model = [[FormCellModel alloc]init];
        model.title = titleArray[i];
        model.placeHolder = placeHoldArray[i];
        model.reqKey = keyArray[i];
        model.boardType = UIKeyboardTypeDefault;
        if (i == 2 || i == 3 || i == 4) {
            model.cellType = cellTypeTitle_FieldSelection;
            model.canEdit = NO;
            model.text = @"";
        }else if (i == 0){
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = NO;
            model.text = self.cardnum;
            model.boardType = UIKeyboardTypeNumberPad;
        }else if (i == 0){
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = NO;
            model.text = self.cardnum;
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
    _indexPathRow = indexPath.row;
    if (indexPath.row == 2 ) {// 信用卡有效期
        NSDate *minDate = [NSDate br_setYear:1990 month:3 day:12];
        NSDate *maxDate = [NSDate br_setYear:2990 month:3 day:12];
        [BRDatePickerView showDatePickerWithTitle:@"" dateType:BRDatePickerModeYM defaultSelValue:@"" minDate:minDate maxDate:maxDate isAutoSelect:YES themeColor:nil resultBlock:^(NSString *selectValue) {
            NSArray *arr = [selectValue componentsSeparatedByString:@"-"];
            model.text = [NSString stringWithFormat:@"%@%@",arr[1],[arr[0] substringFromIndex:2]];
            NSLog(@"%@",[NSString stringWithFormat:@"%@%@",arr[1],[arr[0] substringFromIndex:2]]);
            [self.table reloadData];
        } cancelBlock:^{
            NSLog(@"点击了背景或取消按钮");
        }];
        
    }
    if (indexPath.row == 3 || indexPath.row == 4) {
        STPickerSingle *single = [[STPickerSingle alloc]init];
        [single setArrayData:[NSMutableArray arrayWithArray:@[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11",@"12",@"13",@"14",@"15",@"16",@"17",@"18",@"19",@"20",@"21",@"22",@"23",@"24",@"25",@"26",@"27",@"28",@"29",@"30",@"31"]]];
        [single setTitle:@""];
        [single setTitleUnit:@""];
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
}

- (void)notiTextField:(NSString *)text andIndex:(NSIndexPath *)indexPath{
    FormCellModel *model = [self.formData objectAtIndex:indexPath.row];
    model.text = text;
}


- (void)sureCommit{
    FormCellModel *model1 = self.formData[1]; // CVN2
    FormCellModel *model2 = self.formData[2]; // 有效期
    FormCellModel *model3 = self.formData[3]; // 账单日
    FormCellModel *model4 = self.formData[4]; // 还款日
    if ([model1.text isEqualToString:@""]) {
        [self showErrorText:@"请输入CVN2"];
        return;
    }
    if ([model2.text isEqualToString:@""]) {
        [self showErrorText:@"请选择有效期"];
        return;
    }
    if ([model3.text isEqualToString:@""]) {
        [self showErrorText:@"请选择账单日"];
        return;
    }
    if ([model4.text isEqualToString:@""]) {
        [self showErrorText:@"请选择还款日"];
        return;
    }
    
    NSDictionary *dic = @{@"cardid":self.cardid,
                          @"userid":UserID,
                          @"cvn2":model1.text,
                          @"date":model2.text,
                          @"statement":model3.text,
                          @"repayment":model4.text
                          };
    [self showLoading];
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:creditcard_changeCard withParaments:dic withSuccessBlock:^(id json) {
        [self showSuccessText:@"修改成功"];
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
