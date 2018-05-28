//
//  QuickCollectionModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface QuickCollectionModel : BaseModel

@property (nonatomic , copy) NSString *pathName;
/** 费率 */
@property (nonatomic , copy) NSString *pay_huipoint;
/** 单笔固定手续费 */
@property (nonatomic , copy) NSString *paygu_huipoint;
/** 交易时间 */
@property (nonatomic , copy) NSString *time;
/** 结算 */
@property (nonatomic , copy) NSString *jiesuan;
/** 额度说明 */
@property (nonatomic , copy) NSString *desc;

@property (nonatomic , copy) NSString *money;
@property (nonatomic , copy) NSString *inputMoney;

@end
