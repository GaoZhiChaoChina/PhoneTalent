//
//  NSString+JsonToDic.h
//  DemoText
//
//  Created by gaozhichao on 2016/12/16.
//  Copyright © 2016年 gaozhichao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (JsonToDic)
/*!
 * @brief 把格式化的JSON格式的字符串转换成字典
 * @param jsonString JSON格式的字符串
 * @return 返回字典
 */
+ (NSDictionary *)dictionaryWithJsonString:(NSString *)jsonString;
@end
