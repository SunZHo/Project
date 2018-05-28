//
//  BillDetailViewController.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseViewController.h"

@interface BillDetailViewController : BaseViewController

/** 状态 */
@property (nonatomic , copy) NSString *status;
/** 账单id */
@property (nonatomic , copy) NSString *orderid;

@end
