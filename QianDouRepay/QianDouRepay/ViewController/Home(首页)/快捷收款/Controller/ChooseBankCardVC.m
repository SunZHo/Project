//
//  ChooseBankCardVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChooseBankCardVC.h"
#import "ChooseCreditCardVC.h"

@interface ChooseBankCardVC ()<UITableViewDelegate,UITableViewDataSource,STPickerSingleDelegate>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@property (nonatomic , strong) UIView *tableFootView;

@property (nonatomic , assign) NSInteger indexPathRow ;

@end

@implementation ChooseBankCardVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择银行卡";
    
    [self loadFormData];
    
    [self makeUI];
    
    
}

- (void)makeUI{
    [self.view addSubview:self.table];
    
    
}

- (void)loadFormData{
    NSArray *titleArray = @[@"真实姓名",@"身份证号",@"储蓄卡号",
                            @"开户行",
                            @"手机号"];
    
    NSArray *placeHoldArray = @[@"请输入真实姓名",@"请输入身份证号",@"请输入储蓄卡卡号",
                                @"请选择开户行",
                                @"请输入银行预留手机号码"];
    
    NSArray *keyArray = @[@"1",@"2",@"3",@"4",@"5"];
    
    for (int i = 0; i < titleArray.count; i ++) {
        FormCellModel *model = [[FormCellModel alloc]init];
        model.title = titleArray[i];
        model.placeHolder = placeHoldArray[i];
        model.reqKey = keyArray[i];
        model.boardType = UIKeyboardTypeDefault;
        model.cellType = cellTypeTitle_FieldType;
        model.canEdit = YES;
        model.text = @"";
        if (i == 3) {
            model.cellType = cellTypeTitle_FieldSelection;
            model.canEdit = NO;
            model.text = @"";
        }else if (i == 2 || i == 4){
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
    
    [cell setFormcellModel:model];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"didse");
    
    _indexPathRow = indexPath.row;
    if (indexPath.row == 3) { // 选择银行
        STPickerSingle *single = [[STPickerSingle alloc]init];
        [single setArrayData:[NSMutableArray arrayWithArray:@[@"中国银行",@"工商银行",@"农业银行",@"建设银行",@"民生银行"]]];
        [single setTitle:@""];
        [single setTitleUnit:@""];
        single.widthPickerComponent = 100;
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


#pragma mark - 确定
- (void)sureCommit{
    ChooseCreditCardVC *creditVc = [[ChooseCreditCardVC alloc]init];
    PUSHVC(creditVc);
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
