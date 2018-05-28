//
//  UplevelView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/25.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "UplevelView.h"
#import "ChoosePayWayVC.h"

@interface UplevelView ()

@property (nonatomic , strong) UIView *backView;

@property (nonatomic , strong) UILabel *moneyLabel;


@end

@implementation UplevelView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.35f];
        [self layoutSubview];
    }
    return self;
}


-(void)layoutSubview{
    self.backView = [[UIView alloc]init];
    self.backView.backgroundColor = [UIColor whiteColor];
    self.backView.layer.cornerRadius = 5;
    self.backView.clipsToBounds = YES;
    [self addSubview:self.backView];
    self.backView.sd_layout.centerXEqualToView(self).centerYEqualToView(self).widthIs(240).heightIs(141);
    
    self.moneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    self.moneyLabel.numberOfLines = 0;
    
    [self.backView addSubview:self.moneyLabel];
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = HEXACOLOR(0xdddddd);
    [self.backView addSubview:lineV];
    
    UIButton *cancleBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(cancleClick) target:self title:@"稍后再去" image:nil font:15 textColor:HEXACOLOR(0x999999)];
    
    UIButton *payBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(payClick) target:self title:@"去支付" image:nil font:15 textColor:HEXACOLOR(0x6ca0ff)];
    [self.backView addSubview:cancleBtn];
    [self.backView addSubview:payBtn];
    
    
    UIView *lineV1 = [[UIView alloc]init];
    lineV1.backgroundColor = HEXACOLOR(0xdddddd);
    [self.backView addSubview:lineV1];
    
    self.moneyLabel.sd_layout.topSpaceToView(self.backView, 29).leftEqualToView(self.backView).rightEqualToView(self.backView).heightIs(50);
    
    lineV.sd_layout.bottomSpaceToView(self.backView, 44).leftEqualToView(self.backView).rightEqualToView(self.backView).heightIs(1);
    
    cancleBtn.sd_layout.bottomSpaceToView(self.backView, 0).leftEqualToView(self.backView).widthRatioToView(self.backView, 0.5).heightIs(44);
    
    payBtn.sd_layout.bottomSpaceToView(self.backView, 0).leftSpaceToView(cancleBtn, 0).widthRatioToView(self.backView, 0.5).heightIs(44);
    
    lineV1.sd_layout.bottomSpaceToView(self.backView, 0).centerXEqualToView(self.backView).widthIs(1).heightIs(44);
    
    
}


- (void)payClick{
    [self dismiss];
    if (self.payClickBlock) {
        self.payClickBlock();
    }
    
}


- (void)cancleClick{
    [self dismiss];
}


- (void)show {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
    self.backView.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    self.backView.alpha = 0;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.backView.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.backView.alpha = 1.0;
    } completion:nil];
}

- (void)dismiss{
    [UIView animateWithDuration:0.3f animations:^{
        self.backView.alpha = 0;
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }];
}

- (void)setMoney:(NSString *)money{
    _money = money;
    NSString *moneyStr = [NSString stringWithFormat:@"升级为VIP会员\n需要您支付%@元",money];
    self.moneyLabel.text = moneyStr;
    self.moneyLabel.attributedText = [AppCommon getRange:NSMakeRange(@"升级为VIP会员\n需要您支付".length, [NSString stringWithFormat:@"%@元",money].length) labelStr:moneyStr Font:kFont(18) Color:HEXACOLOR(0xff000e)];
}

- (void)setInfoStr:(NSAttributedString *)infoStr{
    self.moneyLabel.attributedText = infoStr;
}



@end
