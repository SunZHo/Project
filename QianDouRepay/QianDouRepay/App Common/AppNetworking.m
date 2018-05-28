//
//  AppNetworking.m
//  daichuqu
//
//  Created by 王思颖 on 2017/5/15.
//  Copyright © 2017年 北京诚行天下投资咨询有限公司. All rights reserved.
//


#import "AppNetworking.h"
#import <CommonCrypto/CommonDigest.h>
#import "AFNetworkActivityIndicatorManager.h"
//#import "UIImage+WLCompress.h"

#define DocumentsDirectory [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject]

@implementation AppNetworking

static AFNetworkReachabilityManager * _reachablityManager;
static NSString *api_version = @"1.0.1";

#pragma mark - shareManager
/* 获得全局唯一的网络请求实例单例方法
 * @return 网络请求类的实例
 */
+(instancetype)shareManager{
    static AppNetworking *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    });
    return manager;
}
+(BOOL)networkState{
    BOOL notReachable = _reachablityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable;
    return !notReachable;
}

#pragma mark - 重写initWithBaseUrl
/* @param url baseUrl
 * @return 通过重写父类的initWithBaseUrl方法，返回网络请求类的实例
 */
- (instancetype)initWithBaseURL:(NSURL *)url{
    if (self == [super initWithBaseURL:url])
    {
        NSAssert(url, @"您需要为您的请求设置baseUrl");
        [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
        
        /* 设置请求超时时间 */
        self.requestSerializer.timeoutInterval = 60;

        /* 设置相应的缓存策略 */
        self.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
//       self.responseSerializer = [AFJSONResponseSerializer serializerWithReadingOptions:NSJSONReadingMutableContainers];
        
        AFJSONResponseSerializer *response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.responseSerializer = response;
        /* 设置可接受的类型 */
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"application/json", @"text/json",@"text/plain", @"text/javascript", @"text/html",@"binary/octet-stream", nil]];
//        [self setHttpHeaders];//设置请求头
    }
    return self;
}
/*
- (void)setHttpHeaders{
    //添加请求头，headerFieldValueDictionary为请求头字典
    NSString *sequence = [NSUUID UUID].UUIDString;
    NSString *equipment = [NSString stringWithFormat:@"%@%@%@%@%@",[UIDevice currentDevice].model,[UIDevice currentDevice].name,[UIDevice currentDevice].systemName,[UIDevice currentDevice].systemVersion,[UIDevice currentDevice].localizedModel];
    NSString *request_Token = [CommonMethods base64EncodeString:[CommonMethods sha1:sequence]];
    NSString *UserAgentStr = [NSString stringWithFormat:@"IOS mobile housekeeper %@",BundleVersion];
    NSMutableDictionary *headerFieldValueDictionary = [NSMutableDictionary dictionaryWithDictionary:@{
                          @"Accept":@"Content-Type",
                      @"User-Agent":UserAgentStr,//标准 UA 增加 NetType 当前所使用的网络标识。增加运营商标示 Carrier。
                   @"X-API-Version":api_version,//请求的Api版本，当前版本固定为 1.0。后续可指定每个Api所需要访问的版本
              @"X-Request-Sequence":sequence,//请求序列，每次发起请求都需要生成，规则不限
                   @"X-App-Version":[NSString stringWithFormat:@"%@;%@",[UIDevice currentDevice].systemName,BundleVersion],//当前客户端版本
                 @"X-Request-Token":request_Token,//请求 token 计算方式 base64(sha1(X-Request-Sequence))
                     @"X-Timestamp":[NSString stringWithFormat:@"%llu",[CommonMethods getCurrentTimeStamp]],//发起请求时 App 的时间戳
                     @"X-APP-Build":@"debug",//当前客户端的版本分支(debug/release)
                     @"X-Equipment":equipment,//当前设备的信息，包括但不限于：系统、型号、系统版本、屏幕高、屏幕宽等,
                          @"X-UDID":[CommonMethods getDeviceId],//当前设备的唯一ID
                          }];
    if ([AccountInfo sharedAccountInfo].access_token && [AccountInfo sharedAccountInfo].access_token.length > 0) {
        NSString * Authorization = [NSString stringWithFormat:@"%@:%@",[AccountInfo sharedAccountInfo].hashuid,[AccountInfo sharedAccountInfo].access_token];
        [headerFieldValueDictionary setObject:[CommonMethods base64EncodeString:Authorization] forKey:@"Authorization"];
    }
    NSLog(@"请求头信息=====%@",headerFieldValueDictionary);
    if (headerFieldValueDictionary != nil) {
        for (NSString *httpHeaderField in headerFieldValueDictionary.allKeys) {
            NSString *value = headerFieldValueDictionary[httpHeaderField];
            [self.requestSerializer setValue:value forHTTPHeaderField:httpHeaderField];
        }
    }
}
 */
