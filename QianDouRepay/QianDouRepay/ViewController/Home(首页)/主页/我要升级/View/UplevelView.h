//
//  UplevelView.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/25.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UplevelView : UIView

@property (nonatomic , copy) NSString *money;

@property (nonatomic , copy) NSAttributedString *infoStr;

- (void)show;

@property (nonatomic, copy) void (^payClickBlock)(void);

@end
