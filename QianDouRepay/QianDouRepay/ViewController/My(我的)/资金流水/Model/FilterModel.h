//
//  FilterModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/17.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface FilterModel : BaseModel

@property (nonatomic , copy) NSString *text;
@property (nonatomic , copy) NSString *type;
@property (nonatomic , assign) BOOL isChoose ;

@end
