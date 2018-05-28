//
//  PromotionModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface PromotionModel : BaseModel

/** 1-已认证，0-未认证  */
@property (nonatomic , copy) NSString *is_confirm;
/** 1-推广会员，0-普通会员  */
@property (nonatomic , copy) NSString *is_vip;
/** 手机号  */
@property (nonatomic , copy) NSString *phone;
/** 注册时间 */
@property (nonatomic , copy) NSString *add_time;
/** 姓名  */
@property (nonatomic , copy) NSString *realname;

@end
