//
//  RepaymentPlanListVC.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseViewController.h"

@interface RepaymentPlanListVC : BaseViewController

/** 信用卡id */
@property (nonatomic , copy) NSString *cardid;

/** 计划是否执行完成 */
@property (nonatomic , assign) BOOL isFinish ;

@end
