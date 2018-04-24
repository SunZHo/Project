//
//  HomeCollectView.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HomeCollentViewDelegate <NSObject>

- (void)didSelectHomeCollentViewAtIndex:(NSInteger)index;

@end

@interface HomeCollectView : UIView

@property (nonatomic , assign) id <HomeCollentViewDelegate> delegate ;

@end
