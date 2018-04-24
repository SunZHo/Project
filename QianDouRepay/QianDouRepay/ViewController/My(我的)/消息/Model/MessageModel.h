//
//  MessageModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

@property (nonatomic , assign) BOOL isRead ;
@property (nonatomic , copy) NSString *title;
@property (nonatomic , copy) NSString *time;
@property (nonatomic , copy) NSString *content;

@end
