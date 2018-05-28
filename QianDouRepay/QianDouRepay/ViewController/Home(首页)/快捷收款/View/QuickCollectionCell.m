//
//  QuickCollectionCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "QuickCollectionCell.h"
#import "ChooseBankCardVC.h"
#import "AddReceiptBankCardVC.h"

@implementation QuickCollectionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.lineV_10pt = [[UIView alloc]init];
        self.lineV_10pt.backgroundColor = Default_BackgroundGray;
        
        self.iconImg = [[UIImageView alloc]initWithImage:IMG(@"flyl")];
        
        self.pathLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.lineVTop_1pt = [[UIView alloc]init];
        self.lineVTop_1pt.backgroundColor = Default_BackgroundGray;
        
        self.rateLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.limitLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.typeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.lineVBottom_1pt = [[UIView alloc]init];
        self.lineVBottom_1pt.backgroundColor = Default_BackgroundGray;
        
        self.moneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.payButtton = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:WhiteColor action:@selector(PayClick) target:self title:@"立即支付" image:nil font:12 textColor:HEXACOLOR(0x1e2674)];
        self.payButtton.layer.borderColor = APPMainColor.CGColor;
        self.payButtton.layer.borderWidth = 0.5;
        self.payButtton.layer.cornerRadius = 3;
        
        
        
        [self.contentView sd_addSubviews:@[self.lineV_10pt,
                                           self.iconImg,
                                           self.pathLabel,
                                           self.lineVTop_1pt,
                                           self.rateLabel,
                                           self.timeLabel,
                                           self.limitLabel,
                                           self.typeLabel,
                                           self.lineVBottom_1pt,
                                           self.moneyLabel,
                                           self.payButtton
                                           ]];
        
        [self autoLayout];
    }
    return self;
}


- (void)autoLayout{
    self.lineV_10pt.sd_layout
    .topEqualToView(self.contentView)
    .leftEqualToView(self.contentView)
    .heightIs(10).widthIs(SCREEN_WIDTH);
    
    self.iconImg.sd_layout.topSpaceToView(self.lineV_10pt, 14)
    .leftSpaceToView(self.contentView, 12)
    .heightIs(17)
    .widthIs(27);
    
    self.pathLabel.sd_layout.leftSpaceToView(self.iconImg, 12)
    .centerYEqualToView(self.iconImg)
    .heightIs(15)
    .rightEqualToView(self.contentView);
    
    self.lineVTop_1pt.sd_layout.leftEqualToView(self.iconImg)
    .topSpaceToView(self.iconImg, 14)
    .rightSpaceToView(self.contentView, 12)
    .heightIs(1);
    
    self.rateLabel.sd_layout.topSpaceToView(self.lineVTop_1pt, 17)
    .leftEqualToView(self.iconImg)
    .rightEqualToView(self.pathLabel)
    .heightIs(12);
    
    self.timeLabel.sd_layout.topSpaceToView(self.rateLabel, 17)
    .leftEqualToView(self.iconImg)
    .rightEqualToView(self.pathLabel)
    .heightRatioToView(self.rateLabel, 1);
    
    self.limitLabel.sd_layout.topSpaceToView(self.timeLabel, 17)
    .leftEqualToView(self.iconImg)
    .rightEqualToView(self.pathLabel)
    .heightRatioToView(self.rateLabel, 1);
    
    self.typeLabel.sd_layout.topSpaceToView(self.limitLabel, 17)
    .leftEqualToView(self.iconImg)
    .rightEqualToView(self.pathLabel)
    .heightRatioToView(self.rateLabel, 1);
    
    self.lineVBottom_1pt.sd_layout.topSpaceToView(self.typeLabel, 18)
    .leftEqualToView(self.iconImg)
    .rightEqualToView(self.lineVTop_1pt)
    .heightIs(1);
    
    self.moneyLabel.sd_layout.topSpaceToView(self.lineVBottom_1pt, 22)
    .leftEqualToView(self.iconImg)
    .heightIs(15)
    .rightSpaceToView(self.contentView, 100);
    
    self.payButtton.sd_layout.rightSpaceToView(self.contentView, 12)
    .centerYEqualToView(self.moneyLabel)
    .heightIs(28)
    .widthIs(80);
    
}



- (void)setQuickModel:(QuickCollectionModel *)quickModel{
    _quickModel = quickModel;
    self.pathLabel.text = quickModel.pathName;
    self.rateLabel.text = [NSString stringWithFormat:@"费率：%@%%+%@元/笔",quickModel.pay_huipoint,quickModel.paygu_huipoint];
    self.timeLabel.text = [NSString stringWithFormat:@"交易时间：%@",quickModel.time];
    self.limitLabel.text = [NSString stringWithFormat:@"额度：%@",quickModel.desc];
    self.typeLabel.text = [NSString stringWithFormat:@"结算：%@",quickModel.jiesuan];
    
    NSString *moneystr = [NSString stringWithFormat:@"￥%@",quickModel.money];
    NSString *money = [NSString stringWithFormat:@"实时到账：%@",moneystr];
    self.moneyLabel.text = money;
    self.moneyLabel.attributedText = [AppCommon getRange:NSMakeRange(@"实时到账：".length, moneystr.length) labelStr:money Font:kFont(18) Color:HEXACOLOR(0x5cb7ff)];
    
    
    
}

- (void)PayClick{
    UIViewController *vc = [AppCommon getViewController:self.contentView];
    ChooseBankCardVC *bankCardVc = [[ChooseBankCardVC alloc]init];
    bankCardVc.receiptMoney = _quickModel.inputMoney;
    [vc.navigationController pushViewController:bankCardVc animated:YES];
}






@end
