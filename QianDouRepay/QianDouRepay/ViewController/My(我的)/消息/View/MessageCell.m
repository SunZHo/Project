//
//  MessageCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MessageCell.h"

@implementation MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.noteImg = [[UIView alloc]init];
        
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:11 textColor:HEXACOLOR(0x999999) backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
        
        self.titleLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:NSTextAlignmentLeft];
        
        self.contentLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x666666) backgroundColor:WhiteColor alignment:NSTextAlignmentLeft];
        
        
        [self.contentView sd_addSubviews:@[self.noteImg,
                                           self.titleLabel,
                                           self.timeLabel,
                                           self.contentLabel
                                           ]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    
    self.noteImg.sd_layout.topSpaceToView(self.contentView, 23).leftSpaceToView(self.contentView, 12).widthIs(6).heightIs(6);
    self.noteImg.sd_cornerRadiusFromWidthRatio = @(0.5);
    
    self.titleLabel.sd_layout.topSpaceToView(self.contentView, 19).leftSpaceToView(self.noteImg, 8).rightSpaceToView(self.contentView, 130).heightIs(15);
    
    
    self.timeLabel.sd_layout.topSpaceToView(self.contentView, 22).rightSpaceToView(self.contentView,20).leftSpaceToView(self.titleLabel, 1).heightIs(12);
    
    self.contentLabel.sd_layout.leftSpaceToView(self.contentView, 12).rightSpaceToView(self.contentView, 12).topSpaceToView(self.titleLabel, 20).autoHeightRatio(0);
    
    [self setupAutoHeightWithBottomView:self.contentLabel bottomMargin:20];
}


- (void)setMessageModel:(MessageModel *)messageModel{
    self.titleLabel.text = messageModel.title;
    self.timeLabel.text = [NSDate timeStringFromTimestamp:[messageModel.time integerValue]formatter:@"yyyy-MM-dd HH:mm"];
    self.contentLabel.text = messageModel.content;
    if ([messageModel.read integerValue] == 1) {
        self.noteImg.sd_layout.topSpaceToView(self.contentView, 23).leftSpaceToView(self.contentView, 4).widthIs(1).heightIs(6);
        self.noteImg.backgroundColor = [UIColor clearColor];
    }else{
        self.noteImg.sd_layout.topSpaceToView(self.contentView, 23).leftSpaceToView(self.contentView, 12).widthIs(6).heightIs(6);
        self.noteImg.backgroundColor = HEXACOLOR(0xfc3636);
    }
    
}






@end
