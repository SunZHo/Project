//
//  MyDivideProfitModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface MyDivideProfitModel : BaseModel

// id

/** - */
@property (nonatomic , copy) NSString *phone;
/** 时间 */
@property (nonatomic , copy) NSString *add_time;
/** 分润金额 */
@property (nonatomic , copy) NSString *money;
/** 分润类型1-还款2-收款 */
@property (nonatomic , copy) NSString *type;
/** 还款/收款金额 */
@property (nonatomic , copy) NSString *log_money;

@end
