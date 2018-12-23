//
//  FFDeviceInfoManager.m
//  FeiFan
//
//  Created by Gabriel Li on 6/1/15.
//  Copyright (c) 2015 Wanda Inc. All rights reserved.
//

#import "FFDeviceInfoManager.h"

#import <UIKit/UIKit.h>
static NSString *FFOpenUDIDKey = @"FFOpenUDIDKey";

@interface FFDeviceInfoManager ()

/** 记录上一次的屏幕亮度 **/
@property (nonatomic, assign) CGFloat prevBrightness;

@end

@implementation FFDeviceInfoManager

FF_DEF_SINGLETON(FFDeviceInfoManager)
- (id)init
{
    self = [super init];
    if (self)
    {
        _prevBrightness = [UIScreen mainScreen].brightness;
    }
    return self;
}

- (CGFloat)currentBrightness
{
    return [UIScreen mainScreen].brightness;
}

- (void)setCurrentBrightness:(CGFloat)currentBrightness
{
    if (fabs([UIScreen mainScreen].brightness - currentBrightness) > 0.01f) {
        [UIScreen mainScreen].brightness = currentBrightness;
    }
}

- (void)setPrevBrightness:(CGFloat)prevBrightness
{
    if (prevBrightness < 0.0f || prevBrightness > 1.0f) {
        prevBrightness = MAXFLOAT;
    }
    
    _prevBrightness = prevBrightness;
}

- (void)setMaxiumBrightness
{
    self.prevBrightness = self.currentBrightness;
    self.currentBrightness = 1.0f;
    [UIApplication sharedApplication].idleTimerDisabled = YES;
}

- (void)setMaxiumBrightnessWhenApplicationWillEnterForeground
{
    if (self.prevBrightness != MAXFLOAT)
    {
        self.prevBrightness = self.currentBrightness;
        self.currentBrightness = 1.0f;
        [UIApplication sharedApplication].idleTimerDisabled = YES;
    }
}

- (void)restoreBrightness
{
    if (self.prevBrightness != MAXFLOAT) {
        self.currentBrightness = self.prevBrightness;
    }
    
    self.prevBrightness = MAXFLOAT;

    [UIApplication sharedApplication].idleTimerDisabled = NO;

}

- (void)restoreBrightnessWhenApplicationDidEnterBackground
{
    if (self.prevBrightness != MAXFLOAT) {
        self.currentBrightness = self.prevBrightness;
    }

    
    [UIApplication sharedApplication].idleTimerDisabled = NO;

}

@end
