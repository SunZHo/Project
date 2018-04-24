//
//  MySuperiorViewController.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/18.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MySuperiorViewController.h"

@interface MySuperiorViewController ()

@property (nonatomic , strong) UIImageView *backImg;
@property (nonatomic , strong) UIImageView *iconImage;
@property (nonatomic , strong) UILabel *nameLabel;
@property (nonatomic , strong) UILabel *phoneLabel;
@property (nonatomic , strong) UILabel *typeLabel;

@end

@implementation MySuperiorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"我的上级";
    self.view.backgroundColor = HEXACOLOR(0xf4ebc3);
    [self wr_setNavBarShadowImageHidden:YES];
    
    [self makeUI];
    
    [self loadData];
}


- (void)loadData{
    self.iconImage.image = IMG(@"");
    self.iconImage.backgroundColor = randomColor;
    self.nameLabel.text = @"张小君";
    self.phoneLabel.text = @"157****1234";
    self.typeLabel.text = @"VIP 会员";
    
}


- (void)makeUI{
    [self.view addSubview:self.backImg];
    
    [self.backImg sd_addSubviews:@[self.iconImage, self.nameLabel, self.phoneLabel, self.typeLabel]];
    
    
    self.iconImage.sd_layout.topSpaceToView(self.backImg, kScaleWidth(328)).centerXEqualToView(self.backImg).widthIs(74).heightIs(74);
    self.iconImage.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    self.nameLabel.sd_layout.topSpaceToView(self.iconImage, 19).leftEqualToView(self.backImg).rightEqualToView(self.backImg).heightIs(15);
    
    self.phoneLabel.sd_layout.topSpaceToView(self.nameLabel, 14).leftEqualToView(self.backImg).rightEqualToView(self.backImg).heightIs(15);
    
    self.typeLabel.sd_layout.topSpaceToView(self.phoneLabel, 19).centerXEqualToView(self.backImg).widthIs(90).heightIs(30);
    
}







- (UIImageView *)backImg{
    if (!_backImg) {
        CGFloat height = 0;
        if (IS_IPHONE_X) {
            height = 604;
        }else{
            height = SCREEN_HEIGHT - 64 - SafeAreaTopHeight;
        }
        _backImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64 + SafeAreaTopHeight, SCREEN_WIDTH, height)];
        _backImg.image = IMG(@"sjbj");
    }
    return _backImg;
}

- (UIImageView *)iconImage{
    if (!_iconImage) {
        _iconImage = [[UIImageView alloc]init];
    }
    return _iconImage;
}


- (UILabel *)nameLabel{
    if (!_nameLabel) {
        _nameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _nameLabel;
}

- (UILabel *)phoneLabel{
    if (!_phoneLabel) {
        _phoneLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _phoneLabel;
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:HEXACOLOR(0xfc3636) backgroundColor:nil alignment:NSTextAlignmentCenter];
        _typeLabel.layer.borderColor = HEXACOLOR(0xfc3636).CGColor;
        _typeLabel.layer.borderWidth = 0.5;
        _typeLabel.layer.cornerRadius = 5;
    }
    return _typeLabel;
}






@end
