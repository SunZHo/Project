//
//  AppDelegate+UMeng.m
//  ZhangqiuForum
//
//  Created by <15>帝云科技 on 2018/3/31.
//  Copyright © 2018年 diyunkeji. All rights reserved.
//

#import "AppDelegate+UMeng.h"

@implementation AppDelegate (UMeng)

/**
 初始化友盟分享 (推荐方法, 在AppKey.h中配置各项秘钥)
 */
- (void)configureUMSocialssSDK {
    // 配置友盟秘钥
    [self configuerUMSocialSDKWithAppKey:UMSocialAppKey];
    // 配置Wechat
    if ([WechatAppKey length] > 0) {
        NSLog(@"配置微信");
        [self configureWechatShareWithAppKey:WechatAppKey
                                   appSecret:WechatAppSecret
                                 redirectURL:WeChatRedirectURL];
    }
    // 配置QQ
    if ([QQAppKey length] > 0) {
        NSLog(@"配置QQ");
        [self configureQQShareWithAppKey:QQAppKey
                               appSecret:QQAppSecrect
                             redirectURL:QQRedirectURL];
    }
    // 配置Sina
    if ([SinaAppKey length] > 0) {
        NSLog(@"配置新浪");
        [self configureSinaShareWithAppKey:SinaAppKey
                                appSecrect:SinaAppSecrect
                               redirectURL:SinaRedirectURL];
    }
}
/**
 单一只初始化友盟分享, 此方法不会去配置微信/QQ/新浪等分享组件
 
 @param appKey 秘钥
 */
- (void)configuerUMSocialSDKWithAppKey:(NSString *)appKey {
    
    // 配置友盟SDK产品并并统一初始化
    
    // [UMConfigure setEncryptEnabled:YES]; // optional: 设置加密传输, 默认NO.
    [UMConfigure setLogEnabled:YES]; // 开发调试时可在console查看友盟日志显示，发布产品必须移除。
    [UMConfigure initWithAppkey:appKey channel:ChannelName];
    
    // 统计组件配置
    [MobClick setScenarioType:E_UM_NORMAL];
}
/**
 单一只配置微信分享 (推荐使用- (void)zx_configureUMSocialSDK;方法统一配置)
 
 @param appKey Wechat appKey
 @param appSecret Wechat appSecret
 @param redirectURL Wechat redirect URL
 */
- (void)configureWechatShareWithAppKey:(NSString *)appKey
                             appSecret:(NSString *)appSecret
                           redirectURL:(NSString *)redirectURL {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession
                                          appKey:appKey
                                       appSecret:appSecret
                                     redirectURL:redirectURL];
}

/**
 单一只配置QQ分享 (推荐使用- (void)zx_configureUMSocialSDK;方法统一配置)
 
 @param appKey QQ appKey
 @param appSecret QQ appSecrect (一般传nil)
 @param redirectURL QQ redirect URL
 */
- (void)configureQQShareWithAppKey:(NSString *)appKey
                         appSecret:(NSString *)appSecret
                       redirectURL:(NSString *)redirectURL {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ
                                          appKey:appKey
                                       appSecret:appSecret
                                     redirectURL:redirectURL];
}

/**
 单一只配置Sina分享 (推荐使用- (void)zx_configureUMSocialSDK;方法统一配置)
 
 @param appKey Sina appKey
 @param appSecrect Sina app
 @param redirectURL Sina redirect URL
 */
- (void)configureSinaShareWithAppKey:(NSString *)appKey
                          appSecrect:(NSString *)appSecrect
                         redirectURL:(NSString *)redirectURL {
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina
                                          appKey:appKey
                                       appSecret:appSecrect
                                     redirectURL:redirectURL];
}


#pragma mark - 配置系统回调

- (BOOL)application:(UIApplication *)application
            openURL:(nonnull NSURL *)url
  sourceApplication:(nullable NSString *)sourceApplication
         annotation:(nonnull id)annotation {
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
        // 如果有多个回调需求处理的话, 应该再创建一个分类别统一实现回调
    }
    return result;
}
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url options:options];
    if (!result) {
        // 其他如支付等SDK的回调
        // 如果有多个回调需求处理的话, 应该再创建一个分类别统一实现回调
    }
    return result;
}




