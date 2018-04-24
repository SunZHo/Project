//
//  HomeAboveView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "HomeAboveView.h"

@implementation HomeAboveView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = HEXACOLOR(0xffffff);
        self.layer.cornerRadius = 5;
        self.clipsToBounds = YES;
        [self layOutSubV];
    }
    return self;
}


- (void)layOutSubV{
    NSArray *iconArr = @[@"xyhk",@"kjdk"];
    NSArray *titleArr = @[@"信用卡代还",@"快捷收款"];
    NSArray *subtitleArr = @[@"低息高额全智能",@"收款快速有便捷"];
    
    NSInteger columnNum = 2;
    
    CGFloat btnW = self.frame.size.width / 2;
    CGFloat btnH = self.frame.size.height;
    CGFloat margin = (self.frame.size.width - columnNum * btnW) / (columnNum + 1);
    
    for (int i = 0; i < iconArr.count; i ++) {
        int row = i/columnNum;//行号
        //     1/3=0,  2/3=0,  3/3=1;
        int loc = i%columnNum;//列号
        CGFloat btnX = margin + (margin + btnW) * loc;
        CGFloat btnY = margin + (margin + btnH) * row;
        UIButton *bottomView = [[UIButton alloc]initWithFrame:CGRectMake(btnX, btnY, btnW, btnH)];
        bottomView.tag = 10 + i;
        [bottomView addTarget:self action:@selector(functionClick:) forControlEvents:UIControlEventTouchUpInside];
        UIImageView *iv = [[UIImageView alloc]init];
        iv.image = IMG(iconArr[i]);
        [bottomView addSubview:iv];
        
        iv.sd_layout.leftSpaceToView(bottomView, 15).centerYEqualToView(bottomView).widthIs(32).heightIs(25);
        
        UILabel *label = [[UILabel alloc]init];
        label.text = titleArr[i];
        label.textColor = defaultTextColor;
        label.font = kFont(14);
        [bottomView addSubview:label];
        
        label.sd_layout.topSpaceToView(bottomView, 18).rightEqualToView(bottomView).leftSpaceToView(iv, 10).heightIs(15);
        
        UILabel *subLabel = [[UILabel alloc]init];
        subLabel.text = subtitleArr[i];
        subLabel.textColor = HEXACOLOR(0x999999);
        subLabel.font = kFont(12);
        [bottomView addSubview:subLabel];
        
        subLabel.sd_layout.topSpaceToView(label, 10).rightEqualToView(label).leftEqualToView(label).heightIs(12);
        
        [self addSubview:bottomView];
    }
    
    UIView *linv = [[UIView alloc]init];
    linv.backgroundColor = Default_BackgroundGray;
    [self addSubview:linv];
    
    linv.sd_layout.centerYEqualToView(self).centerXEqualToView(self).heightIs(19).widthIs(1);
    
    
}


- (void)functionClick:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSeleHomeAboveViewAtIndex:)]) {
        [self.delegate didSeleHomeAboveViewAtIndex:sender.tag - 10];
    }
}


@end
