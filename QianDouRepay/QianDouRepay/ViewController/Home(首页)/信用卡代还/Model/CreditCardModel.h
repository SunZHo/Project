//
//  CreditCardModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/11.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface CreditCardModel : BaseModel

// 卡id  见 baseModel  @property (nonatomic , copy) NSString *id;

/** 银行名 */
@property (nonatomic , copy) NSString *bank_name;
/** 银行卡号 */
@property (nonatomic , copy) NSString *bank_num;
/** 姓名 */
@property (nonatomic , copy) NSString *realname;
/** 账单日 */
@property (nonatomic , copy) NSString *statement_date;
/** 还款日 */
@property (nonatomic , copy) NSString *repayment_date;
/** 还款金额 */
@property (nonatomic , copy) NSString *money;
/** 有效期 YYMM */
@property (nonatomic , copy) NSString *validity;
/** 是否授权 0-未授权 1-已授权 */
@property (nonatomic , copy) NSString *is_confirm;
/** 信用卡手机号 */
@property (nonatomic , copy) NSString *phone;

@end
