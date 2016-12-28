//
//  Common.h
//  Mic
//
//  Created by chaossy on 13-12-12.
//  Copyright (c) 2013年 chaossy. All rights reserved.
//

#ifndef Mic_Common_h
#define Mic_Common_h

#if defined(DEBUG) || defined(BETA)
#define HOST        [[[NSUserDefaults standardUserDefaults] objectForKey:@"test_ip_enabled"] componentsSeparatedByString:@"#"][0]
#define EVENT_HOST  [[[NSUserDefaults standardUserDefaults] objectForKey:@"test_ip_enabled"] componentsSeparatedByString:@"#"][1]
#define VERSION     [[NSUserDefaults standardUserDefaults] objectForKey:@"test_version"]
#define URL_PATH    [[NSUserDefaults standardUserDefaults] objectForKey:@"test_url_path"]

#else

#define HOST        @"http://api.mkf.com"
#define EVENT_HOST  @"http://m.mkf.com"
#define VERSION     [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]
#define URL_PATH    @"api.php"

#endif

#define MARKET  [[[NSBundle mainBundle] infoDictionary] objectForKey:@"Market"]

#define ABOUTUS_URL @"http://app.mkf.com/aboutus.html"

#define SCORE_URL   @"http://m.mkf.com/dl/ios_jump.php"

#define kFirstTimeLaunchMCoinKey    @"FirstTimeLaunchMCoinKey"

#define ENCRYPTED @"bzmkf360.com"

#define DECLARE_SINGLETON(class)\
    + (instancetype)shared##class;

#define IMPLEMENT_SINGLETON(class)\
    + (instancetype)shared##class {\
        static class* shared##class = nil;\
        static dispatch_once_t onceToken;\
        dispatch_once(&onceToken, ^{\
            shared##class = [[self alloc] init];\
        });\
        return shared##class;\
    }

#define ScreenWidth    [[UIScreen mainScreen] bounds].size.width
#define ScreenHeight   [[UIScreen mainScreen] bounds].size.height
#define tabbarHeight    self.tabBarController.tabBar.size.height
#define ScreenContentHeight  [[UIScreen mainScreen] bounds].size.height-[[UIApplication sharedApplication] statusBarFrame].size.height-self.navigationController.navigationBar.frame.size.height

#define ScreenNoBarContentHeight [[UIScreen mainScreen] bounds].size.height-[[UIApplication sharedApplication] statusBarFrame].size.height

//#define TopBarInset    (iOSVersion < 7 ? 0 : ([UIApplication sharedApplication].statusBarFrame.size.height + self.navigationController.navigationBar.frame.size.height))
#define TopBarHeight    ([UIApplication sharedApplication].statusBarFrame.size.height + 44.0)
#define iOSVersion     [[UIDevice currentDevice].systemVersion floatValue]
#define IOS7_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0f)
#define IOS8_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0f)
#define IOS9_OR_LATER     ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0f)
#define IOS7_Following    ([ [ [UIDevice currentDevice] systemVersion] floatValue]<7.0)

#define iPhone4      [[UIScreen mainScreen] bounds].size.height==480?1:0
#define iPhone5      [[UIScreen mainScreen] bounds].size.height==568?1:0
#define iPhone6      [[UIScreen mainScreen] bounds].size.height==667?1:0
#define iPhone6Plus     [[UIScreen mainScreen] bounds].size.height==736?1:0
#define kIphoneSize_4Inches  [[UIScreen mainScreen] bounds].size.width==320?1:0




#define CGRectSetWidth(rect, width)     CGRectMake(rect.origin.x, rect.origin.y, width, rect.size.height)
#define CGRectSetHeight(rect, height)   CGRectMake(rect.origin.x, rect.origin.y, rect.size.width, height)
#define CGRectSetSize(rect, size)       CGRectMake(rect.origin.x, rect.origin.y, size.width, size.height)
#define CGRectSetX(rect, x)             CGRectMake(x, rect.origin.y, rect.size.width, rect.size.height)
#define CGRectSetY(rect, y)             CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height)
#define CGRectSetOrigin(rect, origin)   CGRectMake(origin.x, origin.y, rect.size.width, rect.size.height)
#define ViewSetWidth(view, width)       view.frame = CGRectSetWidth(view.frame, width);
#define ViewSetHeight(view, height)     view.frame = CGRectSetHeight(view.frame, height);
#define ViewSetSize(view, size)         view.frame = CGRectSetSize(view.frame, size);
#define ViewSetX(view, x)               view.frame = CGRectSetX(view.frame, x);
#define ViewSetY(view, y)               view.frame = CGRectSetY(view.frame, y);
#define ViewSetOrigin(view, origin)     view.frame = CGRectSetOrigin(view.frame, origin);

#if !defined(DEBUG) && !defined(BETA)
#define NSLog(format, ...)
#endif

#define kNotificationAppTimerFired                      @"NotificationAppTimerFired"
#define kNotificationNetworkConnected                   @"NotificationNetworkConnected"
#define kNotificationNetworkDisconnected                @"NotificationNetworkDisconnected"

#endif
// other patform acount

#if defined(DEBUG) || defined(BETA)
#define MOBCLICK_APPKEY @"556417d867e58e1b5b002255"
#else
#define MOBCLICK_APPKEY @"52fd77e156240b043b070fa9"
#endif


/***************************分享设置***************************/
//sharesdk－－key
#define  SHARESDK_APPKEY @"7661c01ccc00"

//qq分享
#define QQ_APPID @"1104241646"
#define QZONE_APPKEY @"FP8XcwmIKHpnImEA"

//微信分享
#define WECHATSHARE_APPID @"wxc1b4b5ab41e62ac1"

//新浪微博分享
#define SINA_APPKEY @"2045869037"
#define SINA_SECRET @"13eaed1abd72d28437205a2bf55d0cf7"

//人人网
#define RENREN_APPID @"476290"
#define RENREN_APPKEY @"38a6fc1647a24a6e98fa7c49a1437e68"
#define RENREN_SECRET @"e63ec17d1d604cecadd702446ffcff38"


/***************************分享设置***************************/


#define kWindowServerErrorViewTag               77743214
#define kWindowCartShortcutViewTag              88842332
#define kWindowLoadingViewTag                   99923846
#define kWindowOrderBaskCommitionSuccessViewTag 32498327
#define kShowTitleAfterDelay    2
#define KCartNumCicleTag 3456789
#define kTheLabOfTopbuttonTag  100
#define KCartPointTag 4565426

#define kIs_NULL(value)  value == nil ? @"":value


#define k_BlackGcolor [UIColor colorWithRed:(0.0f/255.0f) green:(0.0f/255.0f) blue:(0.0f/255.0f) alpha:0.8f]//黑色的背景
#define k_Color_ImagePlaceholder     @"f6f6f6"
#define k_Color_ViewBackground       @"f5f3f3"
//温馨提示
#define SHOW_ALERT(_message_) UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"温馨提示" message:_message_ delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定",nil]; \
[alert show];

//
////标签,图片单击事件
//@protocol ClickedDelegate <NSObject>
//@optional
//-(void) someLikeButton:(id)sender;
//@end

//文件来源模式
typedef enum{
    
    FileModeProduct=0,//工程
    FileModeDocument =1//沙盒
    
} FileMode;
