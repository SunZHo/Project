//
//  ReplyPlanListVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ReplyPlanListVC.h"
#import "RepayPlanListModel.h"
#import "RepayPlanListCell.h"
#import "RepayPlanTotalView.h"

@interface ReplyPlanListVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@property (nonatomic , strong) UIView *tableFootView;

@end

@implementation ReplyPlanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"新增还款计划";
    self.view.backgroundColor = WhiteColor;
    
    for (int i = 0 ; i < 3; i ++) {
        RepayPlanListModel *model = [[RepayPlanListModel alloc]init];
        model.time = @"2018-02-10";
        model.plan = @"562.00";
        model.total = @"556.5";
        model.first = @"562.00";
        model.second = @"562.00";
        model.fee = @"562.00";
        [self.listData addObject:model];
    }
    
    [self.view addSubview:self.table];
}










#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"repayListcell";
    RepayPlanListModel *model = [self.listData objectAtIndex:indexPath.row];
    RepayPlanListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RepayPlanListCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    [cell setPlanModel:model];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
}




#pragma mark - 确认提交

- (void)sureCommit{
    RepayPlanTotalView *view = [[RepayPlanTotalView alloc]initWithFrame:self.view.frame];
    [view show];
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

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [[NSMutableArray alloc]init];
    }
    return _listData;
}

- (UIView *)tableFootView{
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 78)];
        _tableFootView.backgroundColor = Default_BackgroundGray;
        UIButton *sure = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(sureCommit) target:self title:@"确认提交" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
        sure.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:sure];
        
        sure.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).centerYEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}


@end
