//
//  calenderView.h
//  Jshare
//
//  Created by <15>帝云科技 on 2018/4/8.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SDAutoLayout.h"
#import "FSCalendar.h"

@interface calenderView : UIView

@property (nonatomic, copy) void (^selectDateBlock)(NSString *date);
- (void)show;
/** 是否可以多选 */
@property (nonatomic , assign) BOOL isMutiChoose ;

@end
