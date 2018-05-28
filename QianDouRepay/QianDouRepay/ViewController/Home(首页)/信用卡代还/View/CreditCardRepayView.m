//
//  CreditCardRepayView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/11.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "CreditCardRepayView.h"

@interface CreditCardRepayView ()

@property (nonatomic , strong) UILabel *moneyLabel;
@property (nonatomic , strong) UILabel *billLabel;
@property (nonatomic , strong) UILabel *repayLabel;

@end

@implementation CreditCardRepayView

- (instancetype)init{
    if (self == [super init]) {
        [self makeUI];
        
    }
    return self;
}

- (void)makeUI{
    self.backgroundColor = WhiteColor;
    UIView *topLine = [[UIView alloc]init];
    topLine.backgroundColor = Default_BackgroundGray;
    [self addSubview:topLine];
    
    [self addSubview:self.moneyLabel];
    UILabel *moneySubLabel = [AppUIKit labelWithTitle:@"还款金额" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
    [self addSubview:moneySubLabel];
    
    UILabel *billSubLabel = [AppUIKit labelWithTitle:@"账单日" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
    [self addSubview:billSubLabel];
    
    UILabel *repaySubLabel = [AppUIKit labelWithTitle:@"还款日" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
    [self addSubview:repaySubLabel];
    
    [self addSubview:self.billLabel];
    [self addSubview:self.repayLabel];
    
    UIView *midLine =[[UIView alloc]init];
    midLine.backgroundColor = Default_BackgroundGray;
    [self addSubview:midLine];
    
    UIView *bottomLine =[[UIView alloc]init];
    bottomLine.backgroundColor = Default_BackgroundGray;
    [self addSubview:bottomLine];
    
    topLine.sd_layout.topSpaceToView(self, 0).leftEqualToView(self).rightEqualToView(self).heightIs(10);
    
    self.moneyLabel.sd_layout.topSpaceToView(topLine, kScaleWidth(25)).leftEqualToView(self).rightEqualToView(self).heightIs(25);
    moneySubLabel.sd_layout.topSpaceToView(self.moneyLabel, kScaleWidth(15)).leftEqualToView(self).rightEqualToView(self).heightIs(13);
    
    billSubLabel.sd_layout.topSpaceToView(moneySubLabel, kScaleWidth(45)).leftEqualToView(self).widthRatioToView(self, 0.5).heightIs(12);
    repaySubLabel.sd_layout.topEqualToView(billSubLabel).leftSpaceToView(billSubLabel, 0).heightRatioToView(billSubLabel, 1).rightSpaceToView(self, 0);
    
    self.billLabel.sd_layout.topSpaceToView(billSubLabel, kScaleWidth(15)).leftEqualToView(billSubLabel).widthRatioToView(billSubLabel, 1).heightIs(15);
    self.repayLabel.sd_layout.topEqualToView(self.billLabel).leftEqualToView(repaySubLabel).heightRatioToView(self.billLabel, 1).rightEqualToView(repaySubLabel);
    
    midLine.sd_layout.topSpaceToView(billSubLabel, 0).centerXEqualToView(self).heightIs(20).widthIs(1);
    bottomLine.sd_layout.bottomSpaceToView(self, 0).leftSpaceToView(self, 12).heightIs(1).rightSpaceToView(self, 12);
    
    
}



- (void)setCardModel:(CreditCardModel *)cardModel{
    _cardModel = cardModel;
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",cardModel.money];
    self.billLabel.text = [NSString stringWithFormat:@"每月%@日",cardModel.statement_date];
    self.repayLabel.text = [NSString stringWithFormat:@"每月%@日",cardModel.repayment_date];
}




- (UILabel *)moneyLabel{
    if (!_moneyLabel) {
        _moneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:25 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
    }
    return _moneyLabel;
}

- (UILabel *)billLabel{
    if (!_billLabel) {
        _billLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
    }
    return _billLabel;
}

- (UILabel *)repayLabel{
    if (!_repayLabel) {
        _repayLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
    }
    return _repayLabel;
}


@end
