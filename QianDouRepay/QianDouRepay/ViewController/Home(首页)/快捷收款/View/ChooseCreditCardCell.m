//
//  ChooseCreditCardCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChooseCreditCardCell.h"

@implementation ChooseCreditCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backImg = [[UIImageView alloc]initWithImage:IMG(@"kj")];
        self.backImg.userInteractionEnabled = YES;
        
        self.nameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:WhiteColor backgroundColor:nil alignment:0];
        
        self.cardNumLabel = [AppUIKit labelWithTitle:@"" titleFontSize:18 textColor:WhiteColor backgroundColor:nil alignment:0];
        self.unBindBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:WhiteColor action:@selector(unBindClick) target:self title:@"解绑" image:nil font:14 textColor:HEXACOLOR(0x5cb7ff)];
        self.unBindBtn.layer.cornerRadius = 4;
        
        
        [self.contentView sd_addSubviews:@[self.backImg
                                           ]];
        [self.backImg sd_addSubviews:@[self.nameLabel,
                                       self.cardNumLabel,
                                       self.unBindBtn]];
        [self autoLayout];
    }
    return self;
}

- (void)autoLayout{
    self.backImg.sd_layout.topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 12)
    .heightIs(90)
    .rightSpaceToView(self.contentView, 12);
    
    self.nameLabel.sd_layout.leftSpaceToView(self.backImg, 20)
    .topSpaceToView(self.backImg, 19)
    .heightIs(15)
    .rightEqualToView(self.backImg);
    
    self.cardNumLabel.sd_layout.leftEqualToView(self.nameLabel)
    .topSpaceToView(self.nameLabel, 19)
    .rightEqualToView(self.nameLabel)
    .heightIs(15);
    
    self.unBindBtn.sd_layout.topSpaceToView(self.backImg, 10).rightSpaceToView(self.backImg, 10).widthIs(60).heightIs(25);
}


- (void)unBindClick{
    if (self.unBindBlock) {
        self.unBindBlock();
    }
}


- (void)setChooseModel:(ChooseCreditCardModel *)chooseModel{
    self.nameLabel.text = chooseModel.name;
    self.cardNumLabel.text = [self getNewBankNumWitOldBankNum:chooseModel.bank_num];
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
