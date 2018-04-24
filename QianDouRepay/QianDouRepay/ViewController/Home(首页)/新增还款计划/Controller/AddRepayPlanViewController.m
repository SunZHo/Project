//
//  AddRepayPlanViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/11.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AddRepayPlanViewController.h"
// view
#import "calenderView.h"

// controller
#import "ReplyPlanListVC.h"

@interface AddRepayPlanViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *formData;

@end

@implementation AddRepayPlanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增还款计划";
    self.view.backgroundColor = WhiteColor;
    [self loadFormData];
    
    [self makeUI];
    
    
    
}



- (void)makeUI{
    [self.view addSubview:self.table];
    UILabel *label = [AppUIKit labelWithTitle:@"温馨提示：信用卡可用余额应为还款金额的5%以上" titleFontSize:11 textColor:HEXACOLOR(0xf68029) backgroundColor:WhiteColor alignment:0];
    [self.view addSubview:label];
    
    UIButton *addBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(addClick) target:self title:@"添加计划至列表" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
    [self.view addSubview:addBtn];
    
    label.sd_layout.topSpaceToView(self.table, 16).leftSpaceToView(self.view, 12).rightEqualToView(self.view).heightIs(12);
    addBtn.sd_layout.topSpaceToView(label, 70).leftSpaceToView(self.view, 12).rightSpaceToView(self.view, 12).heightIs(44);
    addBtn.sd_cornerRadius = @(5);
    
    
}


- (void)loadFormData{
    NSArray *titleArray = @[@"还款日期",@"还款类别",@"还款总金额",@"拆分笔数"];
    NSArray *placeHoldArray = @[@"请选择还款日期",@"还款类别",@"分配后单笔金额最低为200元",@"请输入拆分笔数"];
    NSArray *keyArray = @[@"day",@"",@"",@""];
    
    for (int i = 0; i < titleArray.count; i ++) {
        FormCellModel *model = [[FormCellModel alloc]init];
        model.title = titleArray[i];
        model.placeHolder = placeHoldArray[i];
        model.reqKey = keyArray[i];
        model.boardType = UIKeyboardTypeDefault;
        if (i == 0) {
            model.cellType = cellTypeTitle_FieldSelection;
            model.canEdit = NO;
            model.text = @"";
        }else if (i == 1){
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = NO;
            model.text = @"还款";
            
        }else{
            model.cellType = cellTypeTitle_FieldType;
            model.canEdit = YES;
            model.boardType = UIKeyboardTypeNumberPad;
        }
        
        [self.formData addObject:model];
    }
}


- (void)addClick{
    ReplyPlanListVC *planVc = [[ReplyPlanListVC alloc]init];
    PUSHVC(planVc);
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
    static NSString *identifier1 = @"formCellrepay";
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
    if ([model.reqKey isEqualToString:@"day"]) {
        calenderView *calenderV = [[calenderView alloc]initWithFrame:self.view.frame];
        calenderV.isMutiChoose = YES;
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

#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, 200)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.scrollEnabled = NO;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    }
    return _table;
}

-(NSMutableArray *)formData{
    if (!_formData) {
        _formData = [[NSMutableArray alloc]init];
    }
    return _formData;
}

@end
