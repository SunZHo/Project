//
//  NSDate+Extension.h
//  ZDPro
//
//  Created by L on 2018/1/16.
//  Copyright © 2018年 北京诚行天下投资咨询有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Extension)
+ (NSCalendar *) currentCalendar;
/**
 *  判断某个时间是否为今年
 */
- (BOOL)isThisYear;
/**
 *  判断某个时间是否为昨天
 */
- (BOOL)isYesterday;
/**
 *  判断某个时间是否为今天
 */
- (BOOL)isToday;

@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger year;
- (NSDate *)dateWithFormatter:(NSString *)formatter;
+ (NSDate *)date:(NSString *)datestr WithFormat:(NSString *)format;
@end
