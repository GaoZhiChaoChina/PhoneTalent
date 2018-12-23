//
//  FFDeviceInfoManager.h
//  FeiFan
//
//  Created by Gabriel Li on 6/1/15.
//  Copyright (c) 2015 Wanda Inc. All rights reserved.
//

#import <Foundation/Foundation.h>
//#import "FFSingleton.h"
#import <CoreGraphics/CGBase.h>

/**
 *  单例函数声明
 *
 *  @param __class ClassName
 */
#undef  FF_AS_SINGLETON
#define FF_AS_SINGLETON( __class ) \
+ (__class *)sharedInstance;


/**
 *  单例函数实现
 *
 *  @param __class ClassName
 */
#undef  FF_DEF_SINGLETON
#define FF_DEF_SINGLETON( __class ) \
+ (__class *)sharedInstance \
{ \
static id __singleton__ = nil; \
@synchronized(self) { \
if (!__singleton__) { \
__singleton__ = [[self alloc] init]; \
} \
} \
return __singleton__; \
}

@interface FFDeviceInfoManager : NSObject

FF_AS_SINGLETON(FFDeviceInfoManager)
/** 记录当前的屏幕亮度 **/
@property (nonatomic, assign) CGFloat currentBrightness;

- (void)restoreBrightness;
- (void)restoreBrightnessWhenApplicationDidEnterBackground;
- (void)setMaxiumBrightness;
- (void)setMaxiumBrightnessWhenApplicationWillEnterForeground;

+ (NSString *)ffOpenUDID;

@end
