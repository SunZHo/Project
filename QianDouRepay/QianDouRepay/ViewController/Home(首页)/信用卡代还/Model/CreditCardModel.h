//
//  CreditCardModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/11.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface CreditCardModel : BaseModel

/** 还款日 */
@property (nonatomic , copy) NSString *repayDay;
/** 钱数 */
@property (nonatomic , copy) NSString *money;
/** 账单日 */
@property (nonatomic , copy) NSString *BillDay;


@end
