//
//  GZCFileController.h
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZCFileController : NSObject

//获得document
+(NSString *)documentsPath;

//读取工程文件
+(NSString *) productPath:(NSString*)filename;

//获得document文件路径
+(NSString *) DocumentPath:(NSString *)filename;

//写入文件 Array 沙盒
+(void)saveOrderArrayList:(NSMutableArray *)list  FileUrl :(NSString*) FileUrl;

//写入文件 Array 沙盒 序列化内容
+ (void)saveArrayClassList:(NSMutableArray*)array forKey:(NSString*)key withFileName:(NSString*)fName withSort:(BOOL)isSort;

//读取文件 沙盒 序列化内容
+ (id)readClassFile:(NSString*)key withFileName:(NSString*)fName;

//写入文件 Array 工程
+(void)saveOrderArrayListProduct:(NSMutableArray *)list  FileUrl :(NSString*) FileUrl;

//写入文件存放到工程位置NSDictionary
+(void)saveNSDictionaryForProduct:(NSDictionary *)list  FileUrl:(NSString*) FileUrl;

//写入文件沙盒位置NSDictionary
+(void)saveNSDictionaryForDocument:(NSDictionary *)list  FileUrl:(NSString*) FileUrl;

//加载文件沙盒NSDictionary
+(NSDictionary *)loadNSDictionaryForDocument  : (NSString*) FileUrl;

//加载文件工程位置NSDictionary
+(NSDictionary *)loadNSDictionaryForProduct   : (NSString*) FileUrl;

//加载文件沙盒NSArray
+(NSArray *)loadArrayList   : (NSString*) FileUrl;

//加载文件工程位置NSArray
+(NSArray *)loadArrayListProduct   : (NSString*) FileUrl;

//判断文件是否存在
+(BOOL) FileIsExists:(NSString*) checkFile;

//拷贝文件到沙盒
+(int) CopyFileToDocument:(NSString*)FileName;

//添加文件到沙盒 已存在 覆盖20150206
+(NSInteger) AddFileToDocument:(NSString*)FileName;

+(NSString*) backPath:(FileMode) sourceMode  path:(NSString*)path;

+(BOOL) createDirectory:(NSString*) path   isDir:(BOOL)isDir;
@end
