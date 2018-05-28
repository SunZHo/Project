//
//  MyFeeRateSubVC.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MyFeeRateSubVC.h"

// view
#import "RepayFeeCell.h"
#import "ReciveFeeCell.h"

// model
#import "MyFeeRateModel.h"



@interface MyFeeRateSubVC ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation MyFeeRateSubVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navlineV.alpha = 0;
    
    [self.view addSubview:self.table];
    [self loadData];
}



- (void)loadData{
    [self.listData removeAllObjects];
    NSDictionary *dic = @{@"userid":UserID};
    NSString *url = @"";
    if ([self.title isEqualToString:@"收款费率"]) {
        url = home_MyFeeReceive;
        [AppNetworking requestWithType:HttpRequestTypePost withUrlString:url withParaments:dic withSuccessBlock:^(id json) {
            NSDictionary *dic = [json objectForKey:@"info"];
            NSArray *arr = [dic objectForKey:@"list"];
            for (NSDictionary *lDic in arr) {
                MyFeeRateReceiveModel *model = [MyFeeRateReceiveModel model];
                [model setValuesForKeysWithDictionary:lDic];
                [self.listData addObject:model];
            }
            [self.table reloadData];
        } withFailureBlock:^(NSString *errorMessage, int code) {
            
        }];
        
    }else{
        url = home_MyFeeRepay;
        [AppNetworking requestWithType:HttpRequestTypePost withUrlString:url withParaments:dic withSuccessBlock:^(id json) {
            NSDictionary *dic = [json objectForKey:@"info"];
            NSArray *arr = [dic objectForKey:@"list"];
            for (NSDictionary *lDic in arr) {
                MyFeeRateModel *model = [MyFeeRateModel model];
                [model setValuesForKeysWithDictionary:lDic];
                [self.listData addObject:model];
            }
            [self.table reloadData];
        } withFailureBlock:^(NSString *errorMessage, int code) {
            
        }];
    }
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
        return [self.title isEqualToString:@"收款费率"] ? 140 : 115;
    }else{
        return 180;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        if ([self.title isEqualToString:@"收款费率"]) {
            static NSString *identifier = @"ReciveFeeCell";
            MyFeeRateReceiveModel *model = [self.listData objectAtIndex:indexPath.row];
            ReciveFeeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[ReciveFeeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
            }
            [cell setMyFeeModel:model];
            
            return cell;
        }else{
            static NSString *identifier = @"RepayFeeCell";
            MyFeeRateModel *model = [self.listData objectAtIndex:indexPath.row];
            RepayFeeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
                cell = [[RepayFeeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
                cell.selectionStyle = UITableViewCellSelectionStyleNone;
            }
            [cell setMyFeeModel:model];
            return cell;
        }
        
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
        
    }
    
}



#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH,SCREEN_HEIGHT - 64 - 50 - SafeAreaTopHeight)];
        _table.dataSource = self;
        _table.delegate = self;
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

@end
