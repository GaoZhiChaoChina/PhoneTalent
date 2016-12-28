//
//  NSString+UtililySkills.m
//  TextDemo
//
//  Created by gaozhichao on 19/1/16.
//  Copyright © 2016年 gaozhichao. All rights reserved.
//

#import "NSString+UtililySkills.h"
#import <CommonCrypto/CommonDigest.h>
#import "RegexKitLite.h"

const NSString* REG_EMAIL = @"\\w+([-+.]\\w+)*@\\w+([-.]\\w+)*\\.\\w+([-.]\\w+)*";
const NSString* REG_MOBILE = @"^(13[0-9]|15[0-9]|18[0-9]|14[0-9]|17[0-9])\\d{8}$";
const NSString* REG_PHONE = @"^(([0\\+]\\d{2,3}-?)?(0\\d{2,3})-?)?(\\d{7,8})";//(-(\\d{3,}))?$";

@implementation NSString (UtililySkills)

- (NSString *)gzc_UnderlineFromCamel{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    for (NSUInteger i = 0; i<self.length; i++) {
        unichar c = [self characterAtIndex:i];
        NSString *cString = [NSString stringWithFormat:@"%c", c];
        NSString *cStringLower = [cString lowercaseString];
        if ([cString isEqualToString:cStringLower]) {
            [string appendString:cStringLower];
        } else {
            [string appendString:@"_"];
            [string appendString:cStringLower];
        }
    }
    return string;
}

- (NSString *)gzc_CamelFromUnderline{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    NSArray *cmps = [self componentsSeparatedByString:@"_"];
    for (NSUInteger i = 0; i<cmps.count; i++) {
        NSString *cmp = cmps[i];
        if (i && cmp.length) {
            [string appendString:[NSString stringWithFormat:@"%c", [cmp characterAtIndex:0]].uppercaseString];
            if (cmp.length >= 2) [string appendString:[cmp substringFromIndex:1]];
        } else {
            [string appendString:cmp];
        }
    }
    return string;
}

+(NSString*)gzc_getSafeEmpty:(NSString*)str{
    return (str==nil?@"":str);
}

+ (int)gzc_calc_charsetNum:(NSString *)str{
    
    unsigned result = 0;
    const char *tchar = [str UTF8String];
    if (NULL == tchar) {
        return result;
    }
    
    result = strlen(tchar);
    
    return result;
}

+ (int)gzc_convertToInt:(NSString *)str
{
    int strlength   =   0;
    char *  p   =   (char *)[str cStringUsingEncoding:NSUnicodeStringEncoding];
    for (int i = 0; i < [str lengthOfBytesUsingEncoding:NSUnicodeStringEncoding]; i++)
    {
        if (*p)
        {
            p++;
            strlength++;
        }
        else
        {
            p++;
        }
    }
    return strlength;
}

- (NSString *)gzc_FirstCharCapital{
    if (self.length == 0) return self;
    
   
    
    NSMutableString *string = [NSMutableString string];
    //1、不同单词首字母都大写
    string = (NSMutableString*)[self capitalizedString];
    
    //2、首个单词首字母大写
//    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].uppercaseString];
//    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];

    return string;
}

- (NSString *)gzc_FirstCharLowercase{
    if (self.length == 0) return self;
    NSMutableString *string = [NSMutableString string];
    //1、不同单词首字母都小写
    string = (NSMutableString*)[self lowercaseString];
    
    //2、首个单词首字母小写
//    [string appendString:[NSString stringWithFormat:@"%c", [self characterAtIndex:0]].lowercaseString];
//    if (self.length >= 2) [string appendString:[self substringFromIndex:1]];
    return string;
}

- (NSArray *)gzc_SeparatedByString:(NSString *)separatedString{

    NSArray *array = [self componentsSeparatedByString:separatedString];
    return array;
}

