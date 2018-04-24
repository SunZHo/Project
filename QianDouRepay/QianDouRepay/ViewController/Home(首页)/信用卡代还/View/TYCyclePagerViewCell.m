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
    
}

@end
