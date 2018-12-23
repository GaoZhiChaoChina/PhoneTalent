//
//  AppSystemManager.m
//  DemoText
//
//  Created by gaozhichao on 2016/12/14.
//  Copyright © 2016年 gaozhichao. All rights reserved.
//

#import "AppSystemManager.h"

@implementation AppSystemManager

+(id)app_getSystemInfo:(AppSystemInfoType)appInfoType{
    
     NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
     NSString *info = @"";
     switch (appInfoType) {
        case APP_CFAllInfoMessage:{
            return infoDictionary;}break;
        case APP_CFBundleDisplayName:{
            info = [infoDictionary objectForKey:@"CFBundleDisplayName"];}break;
        case APP_CFBundleShortVersionString:{
            info = [infoDictionary objectForKey:@"CFBundleShortVersionString"];}break;
        case APP_CFBundleVersion:{
            info = [infoDictionary objectForKey:@"CFBundleVersion"];}break;
        case APP_CFBundleIdentifier:{
            info = [infoDictionary objectForKey:@"CFBundleIdentifier"];}break;
        default:
            break;
    }
    return info;
}

@end
