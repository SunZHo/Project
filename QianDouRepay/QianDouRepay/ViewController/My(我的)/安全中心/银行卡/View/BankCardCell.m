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
        self.backImg.userInteractionEnabled = YES;
        
        self.bankNameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentRight];
        
        self.nameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:WhiteColor backgroundColor:nil alignment:0];
        
        self.cardNumLabel = [AppUIKit labelWithTitle:@"" titleFontSize:18 textColor:WhiteColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        
        self.unBindBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:HEXACOLOR(0xfccb36) action:@selector(unBindClick) target:self title:@"解绑" image:nil font:14 textColor:HEXACOLOR(0x1e2674)];
        self.unBindBtn.layer.cornerRadius = 4;
        
        
        [self.contentView sd_addSubviews:@[self.backImg
                                           ]];
        [self.backImg sd_addSubviews:@[self.bankNameLabel,
                                       self.cardNumLabel,
                                       self.nameLabel,
                                       self.unBindBtn]];
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
    
    self.unBindBtn.sd_layout.leftSpaceToView(self.backImg, 20)
    .topSpaceToView(self.cardNumLabel, 30)
    .heightIs(25)
    .widthIs(60);
    
}


- (void)setBankModel:(BankCardModel *)bankModel{
    
    NSString *str = @"(储蓄卡)";
    NSString *bankname = [NSString stringWithFormat:@"%@%@",bankModel.bank_name,str];
    self.bankNameLabel.text = bankname;
    self.bankNameLabel.attributedText = [AppCommon getRange:NSMakeRange(bankModel.bank_name.length, str.length) labelStr:bankname Font:kFont(12) Color:WhiteColor];
    self.cardNumLabel.text = [self getNewBankNumWitOldBankNum:bankModel.bank_num];
//    if (bankModel.bank_num.length == 19) {
//        self.cardNumLabel.text = [self getNewBankNumWitOldBankNum:bankModel.bank_num];
//    }else{
//        self.cardNumLabel.text = bankModel.bank_num;
//    }
    self.nameLabel.text = bankModel.name;
    if (bankModel.isUnbind) {
        self.unBindBtn.hidden = NO;
        self.nameLabel.hidden = YES;
    }else{
        self.unBindBtn.hidden = YES;
        self.nameLabel.hidden = NO;
    }
    
}

- (void)unBindClick{
    if (self.unBindBlock) {
        self.unBindBlock();
    }
}

- (NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum
{
    NSMutableString *mutableStr;
    if (bankNum.length) {
        mutableStr = [NSMutableString stringWithString:bankNum];
        for (int i = 0 ; i < mutableStr.length; i ++) {
            if (i>3&&i<mutableStr.length - 3) {
                [mutableStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
        }
        NSString *text = mutableStr;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        return newString;
    }
    return bankNum;
    
}



@end
