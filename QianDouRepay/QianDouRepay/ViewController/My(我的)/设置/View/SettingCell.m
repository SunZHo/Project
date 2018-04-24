//
//  SettingCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "SettingCell.h"

@implementation SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.textLabel.textColor = defaultTextColor;
        self.textLabel.font = [UIFont systemFontOfSize:15];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.rightLabel];
        self.rightLabel.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView, 13).widthRatioToView(self.contentView, 0.5).heightIs(15);
    }
    return self;
}

#pragma mark Attributes


- (void)setCellType:(CellType)cellType{
    _cellType = cellType;
    if (cellType == cellTypeNormal) {
        self.accessoryType = UITableViewCellAccessoryNone;
    }else{
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
}


- (UILabel *)rightLabel{
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc]init];
        _rightLabel.font = [UIFont systemFontOfSize:15];
        _rightLabel.textColor = defaultTextColor;
        _rightLabel.textAlignment = NSTextAlignmentRight;
    }
    return _rightLabel;
}

@end
