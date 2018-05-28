//
//  RepayPlanListCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "RepayPlanListCell.h"

@implementation RepayPlanListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.planMoneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:0];
        
        self.totalMoneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:0];
        
        self.firstMoneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:0];
        
        self.secondMoneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:0];
        
        self.feeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:0];
        
        [self.contentView sd_addSubviews:@[self.timeLabel,
                                           self.planMoneyLabel,
                                           self.totalMoneyLabel,
                                           self.firstMoneyLabel,
                                           self.secondMoneyLabel,
                                           self.feeLabel]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    
    self.timeLabel.sd_layout.topSpaceToView(self.contentView, 24).leftSpaceToView(self.contentView, 12).rightEqualToView(self.contentView).heightIs(15);
    
    self.planMoneyLabel.sd_layout.leftEqualToView(self.timeLabel).topSpaceToView(self.timeLabel, 20).heightIs(12).widthIs(SCREEN_WIDTH / 2 - 12);
    
    self.totalMoneyLabel.sd_layout.topEqualToView(self.planMoneyLabel).leftSpaceToView(self.planMoneyLabel, 0).heightRatioToView(self.planMoneyLabel, 1).rightEqualToView(self.contentView);
    
    self.firstMoneyLabel.sd_layout.topSpaceToView(self.planMoneyLabel, 19).leftEqualToView(self.planMoneyLabel).heightRatioToView(self.planMoneyLabel, 1).widthRatioToView(self.planMoneyLabel, 1);
    
    self.secondMoneyLabel.sd_layout.topEqualToView(self.firstMoneyLabel).leftEqualToView(self.totalMoneyLabel).heightRatioToView(self.planMoneyLabel, 1).rightEqualToView(self.totalMoneyLabel);
    
    self.feeLabel.sd_layout.topSpaceToView(self.firstMoneyLabel, 19).leftEqualToView(self.timeLabel).heightRatioToView(self.planMoneyLabel, 1).widthRatioToView(self.timeLabel, 1);
    
    
    
}


- (void)setPlanModel:(RepayPlanListModel *)planModel{
    NSString *planMoney = [NSString stringWithFormat:@"￥%@",planModel.money];
    NSString *totalMoney = [NSString stringWithFormat:@"￥%@",planModel.repayment_money];
    
    self.timeLabel.text = planModel.time;
    self.planMoneyLabel.text = [NSString stringWithFormat:@"计划总额：%@",planMoney];
    self.planMoneyLabel.attributedText = [AppCommon getRange:NSMakeRange(@"计划总额：".length, planMoney.length) labelStr:[NSString stringWithFormat:@"计划总额：%@",planMoney] Font:kFont(12) Color:HEXACOLOR(0xf68029)];
    
    self.totalMoneyLabel.text = [NSString stringWithFormat:@"还款总额：%@",totalMoney];
    self.totalMoneyLabel.attributedText = [AppCommon getRange:NSMakeRange(@"还款总额：".length, totalMoney.length) labelStr:[NSString stringWithFormat:@"还款总额：%@",totalMoney] Font:kFont(12) Color:HEXACOLOR(0xf68029)];
    
    self.firstMoneyLabel.text = [NSString stringWithFormat:@"初次消费：￥%@",planModel.first_money];
    
    self.secondMoneyLabel.text = [NSString stringWithFormat:@"二次消费：￥%@",planModel.second_money];
    
    self.feeLabel.text = [NSString stringWithFormat:@"手续费用：￥%@",planModel.fee_money];
    
    
}









@end
