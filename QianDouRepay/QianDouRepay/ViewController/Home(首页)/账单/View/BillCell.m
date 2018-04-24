//
//  BillCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BillCell.h"

@implementation BillCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.timeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:12 textColor:HEXACOLOR(0x999999) backgroundColor:WhiteColor alignment:0];
        
        self.typeLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:HEXACOLOR(0x999999) backgroundColor:WhiteColor alignment:NSTextAlignmentRight];
        
        self.moneyLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        
        [self.contentView sd_addSubviews:@[self.moneyLabel,
                                           self.timeLabel,
                                           self.typeLabel
                                           ]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    
    
    self.moneyLabel.sd_layout.topSpaceToView(self.contentView, 12).leftSpaceToView(self.contentView, 12).rightSpaceToView(self.contentView, 70).heightIs(15);
    
    
    self.timeLabel.sd_layout.topSpaceToView(self.moneyLabel, 12).leftEqualToView(self.moneyLabel).widthRatioToView(self.moneyLabel, 1).heightIs(13);
    
    self.typeLabel.sd_layout.centerYEqualToView(self.contentView).rightSpaceToView(self.contentView, 12).heightIs(16).widthIs(60);
    
}



- (void)setBillmodel:(BillModel *)billmodel{
    self.moneyLabel.text = billmodel.money;
    self.timeLabel.text = billmodel.time;
    self.typeLabel.text = billmodel.type;
    if ([billmodel.status integerValue] == 1) {
        self.typeLabel.textColor = HEXACOLOR(0x5cb7ff);
    }else{
        self.typeLabel.textColor = HEXACOLOR(0xff5c5c);
    }
    
}




@end
