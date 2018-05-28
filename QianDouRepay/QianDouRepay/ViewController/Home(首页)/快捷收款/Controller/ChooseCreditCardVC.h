//
//  ChooseCreditCardVC.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseViewController.h"

@interface ChooseCreditCardVC : BaseViewController

/** 收款储蓄卡id */
@property (nonatomic , copy) NSString *receiptBankCardID;

/** 收款钱数 */
@property (nonatomic , copy) NSString *receiptMoney;

@end
