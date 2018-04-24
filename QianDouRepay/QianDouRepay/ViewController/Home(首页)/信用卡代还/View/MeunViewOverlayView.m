//
//  MeunViewOverlayView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/11.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "MeunViewOverlayView.h"
#import "MeunViewHorizon.h"

@implementation MeunViewOverlayView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    UIView *view = touch.view;
    
    if (view == self) {
        // Close popup menu
        [self.meunView dismissAnimated:YES];
    }
}

@end
