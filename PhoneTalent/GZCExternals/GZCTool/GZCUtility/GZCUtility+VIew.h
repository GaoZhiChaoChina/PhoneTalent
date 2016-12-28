//
//  GZCUtility+VIew.h
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCUtility.h"
#define ColorNormalYellow         [UIColor colorWithRed:255/255.0 green:180/255.0 blue:0/255.0 alpha:1.0]
#define ColorHighlightedYellow    [UIColor colorWithRed:218/255.0 green:106/255.0 blue:7/255.0 alpha:1.0]
#define ColorNormalPink           [UIColor colorWithRed:239/255.0 green:72/255.0 blue:90/255.0 alpha:1.0]
#define ColorHighlightedPink      [UIColor colorWithRed:204/255.0 green:57/255.0 blue:73/255.0 alpha:1.0]
#define ColorGray                 [UIColor colorWithWhite:181/255.0 alpha:1.0]
#define ColorButGray               [UIColor colorWithRed:0.941 green:0.773 blue:0.812 alpha:1.000]

#define k_Color_Narbar              [UIColor convertHexToRGB:@"ccae97"]
#define kColor_Font                @"b2998e"


//#define ColorNoLogin           [UIColor colorWithRed:239/255.0 green:72/255.0 blue:90/255.0 alpha:0.5]
#define ColorNoLogin           [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1]
#define ColorLogin           [UIColor colorWithRed:239/255.0 green:72/255.0 blue:90/255.0 alpha:1.0]
#define ColorHighlightedLogin      [UIColor colorWithRed:204/255.0 green:57/255.0 blue:73/255.0 alpha:1.0]



#define ColorNoZhuCe        [UIColor colorWithRed:255/255.0 green:180/255.0 blue:0/255.0 alpha:0.5]
#define ColorZhuCe    [UIColor colorWithRed:255/255.0 green:180/255.0 blue:0/255.0 alpha:1.0]
#define ColorHighlightedZhuCe     [UIColor colorWithRed:218/255.0 green:106/255.0 blue:7/255.0 alpha:1.0]


#define kColorOrange     @"f9633b"


#define PAGE(scrollView) (scrollView.contentOffset.x / scrollView.frame.size.width + 0.5)

typedef enum {
    CommonButtonColorRed,
    CommonButtonColorYellow,
    CommonButtonColorLogin,
    CommonButtonColorZhuCe,
    CommonButtonColorOrange
    
} CommonButtonColor;

@interface GZCUtility (VIew)
+ (void)modifyCommonButton:(UIButton*)button color:(CommonButtonColor)color;
//+ (void)modifyCommonSegmentedControl:(UISegmentedControl*)segmentedControl;
+ (UISegmentedControl*)createTitleSegmentedControl:(NSArray*)items;


+ (NSArray*)sortViews:(NSArray*)views usingMethod:(ViewSortMethod)viewSortMethod;
+ (void)adjustFrameForKeyboard:(UIScrollView*)mainScrollView view:(UIView*)view gap:(CGFloat)gap keyboard:(CGFloat)y;

// 画上半圆角边
+ (void)drawTopRedius:(CGRect)rect width:(CGFloat)width color:(UIColor*)color radius:(CGFloat)radius;
// 画下半圆角边
+ (void)drawButtomRedius:(CGRect)rect width:(CGFloat)width color:(UIColor*)color radius:(CGFloat)radius;
// 画中间边
+ (void)drawMiddleRedius:(CGRect)rect width:(CGFloat)width color:(UIColor*)color radius:(CGFloat)radius;
// 画圆角边
+ (void)drawRedius:(CGRect)rect width:(CGFloat)width color:(UIColor*)color radius:(CGFloat)radius;
//图片等比例缩放
+(UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size;
// 通过xib加载UIView
+ (void)loadNibNamed:(NSString *)name owner:(UIView *)owner options:(NSDictionary *)options;
// viewController的跳转
+ (void)redirectFrom:(UIViewController *)from to:(UIViewController *)to animated:(BOOL)animated;
+ (void)gobackFrom:(UIViewController *)from animated:(BOOL)animated;
// 从window中取得当前的活动的viewController
+ (UIViewController*)currentViewController:(UIWindow *)window;
// 通过view取得其所在的viewController
+ (UIViewController *)getViewController:(UIView *)view;

+ (CGAffineTransform)translatedAndScaledTransformUsingViewRect:(CGRect)viewRect fromRect:(CGRect)fromRect;

+ (UIImage*)imageWithView:(UIView*)view;

//隐藏左边返回按钮
+(void) hideLeafBarButtonItem:(UIViewController *)  objectRef;

//弹出登录页面
+(void) goLogin:(NSString*) info  receive:(id) receive;

//隐藏滚动条
+(void) hideScrollIndicator:(UIScrollView *) scrollViewObj;

/**
 *  返回默认图
 *
 *  @param imgRect
 *
 *  @return <#return value description#>
 */
+(UIImage*) getPlaceholderImage:(UIImageView*) imgObj;
@end



@interface UIColor(Hex)

+ (UIColor *) colorWithHexString:(NSString*)hex;
//兼容从以前工程拉入的代码
+ (UIColor *) convertHexToRGB: (NSString *)color;

@end

@interface UIImageView(mkf)
//- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage*)placeholderImage animated:(BOOL)animated;
- (void)setImageInProportion:(UIImage*)image;
@end

@interface UIImage(mkf)
- (UIImage*)imageWithNoSurfixImage;
@end

@interface UIView (parameter){
}
-(void) setParame:(NSDictionary*) dic;
-(NSDictionary*) parame;
@end

@interface UIImage (GZCFixOrientation)
- (UIImage *)fixOrientationWithSize:(CGSize)size;
@end

