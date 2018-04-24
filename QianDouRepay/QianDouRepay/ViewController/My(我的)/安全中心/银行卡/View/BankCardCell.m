//
//  BankCardCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BankCardCell.h"

@implementation BankCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backImg = [[UIImageView alloc]initWithImage:IMG(@"yjkp")];
        
        self.bankNameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentRight];
        
        self.nameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:WhiteColor backgroundColor:nil alignment:0];
        
        self.cardNumLabel = [AppUIKit labelWithTitle:@"" titleFontSize:18 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        
        
        
        [self.contentView sd_addSubviews:@[self.backImg
                                           ]];
        [self.backImg sd_addSubviews:@[self.bankNameLabel,
                                       self.cardNumLabel,
                                       self.nameLabel]];
        [self autoLayout];
    }
    return self;
}

- (void)autoLayout{
    self.backImg.sd_layout.topSpaceToView(self.contentView, 30)
    .centerXEqualToView(self.contentView)
    .widthIs(302)
    .heightIs(170);
    
    self.bankNameLabel.sd_layout.leftSpaceToView(self.backImg, 50)
    .topSpaceToView(self.backImg, 33)
    .heightIs(15)
    .rightSpaceToView(self.backImg,20);
    
    self.cardNumLabel.sd_layout.leftEqualToView(self.backImg)
    .topSpaceToView(self.bankNameLabel, 35)
    .rightEqualToView(self.backImg)
    .heightIs(15);
    
    self.nameLabel.sd_layout.leftSpaceToView(self.backImg, 25)
    .topSpaceToView(self.cardNumLabel, 35)
    .heightIs(15)
    .rightEqualToView(self.backImg);
    
    
}


- (void)setBankModel:(BankCardModel *)bankModel{
    
    NSString *str = @"(储蓄卡)";
    NSString *bankname = [NSString stringWithFormat:@"%@%@",bankModel.bankName,str];
    self.bankNameLabel.text = bankname;
    self.bankNameLabel.attributedText = [AppCommon getRange:NSMakeRange(bankModel.bankName.length, str.length) labelStr:bankname Font:kFont(12) Color:WhiteColor];
    
    self.cardNumLabel.text = bankModel.bankCardNum;
    self.nameLabel.text = bankModel.name;
    
    
    
    
    
}




@end
