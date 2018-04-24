//
//  ChooseCreditCardCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "ChooseCreditCardCell.h"

@implementation ChooseCreditCardCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.backImg = [[UIImageView alloc]initWithImage:IMG(@"kj")];
        
        self.nameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:WhiteColor backgroundColor:nil alignment:0];
        
        self.cardNumLabel = [AppUIKit labelWithTitle:@"" titleFontSize:18 textColor:WhiteColor backgroundColor:nil alignment:0];
        
        
        
        [self.contentView sd_addSubviews:@[self.backImg
                                           ]];
        [self.backImg sd_addSubviews:@[self.nameLabel,
                                       self.cardNumLabel]];
        [self autoLayout];
    }
    return self;
}

- (void)autoLayout{
    self.backImg.sd_layout.topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 12)
    .heightIs(90)
    .rightSpaceToView(self.contentView, 12);
    
    self.nameLabel.sd_layout.leftSpaceToView(self.backImg, 20)
    .topSpaceToView(self.backImg, 19)
    .heightIs(15)
    .rightEqualToView(self.backImg);
    
    self.cardNumLabel.sd_layout.leftEqualToView(self.nameLabel)
    .topSpaceToView(self.nameLabel, 19)
    .rightEqualToView(self.nameLabel)
    .heightIs(15);
}


- (void)setChooseModel:(ChooseCreditCardModel *)chooseModel{
    self.nameLabel.text = chooseModel.bankName;
    self.cardNumLabel.text = chooseModel.cardNum;
    
}


@end
