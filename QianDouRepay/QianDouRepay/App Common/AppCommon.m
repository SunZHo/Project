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



+ (BOOL)isBankCard:(NSString *)cardNumber{
    if(cardNumber.length==0){
        return NO;
    }
    NSString *digitsOnly = @"";
    char c;
    for (int i = 0; i < cardNumber.length; i++){
        c = [cardNumber characterAtIndex:i];
        if (isdigit(c)){
            digitsOnly =[digitsOnly stringByAppendingFormat:@"%c",c];
        }
    }
    int sum = 0;
    int digit = 0;
    int addend = 0;
    BOOL timesTwo = false;
    for (NSInteger i = digitsOnly.length - 1; i >= 0; i--){
        digit = [digitsOnly characterAtIndex:i] - '0';
        if (timesTwo){
            addend = digit * 2;
            if (addend > 9) {
                addend -= 9;
            }
        }
        else {
            addend = digit;
        }
        sum += addend;
        timesTwo = !timesTwo;
    }
    int modulus = sum % 10;
    return modulus == 0;
}


+ (BOOL)isIDCard:(NSString *)identityString {
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex2 = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    //** 开始进行校验 *//
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex  = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum      += subStrIndex * idCardWiIndex;
    }
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}


+ (NSString *)getNewBankNumWitOldBankNum:(NSString *)bankNum
{
    NSMutableString *mutableStr;
    if (bankNum.length) {
        mutableStr = [NSMutableString stringWithString:bankNum];
        for (int i = 0 ; i < mutableStr.length; i ++) {
            if (i>3&&i<mutableStr.length - 3) {
                [mutableStr replaceCharactersInRange:NSMakeRange(i, 1) withString:@"*"];
            }
        }
        NSString *text = mutableStr;
        NSCharacterSet *characterSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789\b"];
        text = [text stringByReplacingOccurrencesOfString:@" " withString:@""];
        NSString *newString = @"";
        while (text.length > 0) {
            NSString *subString = [text substringToIndex:MIN(text.length, 4)];
            newString = [newString stringByAppendingString:subString];
            if (subString.length == 4) {
                newString = [newString stringByAppendingString:@" "];
            }
            text = [text substringFromIndex:MIN(text.length, 4)];
        }
        newString = [newString stringByTrimmingCharactersInSet:[characterSet invertedSet]];
        return newString;
    }
    return bankNum;
    
}

@end
