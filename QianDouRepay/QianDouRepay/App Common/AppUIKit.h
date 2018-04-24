//
//  AppUIKit.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUIKit : NSObject

/**
 创建label

 @param title -
 @param font -
 @param color -
 @param bgColor -
 @param textAlignment -
 @return -
 */
+ (UILabel *_Nullable)labelWithTitle:(NSString *_Nullable)title
                       titleFontSize:(CGFloat )font
                           textColor:(UIColor *_Nullable)color
                     backgroundColor:(UIColor *_Nullable)bgColor
                           alignment:(NSTextAlignment)textAlignment;

/**
 创建button

 @param btnType -
 @param bgColor -
 @param action -
 @param target -
 @param title -
 @param image -
 @param font -
 @param textColor -
 @return -
 */
+(UIButton *_Nullable)createBtnWithType:(UIButtonType)btnType
                        backgroundColor:(UIColor*_Nullable)bgColor
                                 action:(SEL _Nullable )action
                                 target:(id _Nullable )target
                                  title:(NSString *_Nullable)title
                                  image:(NSString *_Nullable)image
                                   font:(CGFloat)font
                              textColor:(UIColor *_Nullable)textColor;


/**
 倒计时按钮

 @param getCodeBtn -
 */
+ (void)countingDownWithButton:(UIButton *_Nullable)getCodeBtn;




@end