#pragma mark - 网络请求类方法 
/* 网络请求的实例方法
 * @param type              get/post
 * @param urlString        请求的地址
 * @param paraments     请求的参数
 * @param successBlock 请求成功的回调
 * @param failureBlock    请求失败的回调
 */
+(void)requestWithType:(HttpRequestType)type
         withUrlString:(NSString *)urlString
         withParaments:(id)paraments
      withSuccessBlock:(HttpRequstSuccess)successBlock
      withFailureBlock:(HttpRequestFailureCode)failureBlock
{
    [self networkStatusIsReachability];
    NSLog(@"请求URL：%@ ,请求参数：%@",urlString,paraments);
    switch (type) {
        case HttpRequestTypeGet:{
            [[AppNetworking shareManager] GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
//                float progressfloat = 1.0 *downloadProgress.completedUnitCount/downloadProgress.totalUnitCount;
//                progress(progressfloat);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                
                NSDictionary *json = [NSDictionary dictionaryWithDictionary:responseObject];
                NSInteger code = [[json objectForKey:@"status"] integerValue];
                NSLog(@"请求结果：== %@",json);
                if (code == 9999) {//成功
                    if (successBlock) {
                        successBlock(responseObject);
                    }
                }
                else{
                    if (failureBlock) {
                        [self showErrorText:json[@"message"]];
                        failureBlock(json[@"message"],0);
                    }
                }
     
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSError *underError = error.userInfo[@"NSUnderlyingError"];
                NSData *responseData = underError.userInfo[@"com.alamofire.serialization.response.error.data"];
                NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
                if (failureBlock) {
                    [self showErrorText:@"系统错误"];
                    failureBlock(@"",0);
                }

            }];
        }
            break;
            case HttpRequestTypePost:
        {
            [[AppNetworking shareManager] POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
//                float progressfloat = 1.0 *uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
//                progress(progressfloat);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {

                NSDictionary *json = [NSDictionary dictionaryWithDictionary:responseObject];
                NSInteger code = [[json objectForKey:@"status"] integerValue];
                NSLog(@"请求结果：== %@",json);
                if (code == 9999) {//成功
                    if (successBlock) {
                        successBlock(responseObject);
                    }
                }
                else{
                    if (failureBlock) {
                        [self showErrorText:json[@"message"]];
                        failureBlock(json[@"message"],0);
                    }
                }
            
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                NSError *underError = error.userInfo[@"NSUnderlyingError"];
                NSData *responseData = underError.userInfo[@"com.alamofire.serialization.response.error.data"];
                NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
                if (failureBlock) {
//                    failureBlock(error.localizedDescription,0);
                    [self showErrorText:@"系统错误"];
                    failureBlock(@"",0);
                }
                NSLog(@"Error结果：%@ ",result);
            }];
        }
            break;
    }
}
/* 网络请求的实例方法 - （带缓存）
 * @param type              get/post
 * @param urlString        请求的地址
 * @param paraments     请求的参数
 * @param successBlock 请求成功的回调
 * @param failureBlock    请求失败的回调
 */
