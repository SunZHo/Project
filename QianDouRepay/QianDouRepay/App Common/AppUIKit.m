//
//  AppUIKit.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AppUIKit.h"

@implementation AppUIKit

+ (UILabel *)labelWithTitle:(NSString *)title titleFontSize:(CGFloat )font textColor:(UIColor *)color backgroundColor:(UIColor *)bgColor alignment:(NSTextAlignment)textAlignment{
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    label.font = kFont(font);
    label.textColor = color;
    if (bgColor) {
        label.backgroundColor = bgColor;
    }
    label.textAlignment = textAlignment;
    return label;
}


+(UIButton *_Nullable)createBtnWithType:(UIButtonType)btnType
                        backgroundColor:(UIColor*_Nullable)bgColor
                                 action:(SEL _Nullable )action
                                 target:(id _Nullable )target
                                  title:(NSString *_Nullable)title
                                  image:(NSString *_Nullable)image
                                   font:(CGFloat)font
                              textColor:(UIColor *_Nullable)textColor{
    UIButton *btn = [UIButton buttonWithType:btnType];
    btn.titleLabel.font = kFont(font);
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:title forState:(UIControlStateNormal)];
    [btn setTitleColor:textColor forState:UIControlStateNormal];
    if (image) {
        [btn setImage:[UIImage imageNamed:image] forState:(UIControlStateNormal)];
    }
    [btn setBackgroundColor:bgColor];
    return btn;
}

//倒计时
+ (void)countingDownWithButton:(UIButton *)getCodeBtn{
    __block int timeout=59;
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                [getCodeBtn setTitle:@"重新发送" forState:UIControlStateNormal];
                getCodeBtn.userInteractionEnabled = YES;
            });
        }else{
            // int minutes = timeout / 60;
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [getCodeBtn setTitle:[NSString stringWithFormat:@"%@秒",strTime] forState:UIControlStateNormal];
                getCodeBtn.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
}




@end
