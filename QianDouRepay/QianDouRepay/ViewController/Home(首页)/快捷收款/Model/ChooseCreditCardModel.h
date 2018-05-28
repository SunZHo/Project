//
//  ChooseCreditCardModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface ChooseCreditCardModel : BaseModel

// id
/** 银行联行号 */
@property (nonatomic , copy) NSString *bank_liannum;
/** 银行名称 */
@property (nonatomic , copy) NSString *name;
/** 卡号 */
@property (nonatomic , copy) NSString *bank_num;

@end
