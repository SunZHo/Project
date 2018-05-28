//
//  InviteRecordModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/13.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface InviteRecordModel : BaseModel

/** 手机号 */
@property (nonatomic , copy) NSString *phone;
/** 是否认证1-已认证0-未认证 */
@property (nonatomic , copy) NSString *is_confirm;
/** 注册时间 */
@property (nonatomic , copy) NSString *add_time;

@end
