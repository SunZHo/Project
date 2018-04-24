//
//  FundsFlowDetailVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "FundsFlowDetailVC.h"

@interface FundsFlowDetailVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , copy) NSArray *titleArray;
@property (nonatomic , copy) NSArray *valueArray;

@property (nonatomic , strong) UIView *tableheadV;
@property (nonatomic , strong) UILabel *statusLabel;
@property (nonatomic , strong) UILabel *moneyLabel;

@property (nonatomic , strong) UIView *tablefootV;
@property (nonatomic , strong) UILabel *tradDescLabel;

@end

@implementation FundsFlowDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资金流水";
    [self loadData];
    [self makeUI];
    
    
}


- (void)loadData{
    NSString *money = @"2345.00";
    NSString *status = @"提现成功";
    NSString *tradDesc = @"提现成功，资金扣除";
    
    self.statusLabel.text = status;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",money];
    self.moneyLabel.attributedText = [AppCommon getRange:NSMakeRange(@"￥".length, money.length) labelStr:[NSString stringWithFormat:@"￥%@",money] Font:kFont(24) Color:defaultTextColor];
    self.tradDescLabel.text = tradDesc;
    
    self.titleArray = @[@"账户余额",@"冻结金额",@"交易时间"];
    self.valueArray = @[@"￥100.00",@"￥0.00",@"2018-02-09 14:32:21"];
    
    
}

- (void)makeUI{
    [self.view addSubview:self.table];
}



#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifiyImg = @"detailCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiyImg];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiyImg];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    UILabel *textLabel = [AppUIKit labelWithTitle:self.titleArray[indexPath.row] titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:0];
    UILabel *valueLabel = [AppUIKit labelWithTitle:self.valueArray[indexPath.row] titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:NSTextAlignmentRight];
    
    [cell.contentView addSubview:textLabel];
    [cell.contentView addSubview:valueLabel];
    textLabel.sd_layout.leftSpaceToView(cell.contentView, 12).widthIs(60).heightIs(16).centerYEqualToView(cell.contentView);
    valueLabel.sd_layout.rightSpaceToView(cell.contentView, 12).leftSpaceToView(textLabel, 10).heightIs(16).centerYEqualToView(cell.contentView);
    
    
    return cell;
    
}





#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.tableHeaderView = self.tableheadV;
        _table.tableFooterView = self.tablefootV;
    }
    return _table;
}


- (UIView *)tableheadV{
    if (!_tableheadV) {
        _tableheadV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 111)];
        _tableheadV.backgroundColor = WhiteColor;
        UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(12, 110, SCREEN_WIDTH - 24, 1)];
        linev.backgroundColor = HEXACOLOR(0xdddddd);
        [_tableheadV sd_addSubviews:@[self.statusLabel,self.moneyLabel,linev]];
        self.statusLabel.sd_layout.topSpaceToView(_tableheadV, 22).leftEqualToView(_tableheadV).rightEqualToView(_tableheadV).heightIs(15);
        self.moneyLabel.sd_layout.topSpaceToView(self.statusLabel, 20).leftEqualToView(_tableheadV).rightEqualToView(_tableheadV).heightIs(20);
        
        [AppCommon drawDashLine:linev lineLength:2 lineSpacing:1 lineColor:WhiteColor];
    }
    return _tableheadV;
}

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _statusLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _moneyLabel;
}

- (UIView *)tablefootV{
    if (!_tablefootV) {
        _tablefootV = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        _tablefootV.backgroundColor = WhiteColor;
        UIView *linev = [[UIView alloc]init];
        linev.backgroundColor = HEXACOLOR(0xdddddd);
        UILabel *leftLabel = [AppUIKit labelWithTitle:@"交易描述" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:0];
        [_tablefootV addSubview:linev];
        [_tablefootV addSubview:leftLabel];
        [_tablefootV addSubview:self.tradDescLabel];
        linev.sd_layout.topSpaceToView(_tablefootV, 1).leftSpaceToView(_tablefootV, 12).rightSpaceToView(_tablefootV, 12).heightIs(1);
        leftLabel.sd_layout.topSpaceToView(linev, 22).leftSpaceToView(_tablefootV, 12).widthIs(50).heightIs(12);
        self.tradDescLabel.sd_layout.topEqualToView(leftLabel).leftSpaceToView(leftLabel, 12).rightSpaceToView(_tablefootV, 12).heightIs(12);
    }
    return _tablefootV;
}

- (UILabel *)tradDescLabel{
    if (!_tradDescLabel) {
        _tradDescLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:NSTextAlignmentRight];
    }
    return _tradDescLabel;
}














@end
