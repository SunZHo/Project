//
//  CalendarCell.m
//  Jshare
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "CalendarCell.h"

@implementation CalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [self insertSubview:self.imageView atIndex:0];
    self.imageView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [self.imageView setContentMode:UIViewContentModeCenter];
}

@end
