//
//  NSString+UtililySkills.h
//  TextDemo
//
//  Created by gaozhichao on 19/1/16.
//  Copyright © 2016年 gaozhichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UtililySkills)
/**
 *  驼峰转下划线（loveYou -> love_you）
 */
- (NSString *)gzc_UnderlineFromCamel;
/**
 *  下划线转驼峰（love_you -> loveYou）
 */
- (NSString *)gzc_CamelFromUnderline;
/**
 安全获取字符串 若字符串为nil，则返回空字符串，否则直接返回字符串
 */
+ (NSString*)gzc_getSafeEmpty:(NSString*)str;
/**
 计算string的字节数
 */
+ (int)gzc_calc_charsetNum:(NSString *)str;
/**
 计算中英文混合字符串长度
 */
+ (int)gzc_convertToInt:(NSString *)str;

/**
 * 首字母变大写
 */
- (NSString *)gzc_FirstCharCapital;
/**
 * 首字母变小写
 */
- (NSString *)gzc_FirstCharLowercase;
/**
 * 分割字符串
 */
- (NSArray *)gzc_SeparatedByString:(NSString *)separatedString;
/**
 去掉首尾空格
 */
+ (NSString*)gzc_stripWhiteSpace:(NSString*)str;
/**
 去掉首尾空格和换行符
 */
+ (NSString*)gzc_stripWhiteSpaceAndNewLineCharacter:(NSString*)str;
/**
 *  utf8编码、1
 */
- (NSURL *)gzc_urlUtf8StringEncoding;
/**
 *  utf8编码、2
 */
+(NSString*)gzc_urlUtf8StringEncoding:(NSString*)urlString;
/**
 *  字符串为空(首尾可能存在 空格 换行符)
 */
- (BOOL)gzc_empty;
/**
 *  判断字符串为空（去首尾除空格换行符）
 */
+ (BOOL)gzc_isEmpty:(NSString *)input;
/**
 判断字符串是否符合Email格式。
 */
+ (BOOL)gzc_isEmail:(NSString *)input;
/**
 判断字符串是否符合手机号格式。
 */
+ (BOOL)gzc_isPhoneNum:(NSString *)input;
/**
 判断字符串是否符合电话格式。
 */
+ (BOOL)gzc_isMobileNum:(NSString *)input;
/**
 将字符串转换为MD5码
 */
+ (NSString*)gzc_md5Encrypt:(NSString*)str;
/**
 将字符串转换为MD5码
 @returns   返回過濾掉關鍵字符後的UTF8編碼的字符串
 */
- (NSString *)gzc_stringByURLEncodingString;
/**
 生成随机数字符串(text:字符串      separatedStr:分割符)
 @param text 字符串
 @param separatedStr 分割符
 @return   返回新字符串
 */
+(NSString*)gzc_randomStr:(NSString*) text
          separatedStr:(NSString*)separatedStr;
/**
 *  手机号码马赛克（指定号码变****）
 */
+(NSString*)gzc_mosaicMobilePhone:(NSString*) mobilePhone;

/**
 将NSString类型日期值转换为指定格式日期类型值
 @param input 字符串
 @param oldDate 原日期格式
 @param newDate 新日期格式
 @returns   返回新字符串
 */
+ (NSString *)gzc_stringToDate:(NSString *)input OldDateFormat:(NSString *)oldDate NewDateFormat:(NSString *)newDate;
/**
 转化为时间格式
*/
+(NSString*)gzc_dateToStringWithFormat:(NSDate*)date format:(NSString *) _format;

@end
