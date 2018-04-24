//
//  BillDetailViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BillDetailViewController.h"

@interface BillDetailViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@property (nonatomic , copy) NSArray *titleArr;

@property (nonatomic , copy) NSArray *valueArr;

@property (nonatomic , strong) UIView *tableHeadView;

@end

@implementation BillDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"账单详情";
    
    
    
    self.titleArr = @[@"交易类型",@"交易时间",@"订单号",@"卡号",@"流水号",@"手续费",@"处理说明"];
    
    self.valueArr = @[@"还款",@"2018-02-03 14:32",@"62145789321001",@"6240 **** **** **** 123",@"201802031432234500",@"￥0.00",@"已成功"];
    
    [self.view addSubview:self.table];
}




#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titleArr.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"BillCelldetail";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        cell.textLabel.text = self.titleArr[indexPath.row];
        cell.textLabel.font = [UIFont systemFontOfSize:12];
        cell.textLabel.textColor = defaultTextColor;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    for (UIView* anyView in cell.contentView.subviews) {
        [anyView removeFromSuperview];
    }
    UIView *line = [[UIView alloc]init];
    line.backgroundColor = HEXACOLOR(0xf8f8f7);
    [cell.contentView addSubview:line];
    line.sd_layout.leftSpaceToView(cell.contentView,15)
    .bottomSpaceToView(cell.contentView,0)
    .rightSpaceToView(cell.contentView,0)
    .heightIs(1);
    UILabel *goodAtlabel = [[UILabel alloc]init];
    goodAtlabel.text = self.valueArr[indexPath.row];
    goodAtlabel.textAlignment = NSTextAlignmentRight;
    goodAtlabel.textColor = HEXACOLOR(0x666666);
    goodAtlabel.font = [UIFont systemFontOfSize:12];
    [cell.contentView addSubview:goodAtlabel];
    
    goodAtlabel.sd_layout.leftSpaceToView(cell.contentView, 80).heightIs(15).centerYEqualToView(cell.contentView).rightSpaceToView(cell.contentView, 13);
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}




#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.tableHeaderView = self.tableHeadView;
    }
    return _table;
}

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [[NSMutableArray alloc]init];
    }
    return _listData;
}

- (UIView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 150)];
        _tableHeadView.backgroundColor = WhiteColor;
        UIImageView *img = [[UIImageView alloc]init];
        [_tableHeadView addSubview:img];
        
        NSString *money = @"500.00";
        NSString *moneyStr = [NSString stringWithFormat:@"￥%@",money];
        UILabel *moneyL = [AppUIKit labelWithTitle:moneyStr titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        
        moneyL.attributedText = [AppCommon getRange:NSMakeRange(@"￥".length, money.length) labelStr:moneyStr Font:kFont(30) Color:defaultTextColor];
        [_tableHeadView addSubview:moneyL];
        
        UILabel *statusL = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x999999) backgroundColor:nil alignment:NSTextAlignmentCenter];
        [_tableHeadView addSubview:statusL];
        
        img.sd_layout.topSpaceToView(_tableHeadView, 20).centerXEqualToView(_tableHeadView).widthIs(40).heightIs(40);
        
        moneyL.sd_layout.topSpaceToView(img, 13).centerXEqualToView(_tableHeadView).widthIs(SCREEN_WIDTH).heightIs(25);
        
        statusL.sd_layout.topSpaceToView(moneyL, 12).centerXEqualToView(_tableHeadView).widthIs(SCREEN_WIDTH).heightIs(12);
        
        if ([self.status integerValue] == 1) {
            img.image = IMG(@"jycg");
            statusL.text = @"交易成功";
        }else{
            img.image = IMG(@"jysb");
            statusL.text = @"交易未完成";
        }
        
        UIView *lineV = [[UIView alloc]init];
        lineV.backgroundColor = Default_BackgroundGray;
        [_tableHeadView addSubview:lineV];
        
        lineV.sd_layout.bottomEqualToView(_tableHeadView).heightIs(10).leftEqualToView(_tableHeadView).widthIs(SCREEN_WIDTH);
    }
    return _tableHeadView;
}


@end
