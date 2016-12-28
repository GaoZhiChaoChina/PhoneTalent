//
//  GZCFileController.m
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCFileController.h"

@implementation GZCFileController

//获得document
+(NSString *)documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    return [paths objectAtIndex:0];
}

//读取工程文件
+(NSString *) productPath:(NSString*)filename{
    
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@""];
    return  path;
}

//获得document文件路径
+(NSString *) DocumentPath:(NSString *)filename {
    NSString *documentsPath = [self documentsPath];
    // NSLog(@"documentsPath=%@",documentsPath);
    return [documentsPath stringByAppendingPathComponent:filename];
}

//写入文件沙盒位置NSDictionary
+(void)saveNSDictionaryForDocument:(NSDictionary *)list  FileUrl:(NSString*) FileUrl  {
    
    NSString *f = [self DocumentPath:FileUrl];
    
    [list writeToFile:f atomically:YES];
}

//写入文件存放到工程位置NSDictionary
+(void)saveNSDictionaryForProduct:(NSDictionary *)list  FileUrl:(NSString*) FileUrl  {
    
    NSString *ProductPath =[[NSBundle mainBundle]  resourcePath];
    NSString *f=[ProductPath stringByAppendingPathComponent:FileUrl];
    
    [list writeToFile:f atomically:YES];
}

//写入文件 Array 工程
+(void)saveOrderArrayListProduct:(NSMutableArray *)list  FileUrl :(NSString*) FileUrl {
    
    NSString *ProductPath =[[NSBundle mainBundle]  resourcePath];
    NSString *f=[ProductPath stringByAppendingPathComponent:FileUrl];
    
    [list writeToFile:f atomically:YES];
}
//写入文件 Array 沙盒
+(void)saveOrderArrayList:(NSMutableArray *)list  FileUrl :(NSString*) FileUrl {
    NSString *f = [self DocumentPath:FileUrl];
    
    [list writeToFile:f atomically:YES];
}

//写入文件 Array 沙盒 序列化内容
+ (void)saveArrayClassList:(NSMutableArray*)array forKey:(NSString*)key withFileName:(NSString*)fName withSort:(BOOL)isSort
{
    //排序字典
    if (isSort) {
        [array sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
            NSInteger num1 = [obj1[@"priority"] integerValue];
            NSInteger num2 = [obj2[@"priority"] integerValue];
            if (num1 < num2) {
                return NSOrderedAscending;
            }
            return NSOrderedDescending;
        }];
    }
    NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDirectory = [path objectAtIndex:0];
    @try {
        if (documentDirectory)
        {
            NSString *fileName = [documentDirectory stringByAppendingPathComponent:fName];
            if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
            {
                NSMutableDictionary *saveDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
                //NSData *encodedCurBirdSightingList = [NSKeyedArchiver archivedDataWithRootObject:array];
                [saveDic setObject:array forKey:key];
                BOOL iResult = [saveDic writeToFile:fileName atomically:NO];
                if (iResult) {
                    NSLog(@"______________");
                }
                
            }
            else
            {
                NSMutableDictionary *saveDic = [[NSMutableDictionary alloc] init];
                [saveDic setObject:array forKey:key];
                [saveDic writeToFile:fileName atomically:NO];
                
            }
        }
    }
    @catch (NSException* e) {
    }
}
//读取文件 沙盒 序列化内容
+ (id)readClassFile:(NSString*)key withFileName:(NSString*)fName
{
    id result = nil;
    @try {
       	NSArray *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentDirectory = [path objectAtIndex:0];
        
        if (documentDirectory)
        {
            NSString *fileName = [documentDirectory stringByAppendingPathComponent:fName];
            if ([[NSFileManager defaultManager] fileExistsAtPath:fileName])
            {
                NSMutableDictionary *saveDic = [[NSMutableDictionary alloc] initWithContentsOfFile:fileName];
                //NSData *savedEncodedData = [saveDic objectForKey:key];
                //result = (NSMutableArray *)[NSKeyedUnarchiver unarchiveObjectWithData:savedEncodedData];
                result = (NSMutableArray *)[saveDic objectForKey:key];
                return result;
            }
        }
    }
    @catch (NSException *exception) {
    }
    @finally {
        return result;
    }
}