+(NSString*)gzc_stripWhiteSpace:(NSString*)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+(NSString*)gzc_stripWhiteSpaceAndNewLineCharacter:(NSString*)str{
    return [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

- (NSURL *)gzc_urlUtf8StringEncoding{
    return [NSURL URLWithString:(NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault, (CFStringRef)self, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL,kCFStringEncodingUTF8))];
}

+(NSString*)gzc_urlUtf8StringEncoding:(NSString*)urlString{
    
    @try {
        
        //        NSString * urlstr = [urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding];
        
        NSString *charactersToEscape = @"!*'();:@&=+$,%#[]\" ";
        NSCharacterSet *customEncodingSet = [[NSCharacterSet characterSetWithCharactersInString:charactersToEscape] invertedSet];
        NSString *urlstr = [urlString stringByAddingPercentEncodingWithAllowedCharacters:customEncodingSet];
        
        if ([NSString gzc_isEmpty:urlstr]) {
            urlstr=urlString;
        }
        return urlstr;
    }
    @catch (NSException *exception) {
        
        return  urlString;
    }
    
}

+(BOOL)gzc_isEmpty:(NSString *)input{
    
    NSString *newStr=[NSString gzc_stripWhiteSpace:input];
    if ([newStr isEqualToString:@""]||newStr==nil) {
        return true;
    }
    return false;
}

- (BOOL)gzc_empty{
    return [self length] > 0 ? NO : YES;
}

+(BOOL)gzc_isEmail:(NSString *)input{
    return [input isMatchedByRegex:[NSString stringWithFormat:@"%@",REG_EMAIL]];
}

+(BOOL)gzc_isPhoneNum:(NSString *)input{
    return [input isMatchedByRegex:[NSString stringWithFormat:@"%@",REG_PHONE]];
}

+(BOOL)gzc_isMobileNum:(NSString *)input{
    return [input isMatchedByRegex:[NSString stringWithFormat:@"%@",REG_MOBILE]];
}

+(NSString*)gzc_md5Encrypt:(NSString*)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5( cStr, strlen(cStr), result );
    return [[NSString
             stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
             result[0], result[1],
             result[2], result[3],
             result[4], result[5],
             result[6], result[7],
             result[8], result[9],
             result[10], result[11],
             result[12], result[13],
             result[14], result[15]
             ] lowercaseString];
}
- (NSString *)gzc_stringByURLEncodingString {
    CFStringRef encoded = CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                  (CFStringRef) self,
                                                                  NULL,
                                                                  (CFStringRef) @"!*'\"();:@&=+$,/?%#[]% ",
                                                                  kCFStringEncodingUTF8);
    return (NSString *) CFBridgingRelease(encoded);
}

+(NSString*)gzc_randomStr:(NSString*) text
          separatedStr:(NSString*)separatedStr{
    
    NSString * backStr=@"";
    if (![self gzc_isEmpty:text]) {
        
        NSArray *textArray=[text componentsSeparatedByString:separatedStr];
        backStr=text;
        
        if (textArray.count) {
            
            int randomNum= arc4random() % textArray.count;
            if (randomNum<textArray.count) {
                
                backStr=[textArray objectAtIndex:randomNum];
            }
            else{ //以防万一，数组越界的情况，取最后一个
                backStr=[textArray objectAtIndex:textArray.count-1];
            }
            
        }
    }
    return  backStr;
    
}

//手机号码马赛克
+(NSString*)gzc_mosaicMobilePhone:(NSString*) mobilePhone{

    //判断是否正常手机
    if (mobilePhone.length==11) {
        
        //获得中间的4位
        NSString *newPhone=[NSString stringWithFormat:@"***%@****"
                            , [mobilePhone substringWithRange:NSMakeRange(3, 4)]];
        return newPhone;
    }
    return  mobilePhone;
}

+ (NSString *)gzc_stringToDate:(NSString *)input OldDateFormat:(NSString *)oldDate NewDateFormat:(NSString *)newDate
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
    [inputFormatter setDateFormat:oldDate];
    NSDate* inputDate = [inputFormatter dateFromString:input];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setLocale:[NSLocale currentLocale]];
    [outputFormatter setDateFormat:newDate];
    NSString *str = [outputFormatter stringFromDate:inputDate];
    
    return str;
}

//日期转字符串格式4
+(NSString*)gzc_dateToStringWithFormat:(NSDate*)date format:(NSString *) _format{
    //得到毫秒
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    //[dateFormatter setDateFormat:@"hh:mm:ss"]
    [dateFormatter setDateFormat:_format];//@"yyyy-MM-dd hh:mm:ss"
    //NSLog(@"Date%@", [dateFormatter stringFromDate:[NSDate date]]);
    NSString *currentdt = [dateFormatter stringFromDate:date];
    return currentdt;
}


@end
