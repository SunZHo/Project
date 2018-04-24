//
//  RepayPlanListModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/12.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface RepayPlanListModel : BaseModel

@property (nonatomic , copy) NSString  *time;
@property (nonatomic , copy) NSString  *plan;
@property (nonatomic , copy) NSString  *total;
@property (nonatomic , copy) NSString  *first;
@property (nonatomic , copy) NSString  *second;
@property (nonatomic , copy) NSString  *fee;

@end
