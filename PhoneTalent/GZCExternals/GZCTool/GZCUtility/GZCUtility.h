//
//  GZCUtility.h
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

typedef enum {
    ViewSortMethodByX,
    ViewSortMethodByY,
    ViewSortMethodByXY,
    ViewSortMethodByYX,
    ViewSortMethodByTag,
} ViewSortMethod;
#define PriceLen(price) price - (int)price > 0 ? 2 : 0

#import <Foundation/Foundation.h>

@interface GZCUtility : NSObject

DECLARE_SINGLETON(Utility);
//兼容函数
+ (void)storyBoradAutoLay:(UIView *)allView;

+ (BOOL)isKeywordValid:(NSString*)keyword;

+ (NSString*)splicedString:(NSArray*)objects separator:(NSString*)separator;

// 解析url的paramter,格式:params1=value1&param2=value2
+ (NSMutableDictionary *)parseUrlParamters:(NSString *)urlParamters;
// 解析url带引号的paramter,格式:params1="value1"&param2="value2"
+ (NSMutableDictionary *)parseUrlQuoteParamters:(NSString *)urlParamters;

+ (NSString*)filePath:(NSSearchPathDirectory)directory fileName:(NSString*)fileName;
+ (NSString*)userFilePath:(int)uid fileName:(NSString*)fileName;

+ (int)stringLength:(NSString*)string;

// 取得当前版本字符串
+ (NSString *)currentVersion;

// 公开url协议, 返回值表示是否保留本页，对于webview决定于是否关闭
+ (BOOL)openURL:(NSURL *)url viewController:(UIViewController*)viewController view:(UIView *)focusView;

// 取得mac地址
+ (NSString *) macaddress;

+ (NSArray *)rangesOfString:(NSString *)searchString inString:(NSString *)str options:(NSStringCompareOptions)mask;

+ (NSString*)base64forData:(NSData*)data;

+ (NSString *)wapUrl:(NSString *)url;

+ (void)calculateDirectorySize:(NSString*)directory completion:(void (^)(NSUInteger fileCount, NSUInteger totalSize))completion;
+ (void)clearDirectory:(NSString*)directory completion:(void (^)())completion;
+(void)makeLineInImageView:(UIImageView*)imageView;
/**
 *  获取设备唯一标示UUID
 *
 *  @return 唯一标示字符串
 */
+(NSString *)getUniqueStrByUUID;

+ (void)shakeAnimationForView:(UIView *) view;//抖动动画

+ (BOOL)versionFirstTimeLaunchWithKey:(NSString*)key;
+ (void)setVersionLaunchedWithKey:(NSString*)key;

+ (UIColor*)blendedColor:(float)percent1 color1:(UIColor*)color1 color2:(UIColor*)color2;
+ (UIImage*)blendedImage:(float)percent1 image1:(UIImage*)image1 image2:(UIImage*)image2;
+(CGSize)downloadImageSizeWithURL:(id)imageURL;


//根据父类的坐标算出居中的x
+(float) getCenterX:(float) fatherWidth
   currentViewWidth:(float)currentViewWidth;

//根据父类的坐标算出上下居中的y
+(float) getCenterY:(float) fatherHeight
  currentViewHeight:(float)currentViewHeight;

//获得文字宽高
+(CGSize)getLabelSize:(NSString*)lbtext
             withFont:(UIFont*)font
         withRowWidth:(float)width;

////添加线
//+(UILabel *) addLine:(CGRect) rect
//           addControl:(UIView*)addControl
//             colorRef:(NSString*)colorRef;


//判断是否为整形：
+(BOOL)isPureInt:(NSString*)string;

//判断是否为浮点形：
+(BOOL)isPureFloat:(NSString*)string;


//添加右下角置顶按钮（显示剩余专题数量＋总量）：
- (UIButton *) addButton:(NSInteger) width
              addControl:(UIView*)addControl
                colorRef:(NSString*)colorRef;

//添加右下角置顶按钮中的改变字体内容
+ (void)indexPath:(NSIndexPath *)indexPath
        AndButton:(UIButton *)button
 AndProductNumber:(NSInteger)number;

//添加右下角置顶按钮中的改变字体内容
+ (void)scrollView:(UIScrollView *)scrollView
         andButton:(UIButton *)button
  andProductNumber:(NSInteger)number
    andTitleHeight:(CGFloat)heigth
  collectionHeight:(CGFloat)collectionHeight;

+(NSString*)   convetString:(NSInteger) value;
+(NSString*)   convetStringForFloat:(float) value;
+(NSString*)   convetMoney:(float) value;
+(NSString*)   convetTwoDecimal:(float)value;

+(UIImage*) stretchableImage:(UIImage*)stretchableImage    stretchableImageWithLeftCapWidth:(int) stretchableImageWithLeftCapWidth  topCapHeight:(int) topCapHeight;

//回到首页
+(void) goHomePage;
//透明导航
+ (void)setClearColorTheme:(UINavigationController *)navigater;

/**
 *  跳转到系统设置
 *
 *  @param str 各界面系统参数
 */
+(void)sendSystemSetttingView:(NSString *)str;
/**
 *  获取手机配置信息
 *
 *  @param success 回调所有信息
 */
+(void)getSystemConfigurationInformation:(void (^)(NSString *name, NSString *model,NSString *systemVersion,NSString *systemName))success;
/**
 *  绘制边框圆角
 *
 *  @param sender 绘制的button
 *  @param width  边框宽度
 *  @param radius 圆角
 *  @param color  颜色
 */
+(void)drawBorderRound:(UIButton *)sender andBorderWidth:(CGFloat)width andCornerRadius:(CGFloat)radius andColor:(NSString *)color;
/**
 *  去除字符串特殊符号
 *
 *  @param str 处理的字符串
 *
 *  @return bool值
 */
+(Boolean) isEmptyOrNul:(NSString *)str;

@end


@interface NSString (encrypto)
- (NSString *) md5;
- (NSString *) sha1;
- (NSString *) sha1_base64;
- (NSString *) md5_base64;
- (NSString *) base64;
- (NSString *) dBase64;

@end


@interface NSString (urlencode)
-(NSString *)urlencode:(NSStringEncoding)encoding;
@end


@interface UIImage (GZCColor)
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
