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
- (void)viewWillAppear:(BOOL)animated{
    [self loadData];
}

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
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self showSuccessText:@"退出成功"];
        ApplicationDelegate.userInfoManager.loginStatus = @"0";
        ApplicationDelegate.userInfoManager.userId = @"0";
        [ApplicationDelegate.userInfoManager.userInfo setObject:@"0" forKey:@"uid"];
        [ApplicationDelegate.userInfoManager.userInfo setObject:@"0" forKey:@"loginStatus"];
        [UserInfoCache archiveUserInfo:ApplicationDelegate.userInfoManager.userInfo keyedArchiveName:USER_INFO_CACHE];
        CYLTabBarController *tabbar = [self cyl_tabBarController];
        [tabbar cyl_popSelectTabBarChildViewControllerAtIndex:0];
    });
}



- (void)loadData{
    NSDictionary *dic = @{@"userid" : UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_accountInfo withParaments:dic withSuccessBlock:^(id json) {
        NSDictionary *infoDic = [json objectForKey:@"info"];
         // 昵称
        [UserInfoDic setObject:[infoDic objectForKey:@"nickname"] forKey:@"nickname"];
         // 手机号
        [UserInfoDic setObject:[infoDic objectForKey:@"phone"]  forKey:@"phone"];
         // 账户余额
        [UserInfoDic setObject:[infoDic objectForKey:@"account_money"] forKey:@"account_money"];
        // 是否升级推广员 1-是，0-否
        [UserInfoDic setObject:[infoDic objectForKey:@"is_vip"] forKey:@"is_vip"];
        // 提现卡 1-已绑卡，0-未绑卡
        [UserInfoDic setObject:[infoDic objectForKey:@"cash_bank"] forKey:@"cash_bank"];
        // 还款费率
        [UserInfoDic setObject:[infoDic objectForKey:@"pay_cost"] forKey:@"pay_cost"];
        // 还款单笔固定手续费
        [UserInfoDic setObject:[infoDic objectForKey:@"cash_fee"] forKey:@"cash_fee"];
        // 收款费率
        [UserInfoDic setObject:[infoDic objectForKey:@"get_cost"] forKey:@"get_cost"];
        // 收款单笔固定手续费
        [UserInfoDic setObject:[infoDic objectForKey:@"get_fee"] forKey:@"get_fee"];
        // 系统编号：邀请码
        [UserInfoDic setObject:[infoDic objectForKey:@"sys_code"] forKey:@"sys_code"];
        // 实名状态：1-是，0-否
        [UserInfoDic setObject:[infoDic objectForKey:@"is_confirm"] forKey:@"is_confirm"];
        // 提现手续费
        [UserInfoDic setObject:[infoDic objectForKey:@"member_cash"] forKey:@"member_cash"];
        // 真实姓名
        [UserInfoDic setObject:[infoDic objectForKey:@"realname"] forKey:@"realname"];
        // 身份证号码
        [UserInfoDic setObject:[infoDic objectForKey:@"idcard"] forKey:@"idcard"];
        // 性别：0-保密，1-男，2-女
        [UserInfoDic setObject:[infoDic objectForKey:@"sex"] forKey:@"sex"];
        // 用户头像
        [UserInfoDic setObject:[infoDic objectForKey:@"avatar"] forKey:@"avatar"];
        // 用户类型：4：推广员 5：普通会员
        [UserInfoDic setObject:[infoDic objectForKey:@"user_type"] forKey:@"user_type"];
        
        [UserInfoCache archiveUserInfo:UserInfoDic keyedArchiveName:USER_INFO_CACHE];
        if ([[infoDic objectForKey:@"user_type"] integerValue] == 4) {
            self.tableHeadView.VIPLabel.text = @"推广员";
        }else{
            self.tableHeadView.VIPLabel.text = @"普通用户";
        }
        self.tableHeadView.nameLabel.text = [infoDic objectForKey:@"nickname"];
        [self.tableHeadView.headImg sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"avatar"]]
                                      placeholderImage:IMG(@"tx")];
        self.tableHeadView.moneyLabel.text = [NSString stringWithFormat:@"账户余额：￥%@",[infoDic objectForKey:@"account_money"]];
        
        NSInteger count = [[infoDic objectForKey:@"new_msg"] integerValue];
        if (count > 0) {
            [self.navigationItem.rightBarButtonItem pp_addDotWithColor:WhiteColor];
        }else{
            [self.navigationItem.rightBarButtonItem pp_hiddenBadge];
        }
        [self.table.mj_header endRefreshing];
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
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
        SafeCenterViewController *safeVC = [[SafeCenterViewController alloc]init];
        PUSHVC(safeVC);
    }else if (indexPath.section == 0 && indexPath.row == 1){
        FundsFlowViewController *fundsVC = [[FundsFlowViewController alloc]init];
        PUSHVC(fundsVC);
    }else if (indexPath.section == 0 && indexPath.row == 2){
//        self.tableHeadView.moneyLabel.text = @"账户余额：￥100000.00";
        MyVIPViewController *vipVC = [[MyVIPViewController alloc]init];
        PUSHVC(vipVC);
    }else if (indexPath.section == 0 && indexPath.row == 3){
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
        _table.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [self loadData];
        }];
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
