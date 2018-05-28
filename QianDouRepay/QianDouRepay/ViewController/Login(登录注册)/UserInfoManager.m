//
//  UserInfoManager.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/3.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "UserInfoManager.h"

@implementation UserInfoManager
@synthesize userInfo;
@synthesize userId;
@synthesize loginStatus;

- (id) init {
    self = [super init];
    if (self) {
        loginStatus = 0;
        
        if (userInfo == nil) {
            userInfo = [UserInfoCache unarchiveUserInfo:USER_INFO_CACHE];
            if (userInfo == nil) {
                userInfo = [NSMutableDictionary dictionary];
            }
        }
        if ([userInfo objectForKey:@"uid"] ) {
            userId = [userInfo objectForKey:@"uid"];
        }else{
            userId = @"0";
        }
        if ([userInfo objectForKey:@"loginStatus"]) {
            loginStatus = [userInfo objectForKey:@"loginStatus"];
        }else{
            loginStatus = @"0";
        }
    }
    return self;
}


@end
