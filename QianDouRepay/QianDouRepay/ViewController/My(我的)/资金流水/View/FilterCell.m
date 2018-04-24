//
//  FilterCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "FilterCell.h"

@implementation FilterCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI{
    self.label = [AppUIKit labelWithTitle:@"" titleFontSize:13 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
    [self.contentView addSubview:self.label];
    
    self.label.sd_layout.centerXEqualToView(self.contentView).centerYEqualToView(self.contentView).widthIs(80).heightIs(28);
    self.label.sd_cornerRadius = @5;
    
}

- (void)setFilterModel:(FilterModel *)filterModel{
    self.label.text = filterModel.text;
    if (filterModel.isChoose) {
        self.label.textColor = HEXACOLOR(0x1e2674);
        self.label.layer.borderColor = APPMainColor.CGColor;
        self.label.layer.borderWidth = 0.5;
        self.label.backgroundColor = WhiteColor;
    }else{
        self.label.backgroundColor = HEXACOLOR(0xf0f0f0);
        self.label.textColor = defaultTextColor;
        self.label.layer.borderColor = [UIColor clearColor].CGColor;
        self.label.layer.borderWidth = 0.5;
    }
}













@end