//加载文件沙盒NSDictionary
+(NSDictionary *)loadNSDictionaryForDocument  : (NSString*) FileUrl {
    
    NSString *f = [self DocumentPath:FileUrl];
    NSDictionary *list = [ [NSDictionary alloc] initWithContentsOfFile:f];
    
    return list;
}

//加载文件工程位置NSDictionary
+(NSDictionary *)loadNSDictionaryForProduct   : (NSString*) FileUrl {
    
    NSString *f = [self productPath:FileUrl];
    NSDictionary *list =[NSDictionary dictionaryWithContentsOfFile:f];
    
    return list;
}


//加载文件沙盒NSArray
+(NSArray *)loadArrayList   : (NSString*) FileUrl {
    
    NSString *f = [self DocumentPath:FileUrl];
    
    NSArray *list = [NSArray  arrayWithContentsOfFile:f];
    
    return list;
}

//加载文件工程位置NSArray
+(NSArray *)loadArrayListProduct   : (NSString*) FileUrl {
    
    NSString *f = [self productPath:FileUrl];
    
    NSArray *list = [NSArray  arrayWithContentsOfFile:f];
    
    return list;
}

//拷贝文件到沙盒
+(int) CopyFileToDocument:(NSString*)FileName{
    
    
    NSString *appFileName =[self DocumentPath:FileName];
    
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //判断沙盒下是否存在
    BOOL isExist = [fm fileExistsAtPath:appFileName];
    
    if (!isExist)   //不存在，把工程的文件复制document目录下
    {
        
        //获取工程中文件
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  pathForResource:FileName
                                  ofType:@""];
        
        //这一步实现数据库的添加，
        // 通过NSFileManager 对象的复制属性，把工程中数据库的路径复制到应用程序的路径上
        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:appFileName error:nil];
        
        return cp;
        
    } else {
        
        return  -1; //已经存在
    }
    
}

//添加文件到沙盒 已存在覆盖 20150206
+(NSInteger) AddFileToDocument:(NSString*)FileName
{
    NSString *appFileName =[self DocumentPath:FileName];
    
    
    NSFileManager *fm = [NSFileManager defaultManager];
    
    //判断沙盒下是否存在
    BOOL isExist = [fm fileExistsAtPath:appFileName];
    
    if (!isExist)   //不存在，把工程的文件复制document目录下
    {
        //获取工程中文件
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  pathForResource:FileName
                                  ofType:@""];
        //这一步实现数据库的添加，
        // 通过NSFileManager 对象的复制属性，把工程中数据库的路径复制到应用程序的路径上
        BOOL cp = [fm copyItemAtPath:backupDbPath toPath:appFileName error:nil];
        
        return cp;
        
    } else {
        //获取工程中文件
        NSString *backupDbPath = [[NSBundle mainBundle]
                                  pathForResource:FileName
                                  ofType:@""];
        BOOL move = [fm removeItemAtPath:appFileName error:nil];
        if (move) {
            BOOL cp=[fm copyItemAtPath:backupDbPath toPath:appFileName error:nil];
            return cp;
        }
        return  -1; //失败
    }
}

//判断文件是否存在
+(BOOL) FileIsExists:(NSString*) checkFile{
    
    if([[NSFileManager defaultManager]fileExistsAtPath:checkFile])
    {
        return true;
    }
    return  false;
    
}

+(NSString*) backPath:(FileMode) sourceMode  path:(NSString*)path{
    
    NSString *filepath=@"";
    if (sourceMode==FileModeProduct) {
        
        filepath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    }
    else{
        
        filepath = [GZCFileController DocumentPath:path];
    }
    
    return filepath;
}

+(BOOL) createDirectory:(NSString*) path   isDir:(BOOL)isDir{
    
    NSFileManager *filesManager = [NSFileManager defaultManager];
    BOOL existed = [filesManager fileExistsAtPath:path isDirectory:&isDir];
    
    if (!existed )//不存在该目录,则创建目录
    {
        return    [filesManager createDirectoryAtPath:path
                          withIntermediateDirectories:YES
                                           attributes:nil
                                                error:nil];
    }
    
    return true;
}

@end
