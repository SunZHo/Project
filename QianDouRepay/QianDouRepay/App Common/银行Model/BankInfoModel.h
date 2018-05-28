//
//  BankInfoModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/4.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface BankInfoModel : BaseModel

/** 银行名称 */
@property (nonatomic , copy) NSString *name;

/** 银行联行号 */
@property (nonatomic , copy) NSString *number;

@end
