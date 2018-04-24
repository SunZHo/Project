//
//  RepayPlanDetailModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/20.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"


@interface RepayPlanDetailModel : BaseModel

@property (nonatomic , copy  ) NSString       *title;

@property (nonatomic , strong) NSMutableArray *subArray;

@property (nonatomic, assign ) BOOL           isOpening;

@end


@interface RepayPlanDetailSubModel : BaseModel

@property (nonatomic , copy) NSString *subTitle;
@property (nonatomic , copy) NSString *subValue;

@end
