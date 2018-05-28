//
//  PromotionCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "PromotionCell.h"

@implementation PromotionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentLeft];
        
        self.vipTypeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x999999) backgroundColor:WhiteColor alignment:NSTextAlignmentLeft];
        
        self.phoneLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
        
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x999999) backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
        
        [self.contentView sd_addSubviews:@[self.nameLabel,
                                           self.vipTypeLabel,
                                           self.phoneLabel,
                                           self.timeLabel
                                           ]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    
    
    self.nameLabel.sd_layout.topSpaceToView(self.contentView, 12).leftSpaceToView(self.contentView, 12).widthIs(100).heightIs(15);
    
    self.vipTypeLabel.sd_layout.topSpaceToView(self.nameLabel, 13).leftSpaceToView(self.contentView, 12).widthIs(100).heightIs(12);
    
    self.phoneLabel.sd_layout
    .topEqualToView(self.nameLabel).rightSpaceToView(self.contentView, 14).heightIs(15).widthIs(130);
    
    self.timeLabel.sd_layout
    .topEqualToView(self.vipTypeLabel).leftEqualToView(self.phoneLabel).widthRatioToView(self.phoneLabel, 1).heightIs(12);
    
    
}



- (void)setPromotionModel:(PromotionModel *)promotionModel{
    NSString *isrealName = ([promotionModel.is_confirm integerValue] == 1 ? @"(已实名)" : @"(未实名)");
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@%@",promotionModel.realname,isrealName];
    UIColor *realnameColor = ([promotionModel.is_confirm integerValue] == 1 ? HEXACOLOR(0x5cb7ff) : HEXACOLOR(0xff5c5c));
    
    self.nameLabel.attributedText = [AppCommon getRange:NSMakeRange(promotionModel.realname.length, isrealName.length) labelStr:[NSString stringWithFormat:@"%@%@",promotionModel.realname,isrealName] Font:kFont(12) Color:realnameColor];
    
    self.vipTypeLabel.text = ([promotionModel.is_vip integerValue] == 1 ? @"推广员" : @"普通用户 ");
    if (promotionModel.phone.length == 11) {
        self.phoneLabel.text = [promotionModel.phone stringByReplacingCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    }else{
        self.phoneLabel.text = promotionModel.phone;
    }
    self.timeLabel.text = [NSDate timeStringFromTimestamp:[promotionModel.add_time integerValue]formatter:@"yyyy-MM-dd HH:mm"];
}






@end
