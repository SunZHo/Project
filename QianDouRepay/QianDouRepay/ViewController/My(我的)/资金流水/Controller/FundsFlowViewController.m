//
//  FundsFlowViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "FundsFlowViewController.h"
// view
#import "FundsFilterView.h"
#import "FundsFlowCell.h"

// model
#import "FundsFlowModel.h"

// controller
#import "FundsFlowDetailVC.h"

@interface FundsFlowViewController ()<UITableViewDelegate,UITableViewDataSource>{
    UIButton *filterBtn;
}
@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@property (nonatomic , strong) UIView *rightBarCustomView;

@end

@implementation FundsFlowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"资金流水";
    self.view.backgroundColor = WhiteColor;
    UIBarButtonItem *billItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarCustomView];
    self.navigationItem.rightBarButtonItems  = @[billItem];
    for (int i = 0; i < 10; i++) {
        FundsFlowModel *model = [[FundsFlowModel alloc]init];
        model.time = @"2018-01-12 14:30";
        if (i % 2 == 1) {
            model.money = @"-200.00";
            model.type = @"提现成功";
            
        }else{
            model.money = @"+20.00";
            model.type = @"收款分润";
            
        }
        [self.listData addObject:model];
    }
    
    [self.view addSubview:self.table];
}




- (void)filterClick:(UIButton *)optionButton{
    //    [optionButton setTitle:content forState:UIControlStateNormal];
    filterBtn.userInteractionEnabled = NO;
    FundsFilterView *filerView = [[FundsFilterView alloc]init];
    filerView.filterBlock = ^{
        filterBtn.userInteractionEnabled = YES;
    };
    [filerView showInView:self.view];
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
        return 60;
    }else{
        return 180;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        static NSString *identifier = @"FundsFlowCell";
        FundsFlowModel *model = [self.listData objectAtIndex:indexPath.row];
        FundsFlowCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[FundsFlowCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setFundsModel:model];
        
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
    //    if (self.listData.count > 0) {
    //        BillModel *model = [self.listData objectAtIndex:indexPath.row];
    //        BillDetailViewController *detailVC = [[BillDetailViewController alloc]init];
    //        detailVC.status = model.status;
    //        PUSHVC(detailVC);
    //    }
    
    FundsFlowDetailVC *detailVC = [[FundsFlowDetailVC alloc]init];
    PUSHVC(detailVC);
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


- (UIView *)rightBarCustomView{
    if (!_rightBarCustomView) {
        _rightBarCustomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
        filterBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [filterBtn addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
        [filterBtn setTitle:@"全部" forState:UIControlStateNormal];
        filterBtn.titleLabel.font = kFont(15);
        [filterBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
        filterBtn.frame = CGRectMake(0, 0, 35, 20);
        [_rightBarCustomView addSubview:filterBtn];
        
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(40, 8, 6, 4)];
        iv.image = IMG(@"sjxx");
        [_rightBarCustomView addSubview:iv];
        
    }
    return _rightBarCustomView;
}

@end