+(void)requestWithType:(HttpRequestType)type
         withUrlString:(NSString *)urlString
         withParaments:(id)paraments
        jsonCacheBlock:(HttpRequestCache)jsonCache
      withSuccessBlock:(HttpRequstSuccess)successBlock
      withFailureBlock:(HttpRequestFailureCode)failureBlock
{
    [self networkStatusIsReachability];
    NSDictionary *responsedic = [AppNetworking cacheJsonWithURL:urlString];
    if (responsedic != nil) {
        jsonCache([AppNetworking cacheJsonWithURL:urlString]);
    }
    NSLog(@"请求URL：%@ ,请求参数：%@",urlString,paraments);
    switch (type) {
        case HttpRequestTypeGet:{
            [[AppNetworking shareManager] GET:urlString parameters:paraments progress:^(NSProgress * _Nonnull downloadProgress) {
//                float progressfloat = 1.0 *downloadProgress.completedUnitCount/downloadProgress.totalUnitCount;
//                progress(progressfloat);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
  
                NSDictionary *json = [NSDictionary dictionaryWithDictionary:responseObject];
                NSInteger code = [[json objectForKey:@"status"] integerValue];
                if (code == 1) {//成功
                    if (successBlock) {
                        successBlock(responseObject);
                    }
                }
                else{
                    if (failureBlock) {
                        failureBlock(json[@"message"],0);
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                
                NSError *underError = error.userInfo[@"NSUnderlyingError"];
                NSData *responseData = underError.userInfo[@"com.alamofire.serialization.response.error.data"];
                NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
                NSLog(@"Error结果：%@",result);
                if (failureBlock) {
                    failureBlock(result,0);
                }
            }];
        }
            break;
        case HttpRequestTypePost:{
            [[AppNetworking shareManager] POST:urlString parameters:paraments progress:^(NSProgress * _Nonnull uploadProgress) {
//                float progressfloat = 1.0 *uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
//                progress(progressfloat);
            } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                NSDictionary *json = [NSDictionary dictionaryWithDictionary:responseObject];
                NSInteger code = [[json objectForKey:@"status"] integerValue];
                if (code == 1) {//成功
                    if (successBlock) {
                        successBlock(responseObject);
                    }
                }
                else{
                    if (failureBlock) {
                        failureBlock(json[@"message"],0);
                        
                    }
                }
            } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                if (failureBlock) {
                    failureBlock(error.localizedDescription,0);
                }
                NSLog(@"Error结果：%@",error);
            }];
        }
            break;
    }
}

#pragma mark 多图上传
/* 上传图片
 * @param operations     上传图片等预留参数 - 视具体情况而定 可移除
 * @param imageArray   上传的图片数组
 * @param width             图片要被压缩到的宽度
 * @param urlString        上传的URL - 完整的url
 * @param successBlock 上传成功的回调
 * @param failureBlock    上传失败的回调
 * @param progress        上传进度
 */
+(void)uploadImageWithOperations:(NSDictionary *)operations
                  withImageArray:(NSArray *)imageArray
                 withTargetWidth:(CGFloat)width
                   withUrlString:(NSString *)urlString
                withSuccessBlock:(HttpRequstSuccess)successBlock
                withFailureBlock:(HttpRequsetFailure)failureBlock
              withUploadProgress:(HttpUploadProgress)progress
{
    [self networkStatusIsReachability];
//    //创建管理者对象
//    NSLog(@"请求的URL：%@/%@",ROOT_URL,urlString);
//    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [[AppNetworking shareManager] POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i = 0;
        /* 出于性能考虑，将上传图片进行压缩 */
        for (UIImage *image in imageArray) {
            //image的分类方法
//            UIImage *resizedImage = [UIImage IMGCompressed:image targetWidth:width];
            NSData *imgData = UIImageJPEGRepresentation(image, .5);
//            NSData *imgData = [image compressWithLengthLimit:500.0f * 1024.0f];
            //在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            //要解决此问题
            //可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            //设置时间格式
            formatter.dateFormat = @"yyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
//            NSString *fileName=[NSString stringWithFormat:@"pic%d",i];
            NSString *name = @"file[]";
            //将得到的二进制图片拼接到表单中  （data：指定上传的二进制流；name：服务器端所需参数名）
            [formData appendPartWithFileData:imgData name:name fileName:fileName mimeType:@"image/png"];
            i ++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        float progressfloat = 1.0 *uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        progress(progressfloat);
        NSLog(@"%f...jindu",progressfloat);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *underError = error.userInfo[@"NSUnderlyingError"];
        NSData *responseData = underError.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
        NSLog(@"Error结果：%@  %@",result,error);
        failureBlock(error);
//        [self dismissLoading];
    }];
}

