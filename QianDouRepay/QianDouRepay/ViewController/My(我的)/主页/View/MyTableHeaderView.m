//
//  MyTableHeaderView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MyTableHeaderView.h"
#import "MyHeadView.h"

#import "TakeOutCashVC.h"

@implementation MyTableHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = HEXACOLOR(0xffffff);
        MyHeadView *v = [[MyHeadView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 120)];
        [self addSubview:v];
        [self addSubview:self.headImg];
        [self addSubview:self.nameLabel];
        [self addSubview:self.VIPLabel];
        UIView *linev = [[UIView alloc]init];
        linev.backgroundColor = HEXACOLOR(0xdddddd);
        [self addSubview:linev];
        [self addSubview:self.moneyLabel];
        [self addSubview:self.tixianBtn];
        
//        UIView *linev1 = [[UIView alloc]init];
//        linev1.backgroundColor = HEXACOLOR(0xf0f1f2);
//        [self addSubview:linev1];
        
        self.headImg.sd_layout.centerXEqualToView(self).topSpaceToView(self, 85).heightIs(66).widthIs(66);
        self.headImg.sd_cornerRadiusFromWidthRatio = @(0.5);
        
        self.nameLabel.sd_layout.topSpaceToView(self.headImg, 10).leftEqualToView(self).rightEqualToView(self).heightIs(17);
        
        self.VIPLabel.sd_layout.topSpaceToView(self.nameLabel, 11).leftEqualToView(self).rightEqualToView(self).heightIs(12);
        
        linev.sd_layout.topSpaceToView(self.VIPLabel, 20).leftEqualToView(self).rightEqualToView(self).heightIs(1);
        
        self.moneyLabel.sd_layout.topSpaceToView(linev, 0).leftSpaceToView(self, 13).rightSpaceToView(self, 80).heightIs(50);
        
        self.tixianBtn.sd_layout.centerYEqualToView(self.moneyLabel).rightSpaceToView(self, 13).heightIs(25).widthIs(58);
        
//        linev1.sd_layout.topSpaceToView(self.moneyLabel, 0).leftEqualToView(self).rightEqualToView(self).heightIs(10);
    }
    return self;
}


- (void)tixianClick{
    
    UIViewController *vc = [AppCommon getViewController:self];
    
    TakeOutCashVC *cashVc = [[TakeOutCashVC alloc]init];
    [vc.navigationController pushViewController:cashVc animated:YES];
}










#pragma mark - LazyLoad
- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [AppUIKit labelWithTitle:UserNickName titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _nameLabel;
}


- (UIImageView *)headImg{
    if (!_headImg) {
        _headImg = [[UIImageView alloc]init];
        _headImg.backgroundColor = WhiteColor;
        _headImg.layer.borderColor = [UIColor whiteColor].CGColor;
        _headImg.layer.borderWidth = 4;
    }
    return _headImg;
}

- (UILabel *)VIPLabel{
    if (!_VIPLabel) {
        _VIPLabel = [AppUIKit labelWithTitle:@"普通会员" titleFontSize:12 textColor:HEXACOLOR(0xe60013) backgroundColor:[UIColor whiteColor] alignment:NSTextAlignmentCenter];
    }
    return _VIPLabel;
}

- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [AppUIKit labelWithTitle:@"账户余额：￥1562.00" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentLeft];
    }
    return _moneyLabel;
}

- (UIButton *)tixianBtn{
    if (!_tixianBtn) {
        _tixianBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom
                               backgroundColor:nil
                                        action:@selector(tixianClick)
                                        target:self
                                         title:@"提现"
                                         image:nil
                                          font:12
                                     textColor:HEXACOLOR(0x1f2876)];
        _tixianBtn.layer.borderColor = HEXACOLOR(0x1f2876).CGColor;
        _tixianBtn.layer.borderWidth = 1;
        _tixianBtn.layer.cornerRadius = 3;
    }
    return _tixianBtn;
}

@end
