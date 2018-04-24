//
//  RepaymentPlanListVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "RepaymentPlanListVC.h"
#import "RepaymentPlanCell.h"
#import "RepaymentPlanModel.h"
#import "RepaymentPlanDetailVC.h"

@interface RepaymentPlanListVC ()<UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation RepaymentPlanListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"还款计划列表";
    self.view.backgroundColor = WhiteColor;
    [self setNavRightBarItem];
    for (int i = 0; i < 10; i++) {
        RepaymentPlanModel *model = [[RepaymentPlanModel alloc]init];
        model.time = @"2018-02-14";
        model.type = @"还款";
        model.money = @"￥556.7";
        [self.listData addObject:model];
    }
    
    [self.view addSubview:self.table];
}



- (void)setNavRightBarItem{
    UIButton *billCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billCardBtn addTarget:self action:@selector(planUnFrozen) forControlEvents:UIControlEventTouchUpInside];
    [billCardBtn setTitle:@"计划解冻" forState:UIControlStateNormal];
    billCardBtn.titleLabel.font = kFont(15);
    [billCardBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
    [billCardBtn sizeToFit];
    UIBarButtonItem *billItem = [[UIBarButtonItem alloc] initWithCustomView:billCardBtn];
    self.navigationItem.rightBarButtonItems  = @[billItem];
}

- (void)planUnFrozen{
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定要计划解冻吗？" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.listData.count > 0) {
        return self.listData.count;
    }else{
        return 1;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        return 50;
    }else{
        return 180;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        static NSString *identifier = @"RepaymentPlanCell";
        RepaymentPlanModel *model = [self.listData objectAtIndex:indexPath.row];
        RepaymentPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[RepaymentPlanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setRepaymentModel:model];
        
        return cell;
    }else{
        static NSString *identifiyImg = @"NoreplyCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiyImg];
        if (!cell) {
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiyImg];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.separatorInset = UIEdgeInsetsMake(0, SCREEN_WIDTH, 0, 0);
        }
        UIImageView *img = [[UIImageView alloc]init];
        img.image = [UIImage imageNamed:@"zwsj"];
        [cell.contentView addSubview:img];
        img.sd_layout.topSpaceToView(cell.contentView, 35).widthIs(103).heightIs(103).centerXEqualToView(cell.contentView);
        
        UILabel *textLabel = [[UILabel alloc]init];
        textLabel.font = kFont(15);
        textLabel.textColor = defaultTextColor;
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.text = @"暂无数据";
        [cell.contentView addSubview:textLabel];
        textLabel.sd_layout.topSpaceToView(img, 15).widthIs(100).heightIs(16).centerXEqualToView(cell.contentView);
        
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        RepaymentPlanDetailVC *detailVc = [[RepaymentPlanDetailVC alloc]init];
        PUSHVC(detailVc);
    }
    
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        NSLog(@"确定");
    }
}

#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.backgroundColor = WhiteColor;
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
