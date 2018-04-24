//
//  AppPageViewController.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseViewController.h"

@interface AppPageViewController : BaseViewController

@property (nonatomic , copy) NSArray *titleArray;
@property (nonatomic , strong) NSMutableArray *subVcArray;

- (void)addchildViewControllers;

@end
