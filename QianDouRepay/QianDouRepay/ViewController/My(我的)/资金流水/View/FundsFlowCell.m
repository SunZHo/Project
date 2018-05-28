//
//  FundsFlowCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "FundsFlowCell.h"

@implementation FundsFlowCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x999999) backgroundColor:WhiteColor alignment:0];
        
        self.typeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentLeft];
        
        self.moneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
        
        
        [self.contentView sd_addSubviews:@[self.typeLabel,
                                           self.timeLabel,
                                           self.moneyLabel
                                           ]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    
    
    self.typeLabel.sd_layout.topSpaceToView(self.contentView, 12).leftSpaceToView(self.contentView, 12).rightSpaceToView(self.contentView, 110).heightIs(15);
    
    
    self.timeLabel.sd_layout.topSpaceToView(self.typeLabel, 12).leftEqualToView(self.typeLabel).widthRatioToView(self.typeLabel, 1).heightIs(13);
    
    self.moneyLabel.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView, 12).heightIs(16).widthIs(100);
    
}

- (void)setFundsModel:(FundsFlowModel *)fundsModel{
    self.moneyLabel.text = fundsModel.money;
    self.timeLabel.text = [NSDate timeStringFromTimestamp:[fundsModel.time integerValue] formatter:@"yyyy-MM-dd HH:mm"];
    // 推广奖励-1  分润流水-2  提现审核中-3  提现成功-4  提现失败-5
    if ([fundsModel.type integerValue] == 1) {
        self.typeLabel.text = @"推广奖励";
    }else if ([fundsModel.type integerValue] == 2){
        self.typeLabel.text = @"分润流水";
    }else if ([fundsModel.type integerValue] == 3){
        self.typeLabel.text = @"提现审核中";
    }else if ([fundsModel.type integerValue] == 4){
        self.typeLabel.text = @"提现成功";
    }else if ([fundsModel.type integerValue] == 5){
        self.typeLabel.text = @"提现失败";
    }
    
}









@end
