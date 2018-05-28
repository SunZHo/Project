//
//  MyFeeRateModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface MyFeeRateModel : BaseModel

/** 会员类型：普通会员，推广员 */
@property (nonatomic , copy) NSString *user_info;
/** 代还费率 */
@property (nonatomic , copy) NSString *pay_cost;
/** 单笔固定手续费 */
@property (nonatomic , copy) NSString *cash_fee;

/** 通道名称 */
@property (nonatomic , copy) NSString *name;

@end

@interface MyFeeRateReceiveModel : BaseModel

/** 会员类型：普通会员，推广员 */
@property (nonatomic , copy) NSString *user_info;
/** 收款费率 */
@property (nonatomic , copy) NSString *get_cost;
/** 收款单笔到账手续费 */
@property (nonatomic , copy) NSString *get_fee;
/** 通道名称 */
@property (nonatomic , copy) NSString *name;
/** T+1 交易 */
@property (nonatomic , copy) NSString *t1;
/** 额度 */
@property (nonatomic , copy) NSString *edu;
/** 封顶值 */
@property (nonatomic , copy) NSString *fengd;


@end
