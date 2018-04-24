//
//  MyViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MyViewController.h"
// viewcontroller
#import "SettingViewController.h"
#import "SafeCenterViewController.h"
#import "FundsFlowViewController.h"
#import "MyVIPViewController.h"
#import "MySuperiorViewController.h"
#import "NoticeViewController.h"
#import "AboutUsViewController.h"
#import "MessageViewController.h"

// view
#import "MyTableHeaderView.h"
#import "MyTableViewCell.h"

@interface MyViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , copy) NSArray *cellLabelArray;
@property (nonatomic , copy) NSArray *cellIconArray;
@property (nonatomic , strong) BaseTableView *table;
@property (nonatomic , strong) MyTableHeaderView *tableHeadView;
@property (nonatomic , strong) UIView *tableFootView;

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [super setNavAlphaZero];
    self.view.backgroundColor = Default_BackgroundGray;
    [self setupBarButtonItem];
    [self makeUI];
    
    self.cellLabelArray = @[@[@"安全中心",@"资金流水",@"我的会员",@"我的上级"],
                            @[@"公告通知",@"关于我们"]];
    
    self.cellIconArray = @[@[@"aqzx",@"zjls",@"wdhy",@"wdsj"],
                            @[@"hgtz",@"gywm"]];
    
}

- (void)makeUI{
    
    [self.view addSubview:self.table];
    self.table.tableHeaderView = self.tableHeadView;
    
}



#pragma mark - 导航按钮
- (void)setupBarButtonItem
{
    self.navigationItem.leftBarButtonItem =({
        [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"sz"]
                                        style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(leftBarButtonItemClicked)];
    });
    
    self.navigationItem.rightBarButtonItem =({
        [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"xz"]
                                        style:UIBarButtonItemStylePlain
                                       target:self
                                       action:@selector(rightBarButtonItemClicked)];
    });
}



- (void)leftBarButtonItemClicked{
    SettingViewController *setVc = [[SettingViewController alloc]init];
    PUSHVC(setVc);
}

- (void)rightBarButtonItemClicked{
    MessageViewController *messageVc = [[MessageViewController alloc]init];
    PUSHVC(messageVc);
}


- (void)logOut{
    NSLog(@"点击退出登录");
}

#pragma mark - UITableViewDataSource && UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.cellLabelArray.count;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *arr = self.cellLabelArray[section];
    return arr.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifiy = @"myCell";
    MyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifiy];
    if (!cell) {
        cell = [[MyTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifiy];
    }
    cell.leftLabel.text = [[self.cellLabelArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    cell.iconImg.image = IMG([[self.cellIconArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]);
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
//        self.tableHeadView.headImg.backgroundColor = [UIColor redColor];
        SafeCenterViewController *safeVC = [[SafeCenterViewController alloc]init];
        PUSHVC(safeVC);
    }else if (indexPath.section == 0 && indexPath.row == 1){
//        self.tableHeadView.VIPLabel.text = @"VVVIP";
        FundsFlowViewController *fundsVC = [[FundsFlowViewController alloc]init];
        PUSHVC(fundsVC);
    }else if (indexPath.section == 0 && indexPath.row == 2){
//        self.tableHeadView.moneyLabel.text = @"账户余额：￥100000.00";
        MyVIPViewController *vipVC = [[MyVIPViewController alloc]init];
        PUSHVC(vipVC);
    }else if (indexPath.section == 0 && indexPath.row == 3){
//        self.tableHeadView.nameLabel.text = @"马云";
        MySuperiorViewController *superiorVC = [[MySuperiorViewController alloc]init];
        PUSHVC(superiorVC);
        
    }else if (indexPath.section == 1 && indexPath.row == 0){
        NoticeViewController *noticeVC = [[NoticeViewController alloc]init];
        PUSHVC(noticeVC);
        
    }else if (indexPath.section == 1 && indexPath.row == 1){
        AboutUsViewController *aboutVC = [[AboutUsViewController alloc]init];
        PUSHVC(aboutVC);
    }
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kScaleWidth(50);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10.f;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.1;
}

#pragma mark - LazyLoad

- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc] initWithFrame:CGRectMake(0, -(64 + SafeAreaTopHeight), SCREEN_WIDTH, SCREEN_HEIGHT + 64 + SafeAreaTopHeight)];
        _table.delegate = self;
        _table.dataSource = self;
        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _table.tableFooterView = self.tableFootView;
    }
    return _table;
}

- (MyTableHeaderView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[MyTableHeaderView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 268)];
    }
    return _tableHeadView;
}

- (UIView *)tableFootView{
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 78)];
        _tableFootView.backgroundColor = Default_BackgroundGray;
        UIButton *logout = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:HEXACOLOR(0xffffff) action:@selector(logOut) target:self title:@"安全退出" image:nil font:15 textColor:APPMainColor];
        logout.layer.borderColor = APPMainColor.CGColor;
        logout.layer.borderWidth = 1;
        logout.layer.cornerRadius = 5;
        
        [_tableFootView addSubview:logout];
        
        logout.sd_layout.leftSpaceToView(_tableFootView, 12).rightSpaceToView(_tableFootView, 12).heightIs(44).centerYEqualToView(_tableFootView);
        
    }
    return _tableFootView;
}


@end
