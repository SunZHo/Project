//
//  FundsFlowModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface FundsFlowModel : BaseModel

// id  流水id
/** 时间 */
@property (nonatomic , copy) NSString *time;
/** 推广奖励-1  分润流水-2  提现审核中-3  提现成功-4  提现失败-5 */
@property (nonatomic , copy) NSString *type;
/** 影响金额 */
@property (nonatomic , copy) NSString *money;

@end
