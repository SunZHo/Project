//
//  CashRecordModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface CashRecordModel : BaseModel

/** 时间 */
@property (nonatomic , copy) NSString *time;
/** 状态：0-处理中，1-成功2-失败 */
@property (nonatomic , copy) NSString *status;
/** 金额 */
@property (nonatomic , copy) NSString *money;

@end
