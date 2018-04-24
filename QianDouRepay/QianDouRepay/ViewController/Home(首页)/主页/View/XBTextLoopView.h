//
//  XBTextLoopView.h
//  文字轮播
//
//  Created by 周旭斌 on 2017/4/9.
//  Copyright © 2017年 周旭斌. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef void(^selectTextBlock)(NSString *selectString, NSInteger index);

@interface XBTextLoopView : UIView
@property (nonatomic, copy) NSArray *dataSource;

/**
 直接调用这个方法
 @param frame 控件大小
 */
+ (instancetype)textLoopViewinitWithFrame:(CGRect)frame selectBlock:(selectTextBlock)selectBlock;

-(void)stopTimer;

-(void)startTimer;

@end
