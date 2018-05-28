//
//  ShareViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ShareViewController.h"

// controller
#import "InviteRecordViewController.h"

// view

#import "inviteExplanCell.h"

@interface ShareViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic , strong) BaseTableView *table;

@property (nonatomic , strong) NSMutableArray *listData;

@property (nonatomic , copy) NSString *shareUrl;

@property (nonatomic , strong) UIScrollView *backGroundScrollV;
@property (nonatomic , strong) UIImageView *inviteView;
@property (nonatomic , strong) UIImageView *QRcodeView;
@property (nonatomic , strong) UIImageView *inviteImgView;
@property (nonatomic , strong) UIButton *shareButton;
@property (nonatomic , strong) UILabel *rewardLabel;

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"推广";
    [self wr_setNavBarShadowImageHidden:YES];
    [self setNavRightBarItem];
    [self loadData];
    
    [self makeUI];
    
    
    
    
}

- (void)loadData{
    self.listData = [NSMutableArray arrayWithArray:@[@"您邀请的好友注册成功完成实名认证后便会有奖励",
                                                     @"普通会员达到一定的邀请人数后(通过实名认证)便会自动升级为VIP会员",
                                                     @"如有其他疑问请咨询钱兜代你还客服"]];
    [self showLoading];
    NSDictionary *dic = @{@"userid":UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:shareInfoUrl withParaments:dic withSuccessBlock:^(id json) {
        [self dismissLoading];
        NSDictionary *infoDic = [json objectForKey:@"info"];
        [self.QRcodeView sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"qrcode"]]];
        self.rewardLabel.text = [NSString stringWithFormat:@"累计获得奖励：￥%@",[infoDic objectForKey:@"allaward"]];
        self.shareUrl = [infoDic objectForKey:@"url"];
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
}

- (void)makeUI{
    
    [self.view addSubview:self.backGroundScrollV];
    
    [self.backGroundScrollV addSubview:self.inviteView];
    
    self.inviteView.sd_layout
    .topEqualToView(self.backGroundScrollV).leftEqualToView(self.backGroundScrollV).rightEqualToView(self.backGroundScrollV).heightIs(kScaleWidth(837));
    
    [self.inviteView addSubview:self.rewardLabel];
    [self.inviteView addSubview:self.QRcodeView];
    [self.inviteView addSubview:self.shareButton];
    [self.inviteView addSubview:self.inviteImgView];
    [self.inviteImgView addSubview:self.table];
    
    self.rewardLabel.sd_layout.topSpaceToView(self.inviteView, kScaleWidth(384)).leftEqualToView(self.inviteView).rightEqualToView(self.inviteView).heightIs(15);
    
    self.QRcodeView.sd_layout.topSpaceToView(self.rewardLabel, kScaleWidth(23)).centerXEqualToView(self.inviteView).widthIs(kScaleWidth(108)).heightEqualToWidth();
    
    self.shareButton.sd_layout.topSpaceToView(self.QRcodeView, kScaleWidth(27)).centerXEqualToView(self.inviteView).widthIs(220).heightIs(40);
    
    self.inviteImgView.sd_layout.topSpaceToView(self.shareButton, kScaleWidth(33)).centerXEqualToView(self.inviteView).widthIs(kScaleWidth(325)).heightIs(kScaleWidth(147));
    
    self.table.sd_layout.topSpaceToView(self.inviteImgView, kScaleWidth(25)).leftSpaceToView(self.inviteImgView, 17).rightSpaceToView(self.inviteImgView, 17).bottomSpaceToView(self.inviteImgView, kScaleWidth(12));
    
}



- (void)setNavRightBarItem{
    UIButton *billCardBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [billCardBtn addTarget:self action:@selector(inviteRecord) forControlEvents:UIControlEventTouchUpInside];
    [billCardBtn setTitle:@"邀请记录" forState:UIControlStateNormal];
    billCardBtn.titleLabel.font = kFont(15);
    [billCardBtn setTitleColor:defaultTextColor forState:UIControlStateNormal];
    [billCardBtn sizeToFit];
    UIBarButtonItem *billItem = [[UIBarButtonItem alloc] initWithCustomView:billCardBtn];
    self.navigationItem.rightBarButtonItems  = @[billItem];
}

- (void)inviteRecord{
    InviteRecordViewController *inviteRecordVc = [[InviteRecordViewController alloc]init];
    PUSHVC(inviteRecordVc);
}

- (void)shareClick{
    NSString *title = @"钱兜代你还";
    NSString *describe = @"钱兜代你还，您的信用卡还款小助手。";
    UIImage *shareImg = IMG(@"loginLogo");
    NSString *url = self.shareUrl;
    __weak typeof(self) wself = self;
    [[AppDelegate new] shareWebPageWithURLStr:url title:title description:describe thumImage:shareImg currentViewController:self callback:^(BOOL success, id responseObject, NSError *error) {
        if (success) {
            [wself showSuccessText:@"分享成功"];
        }
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
        return [self cellHeightForIndexPath:indexPath cellContentViewWidth:SCREEN_WIDTH tableView:tableView];
        //        return 140;
    }else{
        return 180;
    }
    
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.listData.count > 0) {
        static NSString *identifier = @"inviteExplanCell";
        NSString *str = [self.listData objectAtIndex:indexPath.row];
        inviteExplanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (!cell) {
            cell = [[inviteExplanCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        cell.explanLabel.text = str;
        
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

- (UIScrollView *)backGroundScrollV{
    if (!_backGroundScrollV) {
        _backGroundScrollV = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _backGroundScrollV.backgroundColor = Default_BackgroundGray;
        _backGroundScrollV.contentSize = CGSizeMake(SCREEN_WIDTH, kScaleWidth(837));
        _backGroundScrollV.showsVerticalScrollIndicator = NO;
        _backGroundScrollV.showsHorizontalScrollIndicator = NO;
        /** _backGroundScrollV.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
         [_backGroundScrollV.mj_header endRefreshing];
         });
         }]; */
    }
    return _backGroundScrollV;
}


- (UIImageView *)inviteView{
    if (!_inviteView) {
        _inviteView = [[UIImageView alloc]init];
        _inviteView.image = IMG(@"yqhy");
        _inviteView.userInteractionEnabled = YES;
//        _inviteView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _inviteView;
}

- (UIImageView *)inviteImgView{
    if (!_inviteImgView) {
        _inviteImgView = [[UIImageView alloc]init];
        _inviteImgView.image = IMG(@"yasm");
        _inviteImgView.userInteractionEnabled = YES;
    }
    return _inviteImgView;
}

- (UIImageView *)QRcodeView{
    if (!_QRcodeView) {
        _QRcodeView = [[UIImageView alloc]init];
    }
    return _QRcodeView;
}

- (UILabel *)rewardLabel{
    if (!_rewardLabel) {
        _rewardLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _rewardLabel;
}

- (UIButton *)shareButton{
    if (!_shareButton) {
        _shareButton = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(shareClick) target:self title:@"" image:@"fxan" font:0 textColor:nil];
    }
    return _shareButton;
}


- (BaseTableView *)table{
    if (!_table) {
        _table = [[BaseTableView alloc]init];
        _table.dataSource = self;
        _table.delegate = self;
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
