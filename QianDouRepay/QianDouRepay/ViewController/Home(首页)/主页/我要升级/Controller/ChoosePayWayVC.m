//
//  ChoosePayWayVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/25.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChoosePayWayVC.h"
// view
#import "PayWayCell.h"

// model
#import "PayWayModel.h"
#import "QRCodeViewController.h"

@interface ChoosePayWayVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@property (nonatomic , strong) UIView *tableFootView;

@property (nonatomic , copy) NSString *payWay;

@end

@implementation ChoosePayWayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"选择支付方式";
    
    NSArray *nameA = @[@"微信支付",@"支付宝支付"];
    NSArray *iconName = @[@"wx",@"zfb"];
    for (int i = 0; i < nameA.count; i ++) {
        PayWayModel *model = [[PayWayModel alloc]init];
        model.name = nameA[i];
        model.imageName = iconName[i];
        if (i == 1) {
            model.isSelect = YES;
        }
        [self.listData addObject:model];
    }
    [self.view addSubview:self.table];
    self.payWay = @"支付宝";
    
}


- (void)sureCommit{
    QRCodeViewController *qrCodevc = [[QRCodeViewController alloc]init];
    qrCodevc.payWay = self.payWay;
    qrCodevc.money = self.payMoney;
    PUSHVC(qrCodevc);
}



#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"PayWayCell";
    PayWayModel *model = [self.listData objectAtIndex:indexPath.row];
    PayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[PayWayCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setPayModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    for (PayWayModel *paymodel in self.listData) {
        paymodel.isSelect = NO;
    }
    PayWayModel *model = [self.listData objectAtIndex:indexPath.row];
    model.isSelect = YES;
    if (indexPath.row == 0) {
        self.payWay = @"微信";
    }else{
        self.payWay = @"支付宝";
    }
    [self.table reloadData];
    
}



#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH,SCREEN_HEIGHT - 64 - SafeAreaTopHeight)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.tableFooterView = self.tableFootView;
        //        _table.backgroundColor = WhiteColor;
    }
    return _table;
}

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [[NSMutableArray alloc]init];
    }
    return _listData;
}

- (UIView *)tableFootView{
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 108)];
        _tableFootView.backgroundColor = Default_BackgroundGray;
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureCommit) target:self title:@"确定" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        sure.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).bottomEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}





@end
