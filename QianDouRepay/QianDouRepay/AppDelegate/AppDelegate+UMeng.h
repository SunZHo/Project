//
//  AppDelegate+UMeng.h
//  ZhangqiuForum
//
//  Created by <15>帝云科技 on 2018/3/31.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "AppDelegate.h"
#import <UMCommon/UMCommon.h>           // 公共组件是所有友盟产品的基础组件，必选
#import <UMAnalytics/MobClick.h>        // 统计组件
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

@interface AppDelegate (UMeng)

/**
 初始化友盟分享 (推荐方法, 在AppKey.h中配置各项秘钥)
 */
- (void)configureUMSocialssSDK;
//回调方法
typedef void(^UMSocialCallBack)(BOOL success, id responseObject, NSError *error);

/**
 分享文本
 
 @param text 要分享的文本
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)shareTextWithString:(NSString *)text
      currentViewController:(UIViewController *)currentVC
                   callback:(UMSocialCallBack)callback;
/**
 分享图片
 
 @param image 要分享的图片
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param platforms 分享的平台
 @param callback 回调方法
 */
- (void)shareImageWithImage:(UIImage *)image
                  thumImage:(UIImage *)thumImage
      currentViewController:(UIViewController *)currentVC
             sharePlatforms:(NSArray *)platforms
                   callback:(UMSocialCallBack)callback;

/**
 分享图文
 
 @param text 要分享的文字
 @param image 要分享的图片
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)shareTextWithString:(NSString *)text
                   andImage:(UIImage *)image
                  thumImage:(UIImage *)thumImage
      currentViewController:(UIViewController *)currentVC
                   callback:(UMSocialCallBack)callback;

/**
 分享网页
 
 @param url 要分享的网页地址
 @param title 标题
 @param description 描述
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)shareWebPageWithURLStr:(NSString *)url
                         title:(NSString *)title
                   description:(NSString *)description
                     thumImage:(UIImage *)thumImage
         currentViewController:(UIViewController *)currentVC
                      callback:(UMSocialCallBack)callback;


/**
 拉取新浪登录授权信息
 
 @param currentViewController 调用登录的当前控制面板
 @param callback 回调方法
 
 */
- (void)getAuthInfoFromSinaWithCurrentViewController:(UIViewController *)currentViewController CallBack:(UMSocialCallBack)callback;

/**
 拉取微信登录授权信息
 
 @param currentViewController 调用登录的当前控制面板
 @param callback 回调方法
 */
- (void)getAuthInfoFromWechatWithCurrentViewController:(UIViewController *)currentViewController CallBack:(UMSocialCallBack)callback;


/**
 拉取QQ登录授权信息
 @param currentViewController 调用登录的当前控制面板
 @param callback 回调方法
 */
- (void)getAuthInfoFromQQWithCurrentViewController:(UIViewController *)currentViewController CallBack:(UMSocialCallBack)callback;







#pragma mark - 暂时未涉及的方法
/**
 分享音乐
 
 @param musicURL 音乐的url
 @param title 标题
 @param description 描述
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)shareMusicWithURLStr:(NSString *)musicURL
                       title:(NSString *)title
                 description:(NSString *)description
                   thumImage:(UIImage *)thumImage
       currentViewController:(UIViewController *)currentVC
                    callback:(UMSocialCallBack)callback;
/**
 分享视频
 
 @param videoURL 视频的url
 @param title 标题
 @param description 描述
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)shareVideoWithURLStr:(NSString *)videoURL
                       title:(NSString *)title
                 description:(NSString *)description
                   thumImage:(UIImage *)thumImage
       currentViewController:(UIViewController *)currentVC
                    callback:(UMSocialCallBack)callback;

/**
 分享微信小程序
 
 @param programPath 小程序页面路径
 @param webPageURL 兼容网页地址
 @param userName 用户名
 @param title 小程序标题
 @param description 小程序内容描述
 @param thumImage 缩略图
 @param currentVC 调用分享方法的控制面板
 @param callback 回调方法
 */
- (void)WeichatMiniProgramWithPath:(NSString *)programPath
                        webPageURL:(NSString *)webPageURL
                          userName:(NSString *)userName
                             title:(NSString *)title
                       description:(NSString *)description
                         thumImage:(UIImage *)thumImage
             currentViewController:(UIViewController *)currentVC
                          callback:(UMSocialCallBack)callback;

@end
