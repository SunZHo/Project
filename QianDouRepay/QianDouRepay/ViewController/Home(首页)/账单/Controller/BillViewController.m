//
//  BillViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BillViewController.h"

// view
#import "BillCell.h"

// model
#import "BillModel.h"

// controller
#import "BillDetailViewController.h"

@interface BillViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@property (nonatomic , strong) UIView *rightBarCustomView;

@end

@implementation BillViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"账单";
    self.view.backgroundColor = WhiteColor;
    [self setNavRightBarItem];
    for (int i = 0; i < 10; i++) {
        BillModel *model = [[BillModel alloc]init];
        model.time = @"2018-03-29 14:32 (尾号1234)";
        if (i % 2 == 1) {
            model.money = @"消费￥500.00";
            model.type = @"已成功";
            model.status = @"1";
        }else{
            model.money = @"还款￥500.00";
            model.type = @"未完成";
            model.status = @"0";
        }
        [self.listData addObject:model];
    }
    
    [self.view addSubview:self.table];
    
}



- (void)setNavRightBarItem{
    UIBarButtonItem *billItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBarCustomView];
    self.navigationItem.rightBarButtonItems  = @[billItem];
}


- (void)filterClick:(UIButton *)optionButton{
    // 注意：由convertRect: toView 获取到屏幕上该控件的绝对位置。
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    CGRect frame = [optionButton convertRect:optionButton.bounds toView:window];
    
    FKGPopOption *s = [[FKGPopOption alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
    s.option_optionContents = @[@"全部",@"还款",@"消费"];
    s.option_lineHeight = 44;
//    __weak __typeof(self) weakSelf = self;
    [[s option_setupPopOption:^(NSInteger index, NSString *content) {
        [optionButton setTitle:content forState:UIControlStateNormal];
        if (index == 0) {
            
        }else if(index == 1){
            
        }else{
            
        }
        
        
    } whichFrame:frame animate:YES] option_show];
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
        static NSString *identifier = @"BillCell";
        BillModel *model = [self.listData objectAtIndex:indexPath.row];
        BillCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[BillCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setBillmodel:model];
        
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
        BillModel *model = [self.listData objectAtIndex:indexPath.row];
        BillDetailViewController *detailVC = [[BillDetailViewController alloc]init];
        detailVC.status = model.status;
        PUSHVC(detailVC);
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


- (UIView *)rightBarCustomView{
    if (!_rightBarCustomView) {
        _rightBarCustomView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 50, 20)];
        UIButton *billCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [billCardBtn addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
        [billCardBtn setTitle:@"全部" forState:UIControlStateNormal];
        billCardBtn.titleLabel.font = kFont(15);
        [billCardBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
        billCardBtn.frame = CGRectMake(0, 0, 35, 20);
        [_rightBarCustomView addSubview:billCardBtn];
        
        UIImageView *iv = [[UIImageView alloc]initWithFrame:CGRectMake(40, 8, 6, 4)];
        iv.image = IMG(@"sjxx");
        [_rightBarCustomView addSubview:iv];
        
    }
    return _rightBarCustomView;
}

@end
