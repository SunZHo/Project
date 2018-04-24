//
//  AppCommon.m
//  ZhangqiuForum
//
//  Created by 帝云科技 on 2018/1/23.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "AppCommon.h"

@implementation AppCommon

/**
 返回字符宽度
 
 @param font 字体大小
 @param string 字符
 @return 宽度
 */
+ (CGFloat) getStringWidthWithFont:(NSInteger)font andString:(NSString *)string{
    CGRect textRect = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, font) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return textRect.size.width;
}

+ (CGFloat) getStringHeightWithFont:(NSInteger)font width:(CGFloat)width andString:(NSString *)string{
    CGRect textRect = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:font]} context:nil];
    return textRect.size.height;
}

+ (NSString *) md5:(NSString *) input{
    if (input) {
        const char *cStr = [input UTF8String];
        unsigned char digest[CC_MD5_DIGEST_LENGTH];
        CC_MD5( cStr, strlen(cStr), digest );
        NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
        for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
            [output appendFormat:@"%02x", digest[i]];
        
        return output;
    }else{
        return @"";
    }
    
}

/**
 * 时间格式化
 */
//createTimeString为后台传过来的13位纯数字时间戳
+ (NSString *)updateTimeForRow:(NSString *)createTimeString {
    
    NSCalendar *greCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate* createDate = [NSDate dateWithTimeIntervalSince1970:[createTimeString floatValue]];
    NSDateComponents *nowDateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:[NSDate date]];
    NSDateComponents *dateComponents = [greCalendar components:NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond fromDate:createDate];
    
    if (nowDateComponents.year == dateComponents.year) {// 今年
        // 获取当前时间戳 1466386762.345715 十位整数 6位小数
        NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
        // 创建时间戳(后台返回的时间 一般是13位数字)
        NSTimeInterval createTime = [createTimeString longLongValue];
        // 时间差
        NSTimeInterval time = currentTime - createTime;
        NSInteger sec = time/60;
        if (sec <= 1) {
            return @"刚刚";
        }
        if (sec > 1 && sec<60) {
            return [NSString stringWithFormat:@"%ld分钟前",sec];
        }
        // 秒转小时
        NSInteger hours = time/3600;
        if (hours<24) {
            return [NSString stringWithFormat:@"%ld小时前",hours];
        }
        //秒转天数
        NSInteger days = time/3600/24;
        if (days >= 1) {
//            NSString* dateString = [NSDate stringWithDate:createDate format:@"MM-dd HH:mm"];
            NSString* dateString = [NSDate stringWithDate:createDate format:@"yyyy-MM-dd"];
            return dateString;
        }else{
            return @"";
        }
    }else{
        NSString* dateString = [NSDate stringWithDate:createDate format:@"yyyy-MM-dd"];
        return dateString;
    }
}


/**
 //去除所有HTML标签

 @param string -
 @return -
 */
+ (NSString *)offHTMLwithString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<[^>]*>|\n"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

// 去除所有标签，只剩img,br,p
+ (NSString *)offHTMLLeftImgwithString:(NSString *)string{
    NSRegularExpression *regularExpretion=[NSRegularExpression regularExpressionWithPattern:@"<(?!img|br|p|/p).*?>"
                                                                                    options:0
                                                                                      error:nil];
    string=[regularExpretion stringByReplacingMatchesInString:string options:NSMatchingReportProgress range:NSMakeRange(0, string.length) withTemplate:@""];
    return string;
}

+ (NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim {
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
        html = [html stringByReplacingOccurrencesOfString:@"\r" withString:@""];
        html = [html stringByReplacingOccurrencesOfString:@"&lt;br /&gt;" withString:@""];
        html = [html stringByReplacingOccurrencesOfString:@"\n\n" withString:@"\n"];
        html = [html stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@" "];
    }
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

/**
 得到父级控制器
 
 @param view View
 @return 控制器
 */
+(UIViewController *)getViewController:(UIView *)view{
    UIResponder *responder = view.nextResponder;
    while (responder) {
        if ([responder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)responder;
        }
        responder = responder.nextResponder;
    }
    return nil;
}


/**
 *  截取字符串 改变颜色
 *
 *  @param strRange 截取范围
 *  @param str      截取的字符串
 *  @param font     字体大小
 *
 *  @return 返回截取后改变颜色的字符串
 */

+ (NSMutableAttributedString *)getRange:(NSRange)strRange labelStr:(NSString *)str Font:(UIFont*)font Color:(UIColor *)strColor{
    NSMutableAttributedString * attributedString = [[NSMutableAttributedString alloc] initWithString:str];
    [attributedString addAttribute:NSForegroundColorAttributeName value:strColor range:strRange];
    [attributedString addAttribute:NSFontAttributeName value:font range:strRange];
    return attributedString;
}

/**
 获取当前屏幕显示的viewcontroller

 @return -
 */
+ (UIViewController *)getCurrentVC
{
    UIViewController *rootViewController = [UIApplication sharedApplication].keyWindow.rootViewController;
    
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        
        UINavigationController* navigationController = (UINavigationController*)tabBarController.selectedViewController;
        return  navigationController.visibleViewController;
        
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        
        return navigationController.visibleViewController;
        
    } else if (rootViewController.presentedViewController) {
        
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        
        return presentedViewController.presentedViewController;
        
    } else {
        
        return rootViewController;
    }
}

/**
 绘制虚线

 @param lineView 需要绘制成虚线的view
 @param lineLength 虚线的宽度
 @param lineSpacing 虚线的间距
 @param lineColor 虚线的颜色
 */
+ (void)drawDashLine:(UIView *)lineView lineLength:(int)lineLength lineSpacing:(int)lineSpacing lineColor:(UIColor *)lineColor
{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    [shapeLayer setBounds:lineView.bounds];
    [shapeLayer setPosition:CGPointMake(CGRectGetWidth(lineView.frame) / 2, CGRectGetHeight(lineView.frame))];
    [shapeLayer setFillColor:[UIColor clearColor].CGColor];
    
    //  设置虚线颜色为
    [shapeLayer setStrokeColor:lineColor.CGColor];
    
    //  设置虚线宽度
    [shapeLayer setLineWidth:CGRectGetHeight(lineView.frame)];
    [shapeLayer setLineJoin:kCALineJoinRound];
    
    //  设置线宽，线间距
    [shapeLayer setLineDashPattern:[NSArray arrayWithObjects:[NSNumber numberWithInt:lineLength], [NSNumber numberWithInt:lineSpacing], nil]];
    
    //  设置路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, NULL, 0, 0);
    CGPathAddLineToPoint(path, NULL, CGRectGetWidth(lineView.frame), 0);
    
    [shapeLayer setPath:path];
    CGPathRelease(path);
    
    //  把绘制好的虚线添加上来
    [lineView.layer addSublayer:shapeLayer];
}






@end
