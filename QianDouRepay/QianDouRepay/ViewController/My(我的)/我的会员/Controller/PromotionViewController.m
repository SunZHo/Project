//
//  PromotionViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "PromotionViewController.h"
// view
#import "PromotionCell.h"

// model
#import "PromotionModel.h"

@interface PromotionViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation PromotionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.navTitle;
    
    
    for (int i = 0; i < 10; i++) {
        PromotionModel *model = [[PromotionModel alloc]init];
        model.time = @"2018-01-12 14:30";
        model.name = @"王晓晓";
        model.phone = @"188****2211";
        if (i % 2 == 1) {
            model.isRealName = @"1";
            model.vipType = @"VIP会员";
        }else{
            model.isRealName = @"0";
            model.vipType = @"普通会员";
        }
        
        [self.listData addObject:model];
    }
    
    [self.view addSubview:self.table];
}



#pragma mark - table
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.listData.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PromotionModel *model = [self.listData objectAtIndex:indexPath.row];
    static NSString *identifiyImg = @"PromotionCell";
    PromotionCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiyImg];
    if (!cell) {
        cell = [[PromotionCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiyImg];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    [cell setPromotionModel:model];
    return cell;
    
}


#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
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
