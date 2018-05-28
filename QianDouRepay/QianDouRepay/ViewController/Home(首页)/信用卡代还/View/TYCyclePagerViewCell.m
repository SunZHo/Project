//
//  TYCyclePagerViewCell.m
//  TYCyclePagerViewDemo
//
//  Created by tany on 2017/6/14.
//  Copyright © 2017年 tany. All rights reserved.
//

#import "TYCyclePagerViewCell.h"

@interface TYCyclePagerViewCell ()

@end

@implementation TYCyclePagerViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}




- (void)setupUI {
    self.backImg = [[UIImageView alloc]initWithImage:IMG(@"xykbj")];
    self.backImg.frame = self.bounds;
    [self.contentView addSubview:self.backImg];
    
    self.bankLabel = [AppUIKit labelWithTitle:@"中国建设银行" titleFontSize:15 textColor:WhiteColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    [self.contentView addSubview:self.bankLabel];
    
    self.cardNumLabel = [AppUIKit labelWithTitle:@"6240  ****  ****  ****  123" titleFontSize:18 textColor:WhiteColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.cardNumLabel];
    
    self.timeLabel = [AppUIKit labelWithTitle:@"01/23" titleFontSize:12 textColor:WhiteColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentLeft];
    [self.contentView addSubview:self.timeLabel];
    
    self.nameLabel = [AppUIKit labelWithTitle:@"刘晓晓" titleFontSize:12 textColor:WhiteColor backgroundColor:[UIColor clearColor] alignment:NSTextAlignmentRight];
    [self.contentView addSubview:self.nameLabel];
    
//    self.backImg.sd_layout
//    .topEqualToView(self.contentView)
//    .leftEqualToView(self.contentView)
//    .rightEqualToView(self.contentView)
//    .rightEqualToView(self.contentView);
    
    self.bankLabel.sd_layout
    .topSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .heightIs(15)
    .leftSpaceToView(self.contentView, 50);
    
    self.cardNumLabel.sd_layout
    .leftEqualToView(self.contentView)
    .rightEqualToView(self.contentView)
    .centerYEqualToView(self.contentView)
    .heightIs(18);
    
    self.timeLabel.sd_layout
    .leftSpaceToView(self.contentView, 25)
    .widthRatioToView(self.contentView, 0.4)
    .bottomSpaceToView(self.contentView, 25)
    .heightIs(13);
    
    self.nameLabel.sd_layout
    .widthRatioToView(self.timeLabel,1)
    .rightSpaceToView(self.contentView,20)
    .bottomEqualToView(self.timeLabel)
    .heightIs(13);
    
    
    
}



-(void)setCardModel:(CreditCardModel *)cardModel{
    self.bankLabel.text = cardModel.bank_name;
    self.cardNumLabel.text = [self getNewBankNumWitOldBankNum:cardModel.bank_num];
    self.nameLabel.text = cardModel.realname;
    NSMutableString *str = [NSMutableString stringWithString:cardModel.validity];
    [str insertString:@"/" atIndex:2];
    NSArray *arr = [str componentsSeparatedByString:@"/"];
    NSString *time = [NSString stringWithFormat:@"%@/%@",arr[1],arr[0]];
    self.timeLabel.text = time;
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
