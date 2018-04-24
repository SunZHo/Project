//
//  CashRecordViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "CashRecordViewController.h"
// view
#import "CashRecordCell.h"

// model
#import "CashRecordModel.h"

@interface CashRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation CashRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"提现记录";
    self.view.backgroundColor = WhiteColor;
    for (int i = 0; i < 10; i++) {
        CashRecordModel *model = [[CashRecordModel alloc]init];
        model.time = @"2018-01-12 14:30";
        if (i % 2 == 1) {
            model.money = @"￥100.00";
            model.type = @"提现成功";
            
        }else{
            model.money = @"￥100.00";
            model.type = @"提现失败";
        }
        [self.listData addObject:model];
    }
    
    [self.view addSubview:self.table];
    
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
        return 65;
    }else{
        return 180;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        static NSString *identifier = @"CashRecordCell";
        CashRecordModel *model = [self.listData objectAtIndex:indexPath.row];
        CashRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[CashRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setCashModel:model];
        
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






#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table                 = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _table.dataSource      = self;
        _table.delegate        = self;
        _table.separatorStyle  = UITableViewCellSeparatorStyleSingleLine;
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
