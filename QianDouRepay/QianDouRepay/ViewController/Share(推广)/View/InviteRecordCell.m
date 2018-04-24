//
//  InviteRecordCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "InviteRecordCell.h"

@implementation InviteRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x1e1e1e) backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
        
        self.phoneLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x1e1e1e) backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
        
        self.stateLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x1e1e1e) backgroundColor:WhiteColor alignment:NSTextAlignmentCenter];
        
        
        [self.contentView sd_addSubviews:@[self.phoneLabel,
                                           self.stateLabel,
                                           self.timeLabel
                                           ]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    
    
    self.phoneLabel.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, 0).widthIs(SCREEN_WIDTH/ 3).heightIs(15);
    
    
    self.stateLabel.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.phoneLabel, 0).widthRatioToView(self.phoneLabel, 1).heightIs(15);
    
    self.timeLabel.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.stateLabel, 0).widthRatioToView(self.phoneLabel, 1).heightIs(15);
    
}

- (void)setInviteModel:(InviteRecordModel *)inviteModel{
    self.phoneLabel.text = inviteModel.phone;
    self.stateLabel.text = inviteModel.state;
    self.timeLabel.text = inviteModel.time;
}








@end
