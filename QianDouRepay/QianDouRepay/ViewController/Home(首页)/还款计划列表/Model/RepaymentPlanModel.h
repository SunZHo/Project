//
//  RepaymentPlanModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface RepaymentPlanModel : BaseModel

//@property (nonatomic , copy) NSString *time;
//@property (nonatomic , copy) NSString *type;
//@property (nonatomic , copy) NSString *money;

//id

/** 用户id */
@property (nonatomic , copy) NSString *uid;
/** 卡id */
@property (nonatomic , copy) NSString *bank_id;
/** 状态： 0-待初次消费，11-初次消费中，10-初次消费失败，1-待二次消费，21-二次消费中，20-二次消费失败，2-待还款，30-还款失败，3-已完成 */
@property (nonatomic , copy) NSString *status;
/** 计划金额 */
@property (nonatomic , copy) NSString *money;
/** 首次消费时间 */
@property (nonatomic , copy) NSString *first_time;
/** 首次消费金额 */
@property (nonatomic , copy) NSString *first_money;
/** 首次流水 */
@property (nonatomic , copy) NSString *first_loanno;
/** 首次处理说明 */
@property (nonatomic , copy) NSString *first_deal_info;
/** 首次单号 */
@property (nonatomic , copy) NSString *first_order_no;
/** 首次消费手续费 */
@property (nonatomic , copy) NSString *first_fee_money;
/** 二次消费时间 */
@property (nonatomic , copy) NSString *second_time;
/** 二次消费金额 */
@property (nonatomic , copy) NSString *second_money;
/** 二次流水 */
@property (nonatomic , copy) NSString *second_loanno;
/** 二次处理说明 */
@property (nonatomic , copy) NSString *second_deal_info;
/** 二次单号 */
@property (nonatomic , copy) NSString *second_order_no;
/** 二次消费手续费 */
@property (nonatomic , copy) NSString *second_fee_money;
/** 还款时间 */
@property (nonatomic , copy) NSString *repayment_time;
/** 还款金额 */
@property (nonatomic , copy) NSString *repayment_money;
/** 还款流水 */
@property (nonatomic , copy) NSString *repayment_loanno;
/** 还款处理说明 */
@property (nonatomic , copy) NSString *repayment_deal_info;
/** 还款单号 */
@property (nonatomic , copy) NSString *repayment_order_no;
/** 还款手续费 */
@property (nonatomic , copy) NSString *repayment_fee_money;
/** 时间 */
@property (nonatomic , copy) NSString *add_time;
@property (nonatomic , copy) NSString *add_ip;

@property (nonatomic , copy) NSString *is_freeze;

@end
