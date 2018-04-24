//
//  CashRecordModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface CashRecordModel : BaseModel

@property (nonatomic , copy) NSString *time;
@property (nonatomic , copy) NSString *type;
@property (nonatomic , copy) NSString *money;

@end
