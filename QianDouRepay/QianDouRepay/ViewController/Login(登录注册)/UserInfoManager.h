//
//  UserInfoManager.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/3.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoManager : NSObject

@property (nonatomic, strong)  NSMutableDictionary *userInfo;
@property (nonatomic, strong)  NSString  *loginStatus;   // 0-未登录，1-已登陆
@property (nonatomic, strong)  NSString  *userId;        // 用户id


@end
