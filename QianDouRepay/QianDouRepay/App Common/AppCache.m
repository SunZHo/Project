//
//  AppCache.m
//  QianDouRepay
//
//  Created by <15>帝云科技 on 2018/5/4.
//  Copyright © 2018年 帝云科技<15>. All rights reserved.
//

#import "AppCache.h"

@implementation AppCache

//写入
+ (BOOL)archive:(id)rootObject keyedArchiveName:(NSString *)keyedArchiveName {
    
    NSString *keyedArchivePath = [self checkFiletPath:keyedArchiveName];
    return [NSKeyedArchiver archiveRootObject:rootObject toFile:keyedArchivePath];
}
//取出
+ (id)unarchive:(NSString *)filePath
{
    NSString *keyedArchivePath = [self checkFiletPath:filePath];
    return [NSKeyedUnarchiver unarchiveObjectWithFile:keyedArchivePath];
}
//删除缓存文件
+ (BOOL)removeFileExistsAtPath:(NSString *)filePath
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
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [paths objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"ModelCache"];
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
