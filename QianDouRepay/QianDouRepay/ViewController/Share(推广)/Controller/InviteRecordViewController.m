//
//  InviteRecordViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "InviteRecordViewController.h"

// model
#import "InviteRecordModel.h"

// view
#import "InviteRecordCell.h"

@interface InviteRecordViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@property (nonatomic , strong) UIView *tableheadView;

@property (nonatomic , assign) NSInteger page ;
@property (nonatomic , assign) NSInteger totalpage ;

@end

@implementation InviteRecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"邀请记录";
    [self.view addSubview:self.table];
    [self loadData];
}


- (void)loadData{
    [self.listData removeAllObjects];
    self.page = 1;
    NSDictionary *dic = @{@"userid":UserID,
                          @"page":[NSString stringWithFormat:@"%ld",self.page]
                          };
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:shareRecordUrl withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        self.totalpage = [[infoDic objectForKey:@"all_page"] integerValue];
        NSArray *arr = [infoDic objectForKey:@"list"];
        for (NSDictionary *infodic in arr) {
            InviteRecordModel *model = [InviteRecordModel mj_objectWithKeyValues:infodic];
            [self.listData addObject:model];
        }
        [self.table reloadData];
        [self.table endRefresh];
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        [self.table endRefresh];
    }];
}


- (void)loadMoreData{
    self.page ++;
    if (self.page >= self.totalpage) {
        [self.table.mj_footer endRefreshingWithNoMoreData];
        return;
    }
    NSDictionary *dic = @{@"userid":UserID,
                          @"page":[NSString stringWithFormat:@"%ld",self.page]
                          };
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:shareRecordUrl withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
        NSArray *arr = [infoDic objectForKey:@"list"];
        for (NSDictionary *infodic in arr) {
            InviteRecordModel *model = [InviteRecordModel mj_objectWithKeyValues:infodic];
            [self.listData addObject:model];
        }
        [self.table reloadData];
        [self.table endRefresh];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        [self.table endRefresh];
    }];
    
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
        static NSString *identifier = @"InviteRecordCell";
        InviteRecordModel *model = [self.listData objectAtIndex:indexPath.row];
        InviteRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[InviteRecordCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setInviteModel:model];
        
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (self.listData.count > 0) {
        return self.tableheadView;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (self.listData.count > 0) {
        return 44;
    }
    return 0.000001;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.00001;
}

#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _table.dataSource = self;
        _table.delegate = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.backgroundColor = WhiteColor;
        __weak typeof(&*self)weakSelf = self;
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadData];
        }];
        
        _table.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
            [weakSelf loadMoreData];
        }];
    }
    return _table;
}

-(NSMutableArray *)listData{
    if (!_listData) {
        _listData = [[NSMutableArray alloc]init];
    }
    return _listData;
}


- (UIView *)tableheadView{
    if (!_tableheadView) {
        _tableheadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 44)];
        _tableheadView.backgroundColor = Default_BackgroundGray;
        NSArray *arr = @[@"手机号",@"认证状态",@"注册时间"];
        for (int i = 0; i < arr.count; i++) {
            UILabel *label = [AppUIKit labelWithTitle:arr[i] titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
            [_tableheadView addSubview:label];
            
            label.sd_layout.topEqualToView(_tableheadView).leftSpaceToView(_tableheadView, i * SCREEN_WIDTH / 3).widthIs(SCREEN_WIDTH / 3).heightIs(44);
        }
        
    }
    return _tableheadView;
}



@end
