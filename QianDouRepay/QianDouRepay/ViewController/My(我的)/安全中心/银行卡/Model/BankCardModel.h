//
//  BankCardModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/16.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface BankCardModel : BaseModel

// id 储蓄卡id

/** 银行名称 */
@property (nonatomic , copy) NSString *bank_name;
/** 银行卡号 */
@property (nonatomic , copy) NSString *bank_num;
/** 姓名 */
@property (nonatomic , copy) NSString *name;

/** 是否可解绑 */
@property (nonatomic , assign) BOOL isUnbind ;

@end
