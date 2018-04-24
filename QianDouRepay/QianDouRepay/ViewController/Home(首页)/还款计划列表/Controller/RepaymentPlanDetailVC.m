//
//  RepaymentPlanDetailVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "RepaymentPlanDetailVC.h"
// view
#import "RepayPlanDetailCell.h"

// model
#import "RepayPlanDetailModel.h"

@interface RepaymentPlanDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation RepaymentPlanDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"计划详情";
    NSArray *titleA = @[@"初次消费",@"二次消费",@"还款"];
    NSArray *subTitlearr = @[@"金额",@"单号",@"流水号",@"手续费",@"时间",@"说明"];
    NSArray *subValuearr = @[@"1230.00",@"1232312321312312",@"121312321222",@"￥1.86",@"2018-02-10",@"待处理"];
    for (int i = 0; i < titleA.count; i++) {
        RepayPlanDetailModel *model = [[RepayPlanDetailModel alloc]init];
        model.title = titleA[i];
        NSMutableArray *mutableA = [NSMutableArray array];
        for (int j = 0; j < subTitlearr.count; j ++) {
            RepayPlanDetailSubModel *subModel = [[RepayPlanDetailSubModel alloc]init];
            NSString *str = [NSString stringWithFormat:@"%@%@",titleA[i],subTitlearr[j]];
            subModel.subTitle = str;
            subModel.subValue = subValuearr[j];
            [mutableA addObject:subModel];
        }
        model.subArray = mutableA;
        model.isOpening = NO;
        [self.listData addObject:model];
    }
    
    [self.view addSubview:self.table];
    
    
}


#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"RepayPlanDetailCell";
    RepayPlanDetailModel *model = [self.listData objectAtIndex:indexPath.row];
    RepayPlanDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[RepayPlanDetailCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    cell.openClickedBlock = ^{
        model.isOpening = !model.isOpening;
//        [self.table reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.table reloadData];
    };
    [cell setRepayPlanModel:model];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        
    }
    
}

#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, SCREEN_HEIGHT -  64 - SafeAreaTopHeight)];
        _table.dataSource = self;
        _table.delegate = self;
    }
    return _table;
}

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [[NSMutableArray alloc]init];
    }
    return _listData;
}





@end
