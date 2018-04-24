//
//  TakeCashResultView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "TakeCashResultView.h"


@interface TakeCashResultView ()

@property (nonatomic , strong) UIImageView *statusImg;
@property (nonatomic , strong) UILabel *explanLabel;
@property (nonatomic , strong) UILabel *explanSubLabel;

@property (nonatomic , strong) UIButton *cashRecordBtn;
@property (nonatomic , strong) UIButton *statusBtn;

@end



@implementation TakeCashResultView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = WhiteColor;
        [self makeUI];
    }
    return self;
}


- (void)makeUI{
    [self sd_addSubviews:@[self.statusImg, self.explanLabel, self.explanSubLabel, self.cashRecordBtn, self.statusBtn]];
    self.statusImg.sd_layout.topSpaceToView(self, 50).centerXEqualToView(self).heightIs(69).widthIs(69);
    self.explanLabel.sd_layout.topSpaceToView(self.statusImg, 40).leftEqualToView(self).rightEqualToView(self).heightIs(15);
    self.explanSubLabel.sd_layout.topSpaceToView(self.explanLabel, 20).leftEqualToView(self).rightEqualToView(self).heightIs(12);
    
    self.cashRecordBtn.sd_layout.topSpaceToView(self.explanSubLabel, 50).leftSpaceToView(self, 20).widthIs(130).heightIs(40);
    self.statusBtn.sd_layout.topEqualToView(self.cashRecordBtn).rightSpaceToView(self, 20).widthIs(130).heightIs(40);
    
    self.cashRecordBtn.sd_cornerRadiusFromHeightRatio = @(0.5);
    self.statusBtn.sd_cornerRadiusFromHeightRatio = @(0.5);
    
}

- (void)cashRecord{
    [self dismiss];
    if (self.ClickBlock) {
        self.ClickBlock(blockTypeRecord);
    }
}

- (void)statusClick{
    [self dismiss];
    if (self.isSuccess) {
        if (self.ClickBlock) {
            self.ClickBlock(blockTypeGoback);
        }
    }else{
        if (self.ClickBlock) {
            self.ClickBlock(blockTypeReset);
        }
    }
}


- (void)setIsSuccess:(BOOL)isSuccess{
    _isSuccess = isSuccess;
    
    if (isSuccess) {
        self.statusImg.image = IMG(@"fkcg");
        self.explanLabel.text = @"您的提现申请已提交成功";
        self.explanSubLabel.text = @"款项将在1-2个工作日内转到您的银行账户";
        [self.statusBtn setTitle:@"返回" forState:UIControlStateNormal];
    }else{
        self.statusImg.image = IMG(@"fksb");
        self.explanLabel.text = @"您的提现申请提交失败";
        self.explanSubLabel.text = @"请您重新去提交提现申请";
        [self.statusBtn setTitle:@"重新设置" forState:UIControlStateNormal];
    }
}


- (void)showInView:(UIView *)view{
    [view addSubview:self];
    self.transform = CGAffineTransformMakeScale(1.21f, 1.21f);
    self.alpha = 0;
    [UIView animateWithDuration:.7f delay:0.f usingSpringWithDamping:.7f initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.transform = CGAffineTransformMakeScale(1.0f, 1.0f);
        self.alpha = 1.0;
    } completion:nil];
}



- (void)dismiss{
    [UIView animateWithDuration:0.3f animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        [[NSNotificationCenter defaultCenter]removeObserver:self];
    }];
}




#pragma mark - LazyLoad

- (UIImageView *)statusImg{
    if (!_statusImg) {
        _statusImg = [[UIImageView alloc]init];
    }
    return _statusImg;
}

- (UILabel *)explanLabel{
    if (!_explanLabel) {
        _explanLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _explanLabel;
}

- (UILabel *)explanSubLabel{
    if (!_explanSubLabel) {
        _explanSubLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x999999) backgroundColor:nil alignment:NSTextAlignmentCenter];
    }
    return _explanSubLabel;
}

- (UIButton *)cashRecordBtn{
    if (!_cashRecordBtn) {
        _cashRecordBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:HEXACOLOR(0x5cb7ff) action:@selector(cashRecord) target:self title:@"提现记录" image:nil font:15 textColor:WhiteColor];
    }
    return _cashRecordBtn;
}


- (UIButton *)statusBtn{
    if (!_statusBtn) {
        _statusBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:APPMainColor action:@selector(statusClick) target:self title:@"" image:nil font:15 textColor:HEXACOLOR(0x1e2674)];
    }
    return _statusBtn;
}

@end
