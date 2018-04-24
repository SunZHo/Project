//
//  inviteExplanCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "inviteExplanCell.h"

@implementation inviteExplanCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.pointImg = [[UIImageView alloc]init];
        self.pointImg.backgroundColor = HEXACOLOR(0xf8ab00);
        
        
        self.explanLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        [self.contentView addSubview:self.pointImg];
        [self.contentView addSubview:self.explanLabel];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    
    self.pointImg.sd_layout.topSpaceToView(self.contentView, 5)
    .leftSpaceToView(self.contentView, 0)
    .widthIs(5)
    .heightIs(5);
    self.pointImg.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    self.explanLabel.sd_layout.topSpaceToView(self.contentView, 2)
    .leftSpaceToView(self.contentView, 15)
    .rightSpaceToView(self.contentView, 2)
    .autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.explanLabel bottomMargin:kScaleWidth(15)];
    
}

@end
