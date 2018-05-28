//
//  QuickCollectRecordModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface QuickCollectRecordModel : BaseModel

//"add_time" = 1525921780;
//"deal_info" = "";
//"deal_time" = 0;
//money = "500.08";
//status = 0;

/** 添加时间 */
@property (nonatomic , copy) NSString *add_time;
/** 处理说明 */
@property (nonatomic , copy) NSString *deal_info;
/** 处理时间 */
@property (nonatomic , copy) NSString *deal_time;
/** 金额 */
@property (nonatomic , copy) NSString *money;
/** 状态：0-未支付，1-成功，2-失败 */
@property (nonatomic , copy) NSString *status;

@end
