//
//  RepayPlanListModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface RepayPlanListModel : BaseModel

// id

/** uid */
@property (nonatomic , copy) NSString *uid;
/** 卡id */
@property (nonatomic , copy) NSString  *cardid;
/** 计划金  */
@property (nonatomic , copy) NSString  *money;
/** 初次消费额  */
@property (nonatomic , copy) NSString  *first_money;
/** 二次消费额  */
@property (nonatomic , copy) NSString  *second_money;
/** - */
@property (nonatomic , copy) NSString  *time;
/** 计划时间  */
@property (nonatomic , copy) NSString  *plan_time;
@property (nonatomic , copy) NSString *add_time;
/** 手续费  */
@property (nonatomic , copy) NSString *fee_money;
/** 还款金额 */
@property (nonatomic , copy) NSString *repayment_money;

@end
