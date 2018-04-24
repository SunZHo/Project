//
//  ReciveFeeCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ReciveFeeCell.h"

@implementation ReciveFeeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        self.iconImg = [[UIImageView alloc]initWithImage:IMG(@"yinl")];

        
        self.nameLabel =[AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:0];
        
        
        self.lineV_1 = [[UIView alloc]init];
        self.lineV_1.backgroundColor = HEXACOLOR(0xdddddd);
        
        
        self.lineV_10 = [[UIView alloc]init];
        self.lineV_10.backgroundColor = Default_BackgroundGray;
        
        
    }
    return self;
}

- (void)layOut{
    self.iconImg.sd_layout.topSpaceToView(self.contentView, 17).leftSpaceToView(self.contentView, 12).widthIs(27).heightIs(17);
    self.nameLabel.sd_layout.centerYEqualToView(self.iconImg).leftSpaceToView(self.iconImg, 11).heightIs(17).rightEqualToView(self.contentView);
    
    self.lineV_1.sd_layout.topSpaceToView(self.iconImg, 17).leftEqualToView(self.iconImg).heightIs(1).rightSpaceToView(self.contentView, 12);
    
    self.lineV_10.sd_layout
    .leftEqualToView(self.contentView)
    .heightIs(10).rightEqualToView(self.contentView).bottomEqualToView(self.contentView);
    
    
}


- (void)setMyFeeModel:(MyFeeRateModel *)myFeeModel{
    _myFeeModel = myFeeModel;
    for (UIView *view in self.contentView.subviews) {
        [view removeFromSuperview];
    }
    
    [self.contentView addSubview:self.iconImg];
    [self.contentView addSubview:self.nameLabel];
    [self.contentView addSubview:self.lineV_1];
    [self.contentView addSubview:self.lineV_10];
    [self layOut];
    
    self.nameLabel.text = myFeeModel.pathName;
    
    NSString *D0 , *T_1 , *money , *topMoney;
    D0 = ([myFeeModel.D0 isEqualToString:@""] || myFeeModel.D0 == nil ? @"--" : myFeeModel.D0);
    T_1 = ([myFeeModel.T_1 isEqualToString:@""] || myFeeModel.T_1 == nil ? @"--" : myFeeModel.T_1);
    money = ([myFeeModel.money isEqualToString:@""] || myFeeModel.money == nil ? @"--" : myFeeModel.money);
    topMoney = ([myFeeModel.topMoney isEqualToString:@""] || myFeeModel.topMoney == nil ? @"--" : myFeeModel.topMoney);
    
    NSArray *nameArr = @[@"D0交易",@"T+1交易",@"额度",@"封顶值"];
    NSArray *valueArray = @[D0,T_1,money,topMoney];
    
    for (int i = 0; i < nameArr.count; i ++) {
        UILabel *namelabel = [AppUIKit labelWithTitle:nameArr[i] titleFontSize:12 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:namelabel];
        
        UILabel *valuelabel = [AppUIKit labelWithTitle:valueArray[i] titleFontSize:12 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        [self.contentView addSubview:valuelabel];
        
        namelabel.sd_layout.topSpaceToView(self.lineV_1, 22).leftSpaceToView(self.contentView, i * SCREEN_WIDTH / 4).widthIs(SCREEN_WIDTH / 4).heightIs(12);
        
        valuelabel.sd_layout.topSpaceToView(namelabel, 12).leftEqualToView(namelabel).widthRatioToView(namelabel, 1).heightRatioToView(namelabel, 1);
    }
    
    
}


@end
