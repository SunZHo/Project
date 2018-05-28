//
//  AppNetworking.h
//  daichuqu
//
//  Created by 王思颖 on 2017/5/15.
//  Copyright © 2017年 北京诚行天下投资咨询有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

/* 定义请求类型的枚举 */
typedef NS_ENUM(NSUInteger,HttpRequestType) {
    HttpRequestTypeGet = 0,
    HttpRequestTypePost
};

/* 缓存的block */
typedef void(^HttpRequestCache) (id jsonCache);

/* 定义请求成功的block  id 类型接收*/
typedef void(^HttpRequstSuccess) (id json);

/* 定义请求成功的block  arrar msg*/
typedef void (^HttpRequstArray)(NSArray *resultArray, NSString *msg);

/* 定义请求失败的block */
typedef void(^HttpRequsetFailure) (NSError *error);

/* 定义请求失败的block 错误信息、错误码*/
typedef void(^HttpRequestFailureCode)(NSString *errorMessage,int code);

/* 定义上传进度block */
typedef void(^HttpUploadProgress) (float progress);

/* 定义下载进度block */
typedef void(^HttpDownloadProgress) (float progress);


@interface AppNetworking : AFHTTPSessionManager

/* 单例方法 @return 实例对象 */
+ (instancetype)shareManager;
/* 网络状态 */
+ (BOOL)networkState;

/* 手动写入／更新缓存
 * @param jsonResponse 要写入的数据
 * @param URL               请求URL
 * @return BOOL             是否写入成功
 */
+ (BOOL)saveJsonResponseToCacheFile:(id)jsonResponse
                             andURL:(NSString *)URL;

/* 获取缓存的对象
 * @param URL  请求URL
 * @return  id     缓存对象
 */
+ (id)cacheJsonWithURL:(NSString *)URL;

/**
 网络请求的实例方法（无缓存）

 @param type get/post
 @param urlString 请求的地址
 @param paraments 请求的参数
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 */
+(void)requestWithType:(HttpRequestType)type
         withUrlString:(NSString *)urlString
         withParaments:(id)paraments
      withSuccessBlock:(HttpRequstSuccess)successBlock
      withFailureBlock:(HttpRequestFailureCode)failureBlock;
/**
 网络请求的实例方法 - （带缓存）

 @param type get/post
 @param urlString 请求的地址
 @param paraments 请求的参数
 @param jsonCache 缓存
 @param successBlock 请求成功的回调
 @param failureBlock 请求失败的回调
 @param progress 进度
 */
+(void)requestWithType:(HttpRequestType)type
         withUrlString:(NSString *)urlString
         withParaments:(id)paraments
        jsonCacheBlock:(HttpRequestCache)jsonCache
      withSuccessBlock:(HttpRequstSuccess)successBlock
      withFailureBlock:(HttpRequestFailureCode)failureBlock;

/* 上传图片
 * @param operations     上传图片预留参数 - 视具体情况而定，可移除
 * @param imageArray    上传的图片数组
 * @param width             图片要被压缩到的宽度
 * @param urlString        上传的url
 * @param successBlock 上传成功的回调
 * @param failureBlock    上传失败的回调
 * @param progress        上传进度
 */
//+(void)uploadImageWithOperations:(NSDictionary *)operations
//                  withImageArray:(NSArray *)imageArray
//                 withTargetWidth:(CGFloat)width
//                   withUrlString:(NSString *)urlString
//                withSuccessBlock:(HttpRequstSuccess)successBlock
//                withFailureBlock:(HttpRequsetFailure)failureBlock
//              withUploadProgress:(HttpUploadProgress)progress;

+(void)uploadImageWithOperations:(NSDictionary *)operations
                  withImageArray:(NSArray *)imageArray
                   withUrlString:(NSString *)urlString
               withFileParameter:(NSString *)parameter
                withSuccessBlock:(HttpRequstSuccess)successBlock
                withFailureBlock:(HttpRequsetFailure)failureBlock
              withUploadProgress:(HttpUploadProgress)progress;


/* 文件下载
 * @param operations    文件下载预留参数 - 视具体情况而定，可移除
 * @param savePath       下载文件的保存路径
 * @param urlString        请求的url
 * @param successBlock 下载文件成功的回调
 * @param failureBlock    下载文件失败的回调
 * @param progress         下载文件的进度显示
 */
+(void)downLoadFileWithOperations:(NSDictionary *)operations
                     withSavePath:(NSString *)savePath
                    withUrlString:(NSString *)urlString
                 withSuccessBlock:(HttpRequstSuccess)successBlock
                 withFailureBlock:(HttpRequsetFailure)failureBlock
             withDownLoadProgress:(HttpDownloadProgress)progress;

/**
 当前网络状态
 */
+ (BOOL)networkStatusIsReachability;
/* 取消所有的网络请求 */
+(void)cancelAllRequest;

/* 取消指定的URL请求 
 * @param requestType 该请求的请求类型
 * @param string            该请求的完整URL
 */
+(void)cancelHttpRequestWithRequestType:(NSString *)requestType
                       requestUrlString:(NSString *)string;

/**
 * 开启网络状态监听
 */
+ (void)networkReachabilityMonitoring;
@end