#pragma mark - 友盟分享方法

/**
 分享文本
 
 @param text 要分享的文本
 @param callback 回调方法
 */
- (void)shareTextWithString:(NSString *)text
      currentViewController:(UIViewController *)currentVC
                   callback:(UMSocialCallBack)callback {
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 设置文本
    messageObject.text = text;
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)]];
    // 调用友盟分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        // 调用分享接口
        [[UMSocialManager defaultManager] shareToPlatform:platformType
                                            messageObject:messageObject
                                    currentViewController:currentVC
                                               completion:^(id result, NSError *error) {
                                                   
                                                   if (error) {
                                                       
                                                       if (callback) callback(FALSE, result, error);
                                                   } else {
                                                       
                                                       if (callback) callback(TRUE, result, error);
                                                   }
                                               }];
    }];
}

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
                   callback:(UMSocialCallBack)callback {
    
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建图片内容对象
    UMShareImageObject *shareObject      = [[UMShareImageObject alloc] init];
    
    // 如果有缩略图, 则设置缩略图
    if (thumImage) {
        
        shareObject.thumbImage = thumImage;
    }
    
    // 设置分享的图片
    if (image) {
        
        [shareObject setShareImage:image];
    }
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [UMSocialUIManager setPreDefinePlatforms:platforms];
    // 调用友盟分享面板
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType
                                            messageObject:messageObject
                                    currentViewController:currentVC
                                               completion:^(id result, NSError *error) {
                                                   
                                                   if (error) {
                                                       
                                                       if (callback) callback(FALSE, result, error);
                                                   } else {
                                                       
                                                       if (callback) callback(TRUE, result, error);
                                                   }
                                               }];
    }];
}

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
                   callback:(UMSocialCallBack)callback {
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 设置文本
    messageObject.text = text;
    
    // 创建图片内容对象
    UMShareImageObject *shareObject = [[UMShareImageObject alloc] init];
    
    // 如果有缩略图, 则设置缩略图
    if (thumImage) {
        
        shareObject.thumbImage = thumImage;
    }
    
    // 设置分享的图片
    if (image) {
        
        [shareObject setShareImage:image];
    }
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)]];
    // 调用分享接口
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType
                                            messageObject:messageObject
                                    currentViewController:currentVC
                                               completion:^(id result, NSError *error) {
                                                   
                                                   if (error) {
                                                       
                                                       if (callback) callback(FALSE, result, error);
                                                   } else {
                                                       
                                                       if (callback) callback(TRUE, result, error);
                                                   }
                                               }];
    }];
}


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
                      callback:(UMSocialCallBack)callback {
    
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建网页内容对象
    UMShareWebpageObject *shareObject    = [UMShareWebpageObject shareObjectWithTitle:title
                                                                                descr:description
                                                                            thumImage:thumImage];
    
    // 设置网页地址
    shareObject.webpageUrl = url;
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)]];
    // 调用分享接口
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType
                                            messageObject:messageObject
                                    currentViewController:currentVC
                                               completion:^(id result, NSError *error) {
                                                   
                                                   if (error) {
                                                       
                                                       if (callback) callback(FALSE, result, error);
                                                   } else {
                                                       
                                                       if (callback) callback(TRUE, result, error);
                                                   }
                                               }];
    }];
}

#pragma mark - 友盟登录方法

/**
 拉取新浪登录授权信息
 
 @param currentViewController 调用登录的当前控制面板
 @param callback 回调方法
 
 */
- (void)getAuthInfoFromSinaWithCurrentViewController:(UIViewController *)currentViewController CallBack:(UMSocialCallBack)callback {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_Sina
                                        currentViewController:currentViewController
                                                   completion:^(id result, NSError *error) {
                                                       
                                                       if (error) {
                                                           
                                                           if (callback) callback(FALSE, result, error);
                                                       } else {
                                                           
                                                           if (callback) callback(TRUE, result, error);
                                                       }
                                                   }];
}

/**
 拉取微信登录授权信息
 
 @param currentViewController 调用登录的当前控制面板
 @param callback 回调方法
 */
