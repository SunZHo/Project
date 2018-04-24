//
//  PromotionModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface PromotionModel : BaseModel

@property (nonatomic , copy) NSString *name;
@property (nonatomic , copy) NSString *vipType;
@property (nonatomic , copy) NSString *phone;
@property (nonatomic , copy) NSString *time;
@property (nonatomic , copy) NSString *isRealName;

@end
