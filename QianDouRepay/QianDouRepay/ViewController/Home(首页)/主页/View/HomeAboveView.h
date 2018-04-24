//
//  HomeAboveView.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol  HomeAboveViewDelegate <NSObject>

- (void) didSeleHomeAboveViewAtIndex:(NSInteger)index;

@end

@interface HomeAboveView : UIView

@property (nonatomic , assign) id <HomeAboveViewDelegate> delegate ;

@end