- (void)getAuthInfoFromWechatWithCurrentViewController:(UIViewController *)currentViewController CallBack:(UMSocialCallBack)callback {
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_WechatSession
                                        currentViewController:currentViewController
                                                   completion:^(id result, NSError *error) {
                                                       
                                                       if (error) {
                                                           
                                                           if (callback) callback(FALSE, result, error);
                                                       } else {
                                                           
                                                           if (callback) callback(TRUE, result, error);
                                                       }
                                                   }];
}

/**
 拉取QQ登录授权信息
 @param currentViewController 调用登录的当前控制面板
 @param callback 回调方法
 */
- (void)getAuthInfoFromQQWithCurrentViewController:(UIViewController *)currentViewController CallBack:(UMSocialCallBack)callback {
    
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:UMSocialPlatformType_QQ
                                        currentViewController:currentViewController
                                                   completion:^(id result, NSError *error) {
                                                       
                                                       if (error) {
                                                           
                                                           if (callback) callback(FALSE, result, error);
                                                       } else {
                                                           
                                                           if (callback) callback(TRUE, result, error);
                                                       }
                                                   }];
}






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
                    callback:(UMSocialCallBack)callback {
    
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建音乐内容对象
    UMShareMusicObject *shareObject      = [UMShareMusicObject shareObjectWithTitle:title
                                                                              descr:description
                                                                          thumImage:thumImage];
    
    // 设置音乐网页播放地址
    shareObject.musicUrl = musicURL;
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)]];
    // 调用分享接口
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType
                                            messageObject:messageObject
                                    currentViewController:currentVC
                                               completion:^(id result, NSError *error) {
                                                   
                                                   if (error) {
                                                       
                                                       if (callback) callback(FALSE, result, error);
                                                   } else {
                                                       
                                                       if (callback) callback(TRUE, result, error);
                                                   }
                                               }];
    }];
}

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
                    callback:(UMSocialCallBack)callback {
    
    // 创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    // 创建视频内容对象
    UMShareVideoObject *shareObject      = [UMShareVideoObject shareObjectWithTitle:title
                                                                              descr:description
                                                                          thumImage:thumImage];
    
    // 设置视频网页播放地址
    shareObject.videoUrl = videoURL;
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)]];
    // 调用分享接口
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType
                                            messageObject:messageObject
                                    currentViewController:currentVC
                                               completion:^(id result, NSError *error) {
                                                   
                                                   if (error) {
                                                       
                                                       if (callback) callback(FALSE, result, error);
                                                   } else {
                                                       
                                                       if (callback) callback(TRUE, result, error);
                                                   }
                                               }];
    }];
}

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
-(void)WeichatMiniProgramWithPath:(NSString *)programPath
                       webPageURL:(NSString *)webPageURL
                         userName:(NSString *)userName
                            title:(NSString *)title
                      description:(NSString *)description
                        thumImage:(UIImage *)thumImage
            currentViewController:(UIViewController *)currentVC
                         callback:(UMSocialCallBack)callback {
    
    // 创建分享消息对象
    UMSocialMessageObject *messageObject  = [UMSocialMessageObject messageObject];
    
    // 创建小程序消息对象
    UMShareMiniProgramObject *shareObject = \
    [UMShareMiniProgramObject shareObjectWithTitle:title
                                             descr:description
                                         thumImage:thumImage];
    
    shareObject.webpageUrl = webPageURL;
    shareObject.userName   = userName;
    shareObject.path       = programPath;
    
    // 分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    [UMSocialUIManager setPreDefinePlatforms:@[@(UMSocialPlatformType_Sina),@(UMSocialPlatformType_WechatSession),@(UMSocialPlatformType_WechatTimeLine),@(UMSocialPlatformType_QQ)]];
    // 调用分享接口
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        
        [[UMSocialManager defaultManager] shareToPlatform:platformType
                                            messageObject:messageObject
                                    currentViewController:currentVC
                                               completion:^(id result, NSError *error) {
                                                   
                                                   if (error) {
                                                       
                                                       if (callback) callback(FALSE, result, error);
                                                   } else {
                                                       
                                                       if (callback) callback(TRUE, result, error);
                                                   }
                                               }];
    }];
}


@end
