//
//  MessageModel.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/19.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseModel.h"

@interface MessageModel : BaseModel

/** 标题  */
@property (nonatomic , copy) NSString *title;
/** 时间 */
@property (nonatomic , copy) NSString *time;
/** 内容  */
@property (nonatomic , copy) NSString *content;
/** 状态：0-未读，1-已读 */
@property (nonatomic , copy) NSString *read ;

@end