+(void)uploadImageWithOperations:(NSDictionary *)operations
                  withImageArray:(NSArray *)imageArray
                   withUrlString:(NSString *)urlString
               withFileParameter:(NSString *)parameter
                withSuccessBlock:(HttpRequstSuccess)successBlock
                withFailureBlock:(HttpRequsetFailure)failureBlock
              withUploadProgress:(HttpUploadProgress)progress{
    [self networkStatusIsReachability];
    
    [[AppNetworking shareManager] POST:urlString parameters:operations constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSUInteger i = 0;
        /* 出于性能考虑，将上传图片进行压缩 */
        for (UIImage *image in imageArray) {
            NSData *imgData = UIImageJPEGRepresentation(image, .5);
            //在网络开发中，上传文件时，是文件不允许被覆盖，文件重名
            //要解决此问题
            //可以在上传时使用当前的系统事件作为文件名
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            //设置时间格式
            formatter.dateFormat = @"yyyMMddHHmmss";
            NSString *str = [formatter stringFromDate:[NSDate date]];
            NSString *fileName = [NSString stringWithFormat:@"%@.png",str];
            //将得到的二进制图片拼接到表单中  （data：指定上传的二进制流；parameter：服务器端所需参数名）
            [formData appendPartWithFileData:imgData name:parameter fileName:fileName mimeType:@"image/png"];
            i ++;
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        float progressfloat = 1.0 *uploadProgress.completedUnitCount/uploadProgress.totalUnitCount;
        progress(progressfloat);
        NSLog(@"%f...jindu",progressfloat);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (successBlock) {
            successBlock(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSError *underError = error.userInfo[@"NSUnderlyingError"];
        NSData *responseData = underError.userInfo[@"com.alamofire.serialization.response.error.data"];
        NSString *result = [[NSString alloc] initWithData:responseData  encoding:NSUTF8StringEncoding];
        NSLog(@"Error结果：%@  %@",result,error);
        failureBlock(error);
        //        [self dismissLoading];
    }];
}

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
             withDownLoadProgress:(HttpDownloadProgress)progress
{
    [self networkStatusIsReachability];
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [[manager downloadTaskWithRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]] progress:^(NSProgress * _Nonnull downloadProgress) {
        float progressfloat = 1.0 * downloadProgress.completedUnitCount / downloadProgress.totalUnitCount;
        progress(progressfloat);
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        return [NSURL fileURLWithPath:savePath];
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        if (error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }else{
            NSDictionary *dic = @{@"filePath":filePath};
            successBlock(dic);
        }
    }] resume];
}

#pragma mark - 取消所有的网络请求
/* 取消所有的网络请求 */
+(void)cancelAllRequest{
    [[AppNetworking shareManager].operationQueue cancelAllOperations];
}

#pragma mark - 取消指定的URL请求
/* 取消指定的URL请求
 * @param requestType 该请求的请求类型
 * @param string            该请求的完整URL
 */
+(void)cancelHttpRequestWithRequestType:(NSString *)requestType
                       requestUrlString:(NSString *)string{
    NSError *error;
    /* 根据请求的类型以及请求的URL创建一个NSMutableURLRequest - 通过该URL去匹配请求队列中是否有该URL，如果有的话取消该请求*/
    NSString *urlToPeCanced = [[[[AppNetworking shareManager].requestSerializer requestWithMethod:requestType URLString:string parameters:nil error:&error] URL] path];
    for (NSOperation *operation in [AppNetworking shareManager].operationQueue.operations) {
        //如果是请求队列
        if ([operation isKindOfClass:[NSURLSessionTask class]]) {
            //请求的类型匹配
            BOOL hasMatchRequestType = [requestType isEqualToString:[[(NSURLSessionTask *)operation currentRequest] HTTPMethod]];
            //请求的URL匹配
            BOOL hasMatchRequestUrlString = [urlToPeCanced isEqualToString:[[[(NSURLSessionTask *)operation currentRequest] URL] path]];
            //两项都匹配的话取消该请求
            if (hasMatchRequestType && hasMatchRequestUrlString) {
                [operation cancel];
            }
        }
    }
}


