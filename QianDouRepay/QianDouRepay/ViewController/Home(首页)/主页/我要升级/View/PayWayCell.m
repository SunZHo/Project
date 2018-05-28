//
//  PayWayCell.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/25.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "PayWayCell.h"

@implementation PayWayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.nameLabel = [AppUIKit labelWithTitle:@"" titleFontSize:15 textColor:defaultTextColor backgroundColor:WhiteColor alignment:0];
        
        self.iconImg = [[UIImageView alloc]init];
        
        self.selectImg = [[UIImageView alloc]init];
        
        
        [self.contentView sd_addSubviews:@[self.iconImg,
                                           self.nameLabel,
                                           self.selectImg
                                           ]];
        [self layout];
        
    }
    return self;
}

- (void)layout{
    self.iconImg.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.contentView, 13).heightIs(25).widthIs(25);
    
    self.nameLabel.sd_layout.centerYEqualToView(self.contentView).leftSpaceToView(self.iconImg, 13).widthIs(100).heightIs(15);
    
    self.selectImg.sd_layout.
    rightSpaceToView(self.contentView, 13).
    centerYEqualToView(self.contentView).
    heightIs(9).
    widthIs(13);
    
}




- (void)setPayModel:(PayWayModel *)payModel{
    self.iconImg.image = IMG(payModel.imageName);
    self.nameLabel.text = payModel.name;
    if (payModel.isSelect) {
        self.selectImg.image = IMG(@"dh");
    }else{
        self.selectImg.image = IMG(@"");
    }
}









@end
