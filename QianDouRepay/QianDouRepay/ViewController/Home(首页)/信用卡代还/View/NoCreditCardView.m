//
//  NoCreditCardView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "NoCreditCardView.h"

@implementation NoCreditCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = WhiteColor;
        UIImageView *img = [[UIImageView alloc]initWithImage:IMG(@"zwsj")];
        [self addSubview:img];
        
        UILabel *label = [AppUIKit labelWithTitle:@"没有绑定的信用卡" titleFontSize:15 textColor:defaultTextColor backgroundColor:nil alignment:NSTextAlignmentCenter];
        
        UILabel *labelSub = [AppUIKit labelWithTitle:@"点击右上角添加信用卡" titleFontSize:12 textColor:HEXACOLOR(0x999999) backgroundColor:nil alignment:NSTextAlignmentCenter];
        
        [self addSubview:label];
        [self addSubview:labelSub];
        
        img.sd_layout.topSpaceToView(self, 46).centerXEqualToView(self).widthIs(88).heightIs(88);
        
        label.sd_layout.topSpaceToView(img, 35).centerXEqualToView(self).widthIs(SCREEN_WIDTH).heightIs(15);
        
        labelSub.sd_layout.topSpaceToView(label, 13).centerXEqualToView(self).widthIs(SCREEN_WIDTH).heightIs(15);
        
    }
    
    return self;
}












@end