#pragma mark - 缓存处理方法
+ (BOOL)saveJsonResponseToCacheFile:(id)jsonResponse andURL:(NSString *)URL{
    NSDictionary *json = jsonResponse;
    NSString *path = [self cacheFilePathWithURL:URL];
    YYCache *cache = [[YYCache alloc] initWithPath:path];
    if (json != nil) {
        BOOL state = [cache containsObjectForKey:URL];
        [cache setObject:json forKey:URL];
        if (state) {
            NSLog(@"缓存写入/更新成功");
        }
        return state;
    }
    return NO;
}
+ (id)cacheJsonWithURL:(NSString *)URL{
    id cacheJson;
    NSString *path = [self cacheFilePathWithURL:URL];
    YYCache *cache = [[YYCache alloc] initWithPath:path];
    BOOL state = [cache containsObjectForKey:URL];
    if (state) {
        cacheJson = [cache objectForKey:URL];
    }
    return cacheJson;
}

+ (NSString *)cacheFilePathWithURL:(NSString *)URL{
    NSString *pathOfLibrary = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *path = [pathOfLibrary stringByAppendingPathComponent:@"bcwYYcache"];
    [self checkDirectory:path];//check路径
    //文件名
    NSString *cacheFileNameString = [NSString stringWithFormat:@"URL:%@ AppVersion:%@",URL,BundleVersion];
    NSString *cacheFileName = [AppCommon md5:cacheFileNameString];
    path = [path stringByAppendingString:cacheFileName];
    return path;
}

+ (void)checkDirectory:(NSString *)path{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir;
    if (![fileManager fileExistsAtPath:path isDirectory:&isDir]) {
        [self creatBaseDirectoryAtPath:path];
    }else{
        if (!isDir) {
            NSError *error = nil;
            [fileManager removeItemAtPath:path error:&error];
            [self creatBaseDirectoryAtPath:path];
        }
    }
}
+ (void)creatBaseDirectoryAtPath:(NSString *)path{
    __autoreleasing NSError *error = nil;
    [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    if (error) {
        NSLog(@"creat cache directory failed, error = %@",error);
    }else{
        [self addDoNotBackupAttribute:path];
    }
}
+ (void)addDoNotBackupAttribute:(NSString *)path{
    NSURL *url = [NSURL fileURLWithPath:path];
    NSError *error = nil;
    [url setResourceValue:[NSNumber numberWithBool:YES] forKey:NSURLIsExcludedFromBackupKey error:&error];
    if (error) {
        NSLog(@"error to set do not backup attribute, error = %@",error);
    }
}

/**
 * 开启网络状态监听
 */
+ (void)networkReachabilityMonitoring {
    
    _reachablityManager = [AFNetworkReachabilityManager manager];
    [_reachablityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        switch (status) {
            case AFNetworkReachabilityStatusNotReachable: {
                NSLog(@"网络不可用");
//                [self showErrorText:@"您的网络不可用，请检查网络"];
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                NSLog(@"Wifi已开启");
                break;
            }
            case AFNetworkReachabilityStatusReachableViaWWAN: {
                NSLog(@"你现在使用的流量");
                break;
            }
            case AFNetworkReachabilityStatusUnknown: {
                NSLog(@"你现在使用的未知网络");
                break;
            }
            default:
                break;
        }
    }];
    
    [_reachablityManager startMonitoring];
}

/**
 * 获取当前网络状态
 */
+ (BOOL)networkStatusIsReachability {
    
    BOOL notReachable = _reachablityManager.networkReachabilityStatus == AFNetworkReachabilityStatusNotReachable;
    
    if (notReachable) {
//        [self showErrorText:@"您的网络不可用，请检查网络"];
    }
    return !notReachable;
}



@end
