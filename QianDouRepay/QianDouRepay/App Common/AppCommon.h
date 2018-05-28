//
//  AppCommon.h
//  ZhangqiuForum
//
//  Created by 帝云科技 on 2018/1/23.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCommon : NSObject

/**
 返回字符宽度
 
 @param font 字体大小
 @param string 字符
 @return 宽度
 */
+ (CGFloat) getStringWidthWithFont:(NSInteger)font andString:(NSString *)string;


/**
 返回字符高度

 @param font 字体大小
 @param width 宽度
 @param string 字符
 @return 高度
 */
+ (CGFloat) getStringHeightWithFont:(NSInteger)font width:(CGFloat)width andString:(NSString *)string;

/**
 MD5加密
 
 @param input 需要加密的字符串
 @return 加密后的字符串
 */
+ (NSString *) md5:(NSString *)input;

/**
 * 时间格式化
 */
//createTimeString为后台传过来的13位纯数字时间戳
+ (NSString *)updateTimeForRow:(NSString *)createTimeString;

/**
 //去除所有HTML标签
 
 @param string -
 @return -
 */
+ (NSString *)offHTMLwithString:(NSString *)string;
+ (NSString *)offHTMLLeftImgwithString:(NSString *)string;
+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;
/**
 得到父级控制器
 
 @param view View
 @return 控制器
 */
+(UIViewController *)getViewController:(UIView *)view;

/**
 *  截取字符串 改变颜色
 *
 *  @param strRange 截取范围
 *  @param str      截取的字符串
 *  @param font     字体大小
 *
 *  @return 返回截取后改变颜色的字符串
 */
+ (NSMutableAttributedString *)getRange:(NSRange)strRange labelStr:(NSString *)str Font:(UIFont*)font Color:(UIColor *)strColor;


/**
 获取当前屏幕显示的viewcontroller
 
 @return -
 */
+ (UIViewController *)getCurrentVC;


/**
 绘制虚线
 
 @param lineView 需要绘制成虚线的view
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor;


/**
 判断是不是银行卡

 @param cardNumber -
 @return -
 */
+ (BOOL)isBankCard:(NSString *)cardNumber;

/** 判断是否是身份证号码 */
+ (BOOL)isIDCard:(NSString *)identityString;

/** 银行卡加*** */
+ (NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum;

@end
