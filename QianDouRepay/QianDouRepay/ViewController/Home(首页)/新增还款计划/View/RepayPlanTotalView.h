//
//  RepayPlanTotalView.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RepayPlanTotalView : UIView

-(instancetype)initWithFrame:(CGRect)frame infoDic:(NSDictionary *)dic;

@property (nonatomic, copy) void (^sureCommitBlock)(void);

- (void)show;

@end
