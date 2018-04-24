//
//  HomeCollectView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "HomeCollectView.h"

@implementation HomeCollectView

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
    NSArray *iconArr = @[@"wdzd",@"wdfr",@"wdfl",@"sqxyk",@"bx",@"dk"];
    NSArray *titleArr = @[@"我的账单",@"我的分润",@"我的费率",@"申请信用卡",@"保险",@"贷款"];
    
    NSInteger columnNum = 3;
    
    CGFloat btnW = self.frame.size.width / 3;
    CGFloat btnH = self.frame.size.height / 2;
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
        
        iv.sd_layout.topSpaceToView(bottomView, 28).centerXEqualToView(bottomView).widthIs(54).heightIs(54);
        
        UILabel *label = [[UILabel alloc]init];
        label.text = titleArr[i];
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = defaultTextColor;
        label.font = kFont(15);
        [bottomView addSubview:label];
        
        label.sd_layout.topSpaceToView(iv, 10).widthIs(btnW).leftEqualToView(bottomView).heightIs(15);
        
        [self addSubview:bottomView];
    }
    
}


- (void)functionClick:(UIButton *)sender{
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectHomeCollentViewAtIndex:)]) {
        [self.delegate didSelectHomeCollentViewAtIndex:sender.tag - 10];
    }
}




@end
