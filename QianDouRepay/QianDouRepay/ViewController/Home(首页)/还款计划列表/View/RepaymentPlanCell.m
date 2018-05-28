//
//  RepaymentPlanCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "RepaymentPlanCell.h"

@implementation RepaymentPlanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.typeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
        
        self.moneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
        
        self.rowImg = [[UIImageView alloc]initWithImage:IMG(@"youjt")];

     
        [self.contentView sd_addSubviews:@[self.timeLabel,
                                           self.typeLabel,
                                           self.moneyLabel,
                                           self.rowImg
                                           ]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    
    self.timeLabel.sd_layout.leftSpaceToView(self.contentView, 12).widthIs(SCREEN_WIDTH /3 - 12).heightIs(30).centerYEqualToView(self.contentView);
    
    self.typeLabel.sd_layout.
    centerYEqualToView(self.contentView).centerXEqualToView(self.contentView).heightIs(30).widthRatioToView(self.timeLabel, 1);
    
    self.moneyLabel.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView, 30).heightRatioToView(self.typeLabel, 1).widthRatioToView(self.timeLabel, 1);
    
    self.rowImg.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView, 12).heightIs(9).widthIs(5);
}


- (void)setRepaymentModel:(RepaymentPlanModel *)repaymentModel{
    _repaymentModel = repaymentModel;
    self.timeLabel.text = [NSDate timeStringFromTimestamp:[repaymentModel.add_time integerValue] formatter:@"yyyy-MM-dd"];
    self.typeLabel.text = @"还款";
    self.moneyLabel.text = [NSString stringWithFormat:@"￥%@",repaymentModel.money];
    
    
}



@end
