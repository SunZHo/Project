//
//  TakeCashResultView.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger,blockType) {
    blockTypeRecord = 0,
    blockTypeReset = 1,
    blockTypeGoback = 2,
};

@interface TakeCashResultView : UIView

- (void)showInView:(UIView *)view;

@property (nonatomic , assign) BOOL isSuccess ;

@property (nonatomic, copy) void (^ClickBlock)(blockType type);


@end
