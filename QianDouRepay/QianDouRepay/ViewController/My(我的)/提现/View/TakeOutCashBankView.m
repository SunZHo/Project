//
//  TakeOutCashBankView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "TakeOutCashBankView.h"

@interface TakeOutCashBankView ()

@property (nonatomic , strong) UILabel *bankNameLabel;
@property (nonatomic , strong) UILabel *bankCardLabel;

@end

@implementation TakeOutCashBankView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        [self makeUI];
    }
    return self;
}


- (void)makeUI{
    UIImageView *icon = [[UIImageView alloc]initWithImage:IMG(@"yinl")];
    UIImageView *row = [[UIImageView alloc]initWithImage:IMG(@"zsjt")];
    
    [self sd_addSubviews:@[icon,self.bankNameLabel,self.bankCardLabel,row]];
    
    icon.sd_layout.topSpaceToView(self, 23).leftSpaceToView(self, 12).heightIs(16).widthIs(27);
    
    self.bankNameLabel.sd_layout.topEqualToView(icon).leftSpaceToView(icon, 18).rightSpaceToView(self, 20).heightIs(15);
    
    self.bankCardLabel.sd_layout.topSpaceToView(self.bankNameLabel, 14).leftEqualToView(self.bankNameLabel).rightEqualToView(self.bankNameLabel).heightIs(12);
    
    row.sd_layout.centerYEqualToView(self).rightSpaceToView(self, 12).widthIs(5).heightIs(9);
    
    UIView *linev = [[UIView alloc]initWithFrame:CGRectMake(12, 87, SCREEN_WIDTH - 24, 1)];
    linev.backgroundColor = HEXACOLOR(0xc3c3c3);
    [self addSubview:linev];
    [AppCommon drawDashLine:linev lineLength:2 lineSpacing:1 lineColor:WhiteColor];
    
}









- (void)setBankCard:(NSString *)bankCard{
    _bankCard = bankCard;
    self.bankCardLabel.text = bankCard;
}


- (void)setBankName:(NSString *)bankName{
    _bankName = bankName;
    self.bankNameLabel.text = bankName;
}



#pragma mark - LazyLoad

- (UILabel *)bankNameLabel{
    if (!_bankNameLabel) {
        _bankNameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
    }
    return _bankNameLabel;
}

- (UILabel *)bankCardLabel{
    if (!_bankCardLabel) {
        _bankCardLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x333333) backgroundColor:nil alignment:0];
    }
    return _bankCardLabel;
}




@end
