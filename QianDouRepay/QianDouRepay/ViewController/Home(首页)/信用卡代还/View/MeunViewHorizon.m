//
//  MeunViewHorizon.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/11.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MeunViewHorizon.h"
#import "MeunViewOverlayView.h"

@interface MeunViewHorizon()

@property (nonatomic, strong) MeunViewOverlayView *overlayView;

@end

@implementation MeunViewHorizon

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImageView *img = [[UIImageView alloc]initWithImage:IMG(@"bjin")];
        [self addSubview:img];
        
        [self layOutSubV];
        
    }
    
    return self;
}

- (void)layOutSubV{
    NSArray *iconArr = @[@"xgzl",@"sc",@"zxjh"];
    NSArray *titleArr = @[@"修改资料",@"删除信用卡",@"已执行计划"];
    
    NSInteger columnNum = 3;
    
    CGFloat btnW = self.frame.size.width / 3;
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
        
        iv.sd_layout.topSpaceToView(bottomView, 20).centerXEqualToView(bottomView).widthIs(20).heightIs(18);
        
        UILabel *label = [[UILabel alloc]init];
        label.text = titleArr[i];
        label.textColor = WhiteColor;
        label.font = kFont(14);
        label.textAlignment = NSTextAlignmentCenter;
        [bottomView addSubview:label];
        
        label.sd_layout.topSpaceToView(iv, 8).rightEqualToView(bottomView).leftEqualToView(bottomView).heightIs(12);
        
        if (i < 2) {
            UIView *linv = [[UIView alloc]init];
            linv.backgroundColor = WhiteColor;
            [bottomView addSubview:linv];
            linv.sd_layout.centerYEqualToView(bottomView).rightSpaceToView(bottomView, 0).heightIs(19).widthIs(1);
        }
        
        
        [self addSubview:bottomView];
    }
    
    
    
    
}


- (void)functionClick:(UIButton *)sender{
    NSInteger tag = sender.tag - 10;
    if (self.delegate && [self.delegate respondsToSelector:@selector(meunViewDidSelectedIndex:)]) {
        [self.delegate meunViewDidSelectedIndex:tag];
        [self dismissAnimated:YES];
    }
}








- (void)showInView:(UIView *)view targetRect:(CGRect)targetRect animated:(BOOL)animated{
    self.frame=CGRectMake((SCREEN_WIDTH - self.frame.size.width) / 2, CGRectGetMaxY(targetRect), self.frame.size.width, self.frame.size.height);
    // Create overlay view
    self.overlayView = ({
        MeunViewOverlayView *overlayView = [[MeunViewOverlayView alloc] initWithFrame:view.bounds];
        overlayView.meunView = self;
        
        overlayView;
    });
    
    [view addSubview:self.overlayView];
    if (animated) {
        self.alpha = 0;
        [self.overlayView addSubview:self];
        
        [UIView animateWithDuration:0.2 animations:^(void) {
            self.alpha = 1.0;
        } completion:^(BOOL finished) {
            
        }];
    } else {
        [self.overlayView addSubview:self];
        
    }
    
}


- (void)dismissAnimated:(BOOL)animated
{
    if (animated) {
        [UIView animateWithDuration:0.2 animations:^{
            self.alpha = 0;
        } completion:^(BOOL finished) {
            [self removeFromSuperview];
            [self.overlayView removeFromSuperview];
        }];
    } else {
        [self removeFromSuperview];
        [self.overlayView removeFromSuperview];
    }
}

@end
