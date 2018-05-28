//
//  UserInfoCache.m
//  duojie
//
//  Created by Joke on 2017/5/12.
//  Copyright © 2017年 多赚. All rights reserved.
//

#import "UserInfoCache.h"

@implementation UserInfoCache

//写入
+ (BOOL)archiveUserInfo:(id)rootObject keyedArchiveName:(NSString *)keyedArchiveName {
    
    NSString *keyedArchivePath = [self checkFiletPath:keyedArchiveName];
    return [NSKeyedArchiver archiveRootObject:rootObject toFile:keyedArchivePath];
}
//取出
+ (id)unarchiveUserInfo:(NSString *)filePath
{
    NSString *keyedArchivePath = [self checkFiletPath:filePath];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:keyedArchivePath];
}
//删除缓存文件
+ (BOOL)removeUserInfoFileExistsAtPath:(NSString *)filePath
{
    NSString *keyedArchivePath = [self checkFiletPath:filePath];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return  [fileManager removeItemAtPath:keyedArchivePath error:nil];
}
//删除缓存目录
+ (BOOL)removeCache {
    NSString *tmpFile = [self dataFilePath];
    if ([self isDirectoryExist:tmpFile] == NO) {
        return YES;
    }
    NSFileManager *fileManager = [NSFileManager defaultManager];
    return  [fileManager removeItemAtPath:tmpFile error:nil];
}
+(NSString *)checkFiletPath:(NSString *)keyedArchiveName{
    if ([keyedArchiveName rangeOfString:@"/"].location != NSNotFound) {
        keyedArchiveName = [keyedArchiveName stringByReplacingOccurrencesOfString:@"/" withString:@""];
    }
    //判断文件是否存在
    NSString *filePath = [self dataFilePath];
    if ([self isDirectoryExist:filePath] == NO) {
        [self createDirectory:filePath];
    }
    NSString *keyedArchivePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",keyedArchiveName]];
    return keyedArchivePath;
}
//文件
+(NSString *)dataFilePath
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"UserInfoCache"];
    // return [documentDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",headPath]];
}
+ (BOOL)isDirectoryExist:(NSString *)directoryPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL isDir = YES;
    BOOL result = [fileManager fileExistsAtPath:directoryPath isDirectory:&isDir];
    if (result == YES) {
        if (isDir == NO) {
            result = NO;
        }
    }
    return result;
}
+ (BOOL)createDirectory:(NSString *)directoryPath {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager createDirectoryAtPath:directoryPath withIntermediateDirectories:YES attributes:nil error:nil];
    return result;
}

@end
