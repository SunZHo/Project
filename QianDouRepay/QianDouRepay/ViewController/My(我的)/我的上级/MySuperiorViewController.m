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
    
    [self loadData];
}


- (void)loadData{
    
    NSDictionary *dic = @{@"userid" : UserID};
    [AppNetworking requestWithType:HttpRequestTypePost withUrlString:my_topFriend withParaments:dic withSuccessBlock:^(id json) {
        [self makeUI];
        NSDictionary *infoDic = [json objectForKey:@"info"];
        if ([[infoDic objectForKey:@"phone"]isEqualToString:@""] && [[infoDic objectForKey:@"realname"]isEqualToString:@""]) {
//            [self showErrorText:@"没有上级"];
            [self.iconImage sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:IMG(@"tx")];
            self.nameLabel.text = @"没有上级";
            NSString *phone = [infoDic objectForKey:@"phone"];
            if (phone.length == 11) {
                self.phoneLabel.text = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            }else{
                self.phoneLabel.text = @"";
            }
            self.typeLabel.hidden = YES;
        }else{
            
            [self.iconImage sd_setImageWithURL:[NSURL URLWithString:[infoDic objectForKey:@"p_avatar"]] placeholderImage:IMG(@"tx")];
            self.nameLabel.text = [infoDic objectForKey:@"realname"];
            NSString *phone = [infoDic objectForKey:@"phone"];
            if (phone.length == 11) {
                self.phoneLabel.text = [phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
            }else{
                self.phoneLabel.text = @"";
            }
            self.typeLabel.text = [infoDic objectForKey:@"p_is_vip"];
        }
        
        
    } withFailureBlock:^(NSString *errorMessage, int code) {
        
    }];
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
