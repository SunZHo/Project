//
//  BillModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface BillModel : BaseModel

@property (nonatomic , copy) NSString *month;
@property (nonatomic , copy) NSMutableArray *orderA;

@end

@interface BillSubModel : BaseModel
//"id": "2370",
//"type": "1",
//"time": "1518068532",
//"money": "200.00",
//"bank_num": "6222530922258541"

// id

/** 银行卡号  */
@property (nonatomic , copy) NSString *bank_num;
/** 时间  */
@property (nonatomic , copy) NSString *time;
/** 【账单-类型】还款消费-1  钱兜还款-2 */
@property (nonatomic , copy) NSString *type;
/** 金额 */
@property (nonatomic , copy) NSString *money;
/** 1—已完成0—未完成 */
@property (nonatomic , copy) NSString *status;

@end


@interface receiptRecordModel : BaseModel

/** 状态：0-未支付，1-成功，2-失败 */
@property (nonatomic , copy) NSString *status;
/** 添加时间 */
@property (nonatomic , copy) NSString *add_time;
/** 处理时间 */
@property (nonatomic , copy) NSString *deal_time;
/** 处理说明 */
@property (nonatomic , copy) NSString *deal_info;
/** 金额 */
@property (nonatomic , copy) NSString *money;

@end
