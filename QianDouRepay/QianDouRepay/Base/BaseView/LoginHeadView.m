//
//  LoginHeadView.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "LoginHeadView.h"

@implementation LoginHeadView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self == [super initWithFrame:frame]) {
        self.backgroundColor = APPMainColor;
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    UIBezierPath *path = [UIBezierPath bezierPath];
    // 添加圆到path
    [path addArcWithCenter:CGPointMake(rect.size.width / 2, rect.size.height * 3.5) radius:rect.size.height * 2.8 startAngle:0.0 endAngle:M_PI*2 clockwise:YES];
    // 设置描边宽度（为了让描边看上去更清楚）
    //    [path setLineWidth:5.0];
    //设置颜色（颜色设置也可以放在最上面，只要在绘制前都可以）
    //    [[UIColor blueColor] setStroke];
    [HEXACOLOR(0xffffff) setFill];
    // 描边和填充
    //    [path stroke];
    [path fill];
}

@end
