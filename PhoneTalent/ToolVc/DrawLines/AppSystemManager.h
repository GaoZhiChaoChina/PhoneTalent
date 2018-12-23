//
//  AppSystemManager.h
//  DemoText
//
//  Created by gaozhichao on 2016/12/14.
//  Copyright © 2016年 gaozhichao. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,AppSystemInfoType){
    APP_CFAllInfoMessage,//默认从0开始
    APP_CFBundleDisplayName,// app名称
    APP_CFBundleShortVersionString,// app版本
    APP_CFBundleVersion,// app build版本
    APP_CFBundleIdentifier,//BundleID
};

@interface AppSystemManager : NSObject

/**
 获取app配置信息

 @param appInfoType 配置信息类型
 @return 返回获取信息
 */
+ (id)app_getSystemInfo:(AppSystemInfoType)appInfoType;
@end
