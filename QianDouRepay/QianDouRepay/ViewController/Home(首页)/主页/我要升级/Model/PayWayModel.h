//
//  PayWayModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/25.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface PayWayModel : BaseModel

@property (nonatomic , assign) BOOL isSelect ;
@property (nonatomic , copy) NSString *imageName;
@property (nonatomic , copy) NSString *name;

@end
