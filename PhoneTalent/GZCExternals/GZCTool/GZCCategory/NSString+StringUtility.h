//
//  NSString+StringUtility.h
//  Ule
//
//  Created by eachnet on 11/30/12.
//  Copyright (c) 2012 Ule. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (StringUtility)


/**
 字符串採用MD5加密
 @returns   返回使用MD5加密後的字符串
 */
- (NSString *) stringFromMD5;

/*
 加密函数
 param: key 密钥
 param: data 需要加密的字符串
*/
+ (NSString *)HMACMD5WithKey:(NSString *)key andData:(NSString *)data;

- (NSArray *)allURLs;

- (NSString *)urlByAppendingDict:(NSDictionary *)params;
- (NSString *)urlByAppendingArray:(NSDictionary *)params;
- (NSString *)urlByAppendingKeyValues:(NSDictionary *)first,...;

- (NSString *)queryStringFromDictionary:(NSDictionary *)dict;
- (NSString *)queryStringFromArray:(NSArray *)array;
- (NSString *)queryStringFromKeyValues:(id)first, ...;

- (NSString *)URLEncoding;
- (NSString *)URLDecoding;

- (BOOL)is:(NSString *)other;

- (BOOL)isValueOf:(NSArray *)array;
- (BOOL)isValueOf:(NSArray *)array caseInsens:(BOOL)caseInsens;

// 去掉html格式和转义字符
+ (NSString *)filterHtmlTag:(NSString *)html trimWhiteSpace:(BOOL)trim;
// 解析html,带有imgurl链接的
+ (NSString *)filterHtmlWithImgUrl:(NSString *)html;
//去掉html和前后空格
+(NSString*) replaceHtmlAndSpace:(NSString*)listNameRef;

@end
