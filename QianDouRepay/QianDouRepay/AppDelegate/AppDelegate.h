//
//  AppDelegate.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/4/9.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfoManager.h"
#define ApplicationDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) UserInfoManager *userInfoManager;

@end

