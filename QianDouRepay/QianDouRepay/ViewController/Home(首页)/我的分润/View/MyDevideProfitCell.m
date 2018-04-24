//
//  MyDevideProfitCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MyDevideProfitCell.h"

@implementation MyDevideProfitCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.phoneLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x999999) backgroundColor:WhiteColor alignment:0];
        
        self.moneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
        
        self.divideLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
        [self.contentView sd_addSubviews:@[self.phoneLabel,
                                           self.timeLabel,
                                           self.moneyLabel,
                                           self.divideLabel
                                           ]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    self.phoneLabel.sd_layout.topSpaceToView(self.contentView, 13).leftSpaceToView(self.contentView, 12).heightIs(15).widthIs(SCREEN_WIDTH/3);
    
    self.timeLabel.sd_layout.topSpaceToView(self.phoneLabel, 14).leftEqualToView(self.phoneLabel).widthRatioToView(self.phoneLabel, 1).heightIs(12);
    
    self.moneyLabel.sd_layout.
    centerYEqualToView(self.contentView).
    centerXEqualToView(self.contentView).
    heightRatioToView(self.phoneLabel, 1).
    widthIs(SCREEN_WIDTH / 3 - 12);
    
    self.divideLabel.sd_layout
    .centerYEqualToView(self.contentView)
    .rightSpaceToView(self.contentView, 12)
    .heightRatioToView(self.phoneLabel, 1).widthRatioToView(self.moneyLabel, 1);
}


- (void)setDividedModel:(MyDivideProfitModel *)dividedModel{
    self.phoneLabel.text = dividedModel.phone;
    self.timeLabel.text = dividedModel.time;
    self.moneyLabel.text = dividedModel.money;
    self.divideLabel.text = dividedModel.divide;
}


@end
