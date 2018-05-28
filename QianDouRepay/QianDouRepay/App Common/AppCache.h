//
//  AppCache.h
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/4.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppCache : NSObject

/**
 写入缓存

 @param rootObject 文件
 @param keyedArchiveName 文件名
 @return -
 */
+ (BOOL)archive:(id)rootObject keyedArchiveName:(NSString *)keyedArchiveName ;


/**
 取出缓存

 @param filePath 文件名
 @return -
 */
+ (id)unarchive:(NSString *)filePath ;

//删除缓存文件
+ (BOOL)removeFileExistsAtPath:(NSString *)filePath;

//删除缓存目录
+ (BOOL)removeCache;

@end
