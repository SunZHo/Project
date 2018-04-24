//
//  SetNickNameVC.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/10.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "BaseViewController.h"

@interface SetNickNameVC : BaseViewController

@property (nonatomic, copy) void (^nickNameBlock)(NSString *name);

@end
