//
//  MyTableViewCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.iconImg];
        [self.contentView addSubview:self.leftLabel];
        
        self.iconImg.sd_layout.leftSpaceToView(self.contentView, 15).centerYEqualToView(self.contentView).heightIs(20).widthIs(20);
        
        self.leftLabel.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.iconImg, 22).widthRatioToView(self.contentView, 0.5).heightIs(20);
        
    }
    return self;
}


- (UILabel *)leftLabel{
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc]init];
        _leftLabel.font = kFont(15);
        _leftLabel.textColor = defaultTextColor;
    }
    return _leftLabel;
}

- (UIImageView *)iconImg{
    if (!_iconImg) {
        _iconImg = [[UIImageView alloc]init];
        _iconImg.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _iconImg;
}



@end
