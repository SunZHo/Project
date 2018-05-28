//
//  UserInfoCache.h
//  duojie
//
//  Created by Joke on 2017/5/12.
//  Copyright © 2017年 多赚. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfoCache : NSObject

+ (BOOL)archiveUserInfo:(id)rootObject keyedArchiveName:(NSString *)keyedArchiveName ;

+ (id)unarchiveUserInfo:(NSString *)filePath ;

//删除缓存文件
+ (BOOL)removeUserInfoFileExistsAtPath:(NSString *)filePath;

//删除缓存目录
+ (BOOL)removeCache;

@end
