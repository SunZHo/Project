//
//  MeunViewHorizon.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/11.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol MeunViewDelegate <NSObject>

- (void)meunViewDidSelectedIndex:(NSInteger)index;

@end


@interface MeunViewHorizon : UIView

- (void)showInView:(UIView *)view targetRect:(CGRect)targetRect animated:(BOOL)animated;
- (void)dismissAnimated:(BOOL)animated;

@property (nonatomic , assign) id <MeunViewDelegate> delegate ;

@end
