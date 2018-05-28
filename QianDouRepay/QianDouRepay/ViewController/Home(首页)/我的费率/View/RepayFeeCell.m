//
//  RepayFeeCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "RepayFeeCell.h"

@implementation RepayFeeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.iconImg = [[UIImageView alloc]initWithImage:IMG(@"yinl")];
        [self.contentView addSubview:self.iconImg];
        
        self.nameLabel =[AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
        [self.contentView addSubview:self.nameLabel];
        self.D0Label =[AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
        [self.contentView addSubview:self.D0Label];
        
        self.lineV_1 = [[UIView alloc]init];
        self.lineV_1.backgroundColor = HEXACOLOR(0xdddddd);
        [self.contentView addSubview:self.lineV_1];
        
        self.lineV_10 = [[UIView alloc]init];
        self.lineV_10.backgroundColor = Default_BackgroundGray;
        [self.contentView addSubview:self.lineV_10];
        
        [self layOut];
        
    }
    return self;
}

- (void)layOut{
    self.iconImg.sd_layout.topSpaceToView(self.contentView, 17).leftSpaceToView(self.contentView, 12).widthIs(27).heightIs(17);
    self.nameLabel.sd_layout.centerYEqualToView(self.iconImg).leftSpaceToView(self.iconImg, 11).heightIs(17).rightEqualToView(self.contentView);
    
    self.lineV_1.sd_layout.topSpaceToView(self.iconImg, 17).leftEqualToView(self.iconImg).heightIs(1).rightSpaceToView(self.contentView, 12);
    self.D0Label.sd_layout.topSpaceToView(self.lineV_1, 20).leftEqualToView(self.iconImg).heightIs(15).rightSpaceToView(self.contentView, 12);
    
    self.lineV_10.sd_layout
    .leftEqualToView(self.contentView)
    .heightIs(10).rightEqualToView(self.contentView).bottomEqualToView(self.contentView);
    
    
}

- (void)setMyFeeModel:(MyFeeRateModel *)myFeeModel{
    _myFeeModel = myFeeModel;
    
    self.nameLabel.text = myFeeModel.name;
    
    self.D0Label.text = [NSString stringWithFormat:@"D0交易：%@%%+%@元/笔",myFeeModel.pay_cost,myFeeModel.cash_fee];
    
}


@end
