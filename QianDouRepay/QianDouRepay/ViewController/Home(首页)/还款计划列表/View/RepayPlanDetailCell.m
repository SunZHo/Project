//
//  RepayPlanDetailCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/20.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "RepayPlanDetailCell.h"

@implementation RepayPlanDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        for (UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        self.titleBtn = [AppUIKit createBtnWithType:UIButtonTypeCustom backgroundColor:nil action:@selector(clickOpen) target:self title:@"" image:nil font:15 textColor:defaultTextColor];
        self.titleBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        self.lineV_1 = [[UIView alloc]init];
        self.lineV_1.backgroundColor = HEXACOLOR(0xdddddd);
        
        self.rowImg = [[UIImageView alloc]init];
        
        self.lineV_10 = [[UIView alloc]init];
        self.lineV_10.backgroundColor = Default_BackgroundGray;
        
        [self.titleBtn addSubview:self.rowImg];
        [self.contentView addSubview:self.titleBtn];
        [self.contentView addSubview:self.lineV_1];
        [self.contentView addSubview:self.lineV_10];
        
    }
    return self;
}



- (void)setRepayPlanModel:(RepayPlanDetailModel *)repayPlanModel{
    
    [self.titleBtn setTitle:repayPlanModel.title forState:UIControlStateNormal];
    self.titleBtn.sd_layout.topSpaceToView(self.contentView, 0).leftSpaceToView(self.contentView, 12).rightSpaceToView(self.contentView, 0).heightIs(50);
    
    if (repayPlanModel.isOpening) {
        self.lineV_1.sd_layout.topSpaceToView(self.titleBtn, 1).leftSpaceToView(self.contentView, 12).rightSpaceToView(self.contentView, 12).heightIs(1);
        self.rowImg.image = IMG(@"sjiant");
        self.rowImg.sd_layout.centerYEqualToView(self.titleBtn).rightSpaceToView(self.titleBtn, 13).heightIs(5).widthIs(9);
        
        RepayPlanDetailSubModel *model0 = repayPlanModel.subArray[0];
        UILabel *moneyLabel = [AppUIKit labelWithTitle:[NSString stringWithFormat:@"￥%@",model0.subValue] titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        moneyLabel.attributedText = [AppCommon getRange:NSMakeRange(@"￥".length, model0.subValue.length) labelStr:[NSString stringWithFormat:@"￥%@",model0.subValue] Font:kFont(24) Color:defaultTextColor];
        
        UILabel *moneyTitleLabel = [AppUIKit labelWithTitle:model0.subTitle titleFontSize:12 textColor:HEXACOLOR(0x999999) backgroundColor:nil alignment:NSTextAlignmentCenter];
        
        UIView *line = [[UIView alloc]init];
        line.backgroundColor = WhiteColor;
        
        [self.contentView addSubview:moneyLabel];
        [self.contentView addSubview:moneyTitleLabel];
        [self.contentView addSubview:line];
        
        
        
        moneyLabel.sd_layout.topSpaceToView(self.lineV_1, 30).leftEqualToView(self.contentView).rightEqualToView(self.contentView).heightIs(18);
        moneyTitleLabel.sd_layout.topSpaceToView(moneyLabel, 15).leftEqualToView(self.contentView).rightEqualToView(self.contentView).heightIs(12);
        line.sd_layout.topSpaceToView(moneyTitleLabel, 30).leftSpaceToView(self.contentView, 12).rightSpaceToView(self.contentView, 12).heightIs(1);
        
        UIView *dashline = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH - 24, 1)];
        dashline.backgroundColor = HEXACOLOR(0xdddddd);
        [line addSubview:dashline];
        [AppCommon drawDashLine:dashline lineLength:2 lineSpacing:1 lineColor:WhiteColor];
        
        for (int i = 1; i < repayPlanModel.subArray.count; i ++) {
            RepayPlanDetailSubModel *model = repayPlanModel.subArray[i];
            UILabel *labelL = [AppUIKit labelWithTitle:model.subTitle titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:0];
            UILabel *labelR = [AppUIKit labelWithTitle:model.subValue titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:nil alignment:NSTextAlignmentRight];
            [self.contentView addSubview:labelL];
            [self.contentView addSubview:labelR];
            
            labelL.sd_layout.topSpaceToView(line, i * 30 - 10).leftSpaceToView(self.contentView, 12).heightIs(12).widthIs(SCREEN_WIDTH / 2 - 12);
            labelR.sd_layout.topEqualToView(labelL).rightSpaceToView(self.contentView, 12).heightRatioToView(labelL, 1).widthRatioToView(labelL, 1);
        }
        
        self.lineV_10.sd_layout.topSpaceToView(self.titleBtn, repayPlanModel.subArray.count * 30 + 100).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(10);
        
        self.lineV_1.hidden = NO;
        
        [self setupAutoHeightWithBottomView:self.lineV_10 bottomMargin:0];
    }
    else{
        self.lineV_1.hidden = YES;
        self.rowImg.image = IMG(@"youjt");
        self.rowImg.sd_layout.centerYEqualToView(self.titleBtn).rightSpaceToView(self.titleBtn, 13).heightIs(9).widthIs(5);
        self.lineV_10.sd_layout.topSpaceToView(self.titleBtn, 0).leftSpaceToView(self.contentView, 0).rightSpaceToView(self.contentView, 0).heightIs(10);
        [self setupAutoHeightWithBottomView:self.lineV_10 bottomMargin:0];
    }
    
    
}






- (void)clickOpen{
    if (self.openClickedBlock) {
        self.openClickedBlock();
    }
}



@end
