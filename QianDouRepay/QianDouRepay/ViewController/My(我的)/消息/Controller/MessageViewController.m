//
//  MessageViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MessageViewController.h"

// model
#import "MessageModel.h"

// view
#import "MessageCell.h"

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"消息";
    self.view.backgroundColor = WhiteColor;
    [self setNavRightBarItem];
    
    for (int i = 0; i < 10; i++) {
        MessageModel *model = [[MessageModel alloc]init];
        model.time = @"2018-01-12 14:30";
        model.title = @"消息标题";
        model.content = @"您好，您的信用卡(6123123412341234123)成功消费198.00您好，您的信用卡(6123123412341234123)成功消费198.00......";
        if (i % 2 == 1) {
            model.isRead = YES;
        }else{
            model.isRead = NO;
        }
        [self.listData addObject:model];
    }
    
    [self.view addSubview:self.table];
}

- (void)setNavRightBarItem{
    UIButton *billCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billCardBtn addTarget:self action:@selector(allRead) forControlEvents:UIControlEventTouchUpInside];
    [billCardBtn setTitle:@"全部标为已读" forState:UIControlStateNormal];
    billCardBtn.titleLabel.font = kFont(15);
    [billCardBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
    [billCardBtn sizeToFit];
    UIBarButtonItem *billItem = [[UIBarButtonItem alloc] initWithCustomView:billCardBtn];
    self.navigationItem.rightBarButtonItems  = @[billItem];
}


- (void)allRead{
    
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
        return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
    }else{
        return 180;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        static NSString *identifier = @"MessageCell";
        MessageModel *model = [self.listData objectAtIndex:indexPath.row];
        MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[MessageCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        [cell setMessageModel:model];
        
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
    MessageModel *model = [self.listData objectAtIndex:indexPath.row];
    model.isRead = YES;
    [self.table reloadData];
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
