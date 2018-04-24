//
//  NoticeCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/18.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "NoticeCell.h"

@implementation NoticeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.titleLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentLeft];
        
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:11 textColor:HEXACOLOR(0x999999) backgroundColor:WhiteColor alignment:NSTextAlignmentLeft];
        
        [self.contentView sd_addSubviews:@[self.titleLabel,
                                           self.timeLabel
                                           ]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    
    
    self.titleLabel.sd_layout.topSpaceToView(self.contentView, 18).leftSpaceToView(self.contentView, 12).rightEqualToView(self.contentView).heightIs(15);
    
    self.timeLabel.sd_layout
    .topSpaceToView(self.titleLabel,13).leftEqualToView(self.titleLabel).widthRatioToView(self.titleLabel, 1).heightIs(11);
    
    
}


- (void)setNoticeModel:(NoticeModel *)noticeModel{
    self.titleLabel.text = noticeModel.title;
    self.timeLabel.text = noticeModel.time;
}


@end
