//
//  RepayPlanTotalView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "RepayPlanTotalView.h"

@interface RepayPlanTotalView ()

@property (nonatomic , strong) UIView *backView;
@property (nonatomic , strong) NSDictionary *previewDic;

@end



@implementation RepayPlanTotalView

-(instancetype)initWithFrame:(CGRect)frame infoDic:(NSDictionary *)dic{
    if (self == [super initWithFrame:frame]) {
        self.frame = [UIScreen mainScreen].bounds;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.3f];
        self.previewDic = dic;
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
    self.backView.sd_layout.centerXEqualToView(self).centerYEqualToView(self).widthIs(kScaleWidth(320)).heightIs(210);
    
    
    UILabel *leftLabel1 = [AppUIKit labelWithTitle:@"消费总额" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:0];
    
    UILabel *leftLabel2 = [AppUIKit labelWithTitle:@"还款总额" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:0];
    
    UILabel *leftLabel3 = [AppUIKit labelWithTitle:@"手续费总额" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:0];
    
    UILabel *leftLabel4 = [AppUIKit labelWithTitle:@"信用卡建议预留额度" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:0];
    
    
    UILabel *rightLabel1 = [AppUIKit labelWithTitle:[NSString stringWithFormat:@"￥%@",[self.previewDic objectForKey:@"pay_money"]]
                                      titleFontSize:12
                                          textColor:HEXACOLOR(0x666666)
                                    backgroundColor:WhiteColor
                                          alignment:NSTextAlignmentRight];
    
    UILabel *rightLabel2 = [AppUIKit labelWithTitle:[NSString stringWithFormat:@"￥%@",[self.previewDic objectForKey:@"repayment_money"]]
                                      titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
    
    UILabel *rightLabel3 = [AppUIKit labelWithTitle:[NSString stringWithFormat:@"￥%@",[self.previewDic objectForKey:@"fee_money"]]
                                      titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
    
    UILabel *rightLabel4 = [AppUIKit labelWithTitle:[NSString stringWithFormat:@"￥%@",[self.previewDic objectForKey:@"min_money"]]
                                      titleFontSize:12 textColor:HEXACOLOR(0xe60012) backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
    
    [self.backView sd_addSubviews:@[leftLabel1,leftLabel2,leftLabel3,leftLabel4,
                                    rightLabel1,rightLabel2,rightLabel3,rightLabel4]];
    
    leftLabel1.sd_layout.topSpaceToView(self.backView, 20).leftSpaceToView(self.backView, 12).heightIs(12).widthRatioToView(self.backView, 0.4);
    
    leftLabel2.sd_layout.topSpaceToView(leftLabel1, 23).leftSpaceToView(self.backView, 12).heightIs(12).widthRatioToView(self.backView, 0.4);
    
    leftLabel3.sd_layout.topSpaceToView(leftLabel2, 23).leftSpaceToView(self.backView, 12).heightIs(12).widthRatioToView(self.backView, 0.4);
    
    leftLabel4.sd_layout.topSpaceToView(leftLabel3, 23).leftSpaceToView(self.backView, 12).heightIs(12).widthRatioToView(self.backView, 0.5);
    
    rightLabel1.sd_layout.topSpaceToView(self.backView, 20).rightSpaceToView(self.backView, 12).heightIs(12).widthRatioToView(self.backView, 0.4);
    
    rightLabel2.sd_layout.topSpaceToView(rightLabel1, 23).rightSpaceToView(self.backView, 12).heightIs(12).widthRatioToView(self.backView, 0.4);
    
    rightLabel3.sd_layout.topSpaceToView(rightLabel2, 23).rightSpaceToView(self.backView, 12).heightIs(12).widthRatioToView(self.backView, 0.4);
    
    rightLabel4.sd_layout.topSpaceToView(rightLabel3, 23).rightSpaceToView(self.backView, 12).heightIs(12).widthRatioToView(self.backView, 0.4);
    
    
    
    UIButton *cancleBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(dismiss) target:self title:@"取消" image:nil font:14 textColor:HEXACOLOR(0x999999)];
    
    [self.backView addSubview:cancleBtn];
    
    UIButton *sureBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(sureClick) target:self title:@"确定" image:nil font:14 textColor:HEXACOLOR(0x5cb7ff)];
    [self.backView addSubview:sureBtn];
    
    UIView *lineV = [[UIView alloc]init];
    lineV.backgroundColor = HEXACOLOR(0xf0f1f2);
    [self.backView addSubview:lineV];
    
    UIView *lineV2 = [[UIView alloc]init];
    lineV2.backgroundColor = HEXACOLOR(0xf0f1f2);
    [self.backView addSubview:lineV2];
    
    cancleBtn.sd_layout.bottomEqualToView(self.backView).leftEqualToView(self.backView).widthRatioToView(self.backView, 0.5).heightIs(44);
    sureBtn.sd_layout.bottomEqualToView(self.backView).rightEqualToView(self.backView).widthRatioToView(self.backView, 0.5).heightIs(44);
    lineV.sd_layout.bottomSpaceToView(cancleBtn, 0).leftEqualToView(self.backView).widthRatioToView(self.backView, 1).heightIs(1);
    
    lineV2.sd_layout.bottomEqualToView(self.backView).centerXEqualToView(self.backView).widthIs(1).heightIs(44);
    
}


- (void)sureClick{
    [self dismiss];
    if (self.sureCommitBlock) {
        self.sureCommitBlock();
    }
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




@end
