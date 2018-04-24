//
//  AppDelegate+Configure.m
//  ZhangqiuForum
//
//  Created by 帝云科技 on 2018/1/17.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "AppDelegate+Configure.h"
#import "CYLPlusButtonSubclass.h"

#import "MyViewController.h"
#import "LoginViewController.h"

@implementation AppDelegate (Configure)

- (void)appConfigure
{
    [self configureKeyBoard];
    [self configTabbar];
    [self configNavgation];
}



/**
 配置键盘辅助框
 */
- (void)configureKeyBoard
{
    IQKeyboardManager *keyBoardManager = [IQKeyboardManager sharedManager];
    keyBoardManager.shouldResignOnTouchOutside = YES;
    keyBoardManager.placeholderFont = kFont(16);
//    keyBoardManager.keyboardDistanceFromTextField = 15.0;
    
    
}

- (void)configTabbar{
    [CYLPlusButtonSubclass registerPlusButton];
    CYLTabBarControllerConfig *tabBarControllerConfig = [[CYLTabBarControllerConfig alloc] init];
    tabBarControllerConfig.tabBarController.delegate = self;
    CYLTabBarController *tabBarController = tabBarControllerConfig.tabBarController;
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}

- (void)configNavgation{
    UIColor *MainNavBarColor = HEXACOLOR(0xffffff);
//    UIColor *MainViewColor   = [UIColor colorWithRed:126/255.0 green:126/255.0 blue:126/255.0 alpha:1];
    
    // 设置是 广泛使用WRNavigationBar，还是局部使用WRNavigationBar，目前默认是广泛使用
    [WRNavigationBar wr_widely];
    [WRNavigationBar wr_setBlacklist:@[@"TabBarVC",
                                       @"TZPhotoPickerController",
                                       @"TZGifPhotoPreviewController",
                                       @"TZAlbumPickerController",
                                       @"TZPhotoPreviewController",
                                       @"TZVideoPlayerController"]];
    
    // 设置导航栏默认的背景颜色
    [WRNavigationBar wr_setDefaultNavBarBarTintColor:MainNavBarColor];
    // 设置导航栏所有按钮的默认颜色
    [WRNavigationBar wr_setDefaultNavBarTintColor:[UIColor blackColor]];
    // 设置导航栏标题默认颜色
    [WRNavigationBar wr_setDefaultNavBarTitleColor:[UIColor blackColor]];
    // 统一设置状态栏样式
    [WRNavigationBar wr_setDefaultStatusBarStyle:UIStatusBarStyleDefault];
    // 如果需要设置导航栏底部分割线隐藏，可以在这里统一设置
    [WRNavigationBar wr_setDefaultNavBarShadowImageHidden:YES];
}


#pragma mark - tabbar代理
- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
//    if ([viewController.childViewControllers[0] isKindOfClass:[MyViewController class]]) {
//        LoginViewController *loginVc = [[LoginViewController alloc]init];
//        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:loginVc];
//        [tabBarController presentViewController:nav animated:NO completion:nil];
//        return NO;
//    }
    return YES;
}







@end
