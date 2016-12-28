//
//  GZCUtility+VIew.m
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCUtility+VIew.h"

@implementation GZCUtility (VIew)
+ (void)modifyCommonButton:(UIButton*)button color:(CommonButtonColor)color
{
    button.layer.masksToBounds = YES;
    //    button.layer.cornerRadius = 5.0;
    
    if (color == CommonButtonColorRed) {
        [button setBackgroundImage:[UIImage imageWithColor:ColorNormalPink] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:ColorHighlightedPink] forState:UIControlStateHighlighted];
    } else if (color == CommonButtonColorYellow) {
        [button setBackgroundImage:[UIImage imageWithColor:ColorNormalYellow] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:ColorHighlightedYellow] forState:UIControlStateHighlighted];
    }else if (color==CommonButtonColorLogin){
        [button setBackgroundImage:[UIImage imageWithColor:ColorNoLogin] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:ColorHighlightedLogin] forState:UIControlStateHighlighted];
    }else if (color==CommonButtonColorZhuCe){
        [button setBackgroundImage:[UIImage imageWithColor:ColorNoZhuCe] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageWithColor:ColorHighlightedZhuCe] forState:UIControlStateHighlighted];
    }
    else if (color==CommonButtonColorOrange){
        
        [button setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithHexString:kColorOrange]] forState:UIControlStateNormal];
        
    }
    
    
    
    [button setBackgroundImage:[UIImage imageWithColor:ColorGray] forState:UIControlStateDisabled];
}

+ (UISegmentedControl*)createTitleSegmentedControl:(NSArray*)items
{
    //    UISegmentedControl* titleSegmentedControl = [[UISegmentedControl alloc] initWithFrame:CGRectMake(0, 0, CGFLOAT_MAX, 29)];
    UISegmentedControl* segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    segmentedControl.frame = CGRectMake(0, 0, CGFLOAT_MAX, 29);
    
    if (iOSVersion < 7) {
        segmentedControl.segmentedControlStyle = UISegmentedControlStyleBar;
    } else {
        [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:14.0]} forState:UIControlStateNormal];
        [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:14.0]} forState:UIControlStateSelected];
        [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:14.0]} forState:UIControlStateHighlighted];
        
        [segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.5]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        [segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.5]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor whiteColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        [segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor whiteColor]] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.5]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor colorWithWhite:1.0 alpha:0.5]] forLeftSegmentState:UIControlStateHighlighted rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
        [segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor whiteColor]] forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
        [segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor whiteColor]] forLeftSegmentState:UIControlStateHighlighted rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
        
        segmentedControl.layer.masksToBounds = YES;
        segmentedControl.layer.borderWidth = 1.0;
        segmentedControl.layer.cornerRadius = 4.0;
        segmentedControl.layer.borderColor = [UIColor colorWithWhite:1.0 alpha:0.5].CGColor;
    }
    
    return segmentedControl;
}

//+ (void)modifyCommonSegmentedControl:(UISegmentedControl*)segmentedControl
//{
////    UIColor* transparentColor = [UIColor colorWithWhite:1.0 alpha:0.3];
//
//    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:14.0]} forState:UIControlStateNormal];
//    [segmentedControl setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor redColor], NSFontAttributeName:[UIFont systemFontOfSize:14.0]} forState:UIControlStateSelected];
//    [segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor colorWithWhite:1 alpha:0]] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
//    [segmentedControl setDividerImage:[UIImage imageWithColor:[UIColor whiteColor]] forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    segmentedControl.layer.masksToBounds = YES;
//    segmentedControl.layer.borderWidth = 1.0;
//    segmentedControl.layer.cornerRadius = 4.0;
//    segmentedControl.layer.borderColor = [UIColor whiteColor].CGColor;
//}

+ (NSArray*)sortViews:(NSArray*)views usingMethod:(ViewSortMethod)viewSortMethod
{
    NSArray* sortedViews = nil;
    
    switch (viewSortMethod) {
        case ViewSortMethodByYX:
            sortedViews = [views sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                CGRect frame1 = [obj1 frame];
                CGRect frame2 = [obj2 frame];
                
                if (frame1.origin.y == frame2.origin.y) {
                    return frame1.origin.x > frame2.origin.x;
                } else {
                    return frame1.origin.y > frame2.origin.y;
                }
            }];
            break;
            
        case ViewSortMethodByXY:
            sortedViews = [views sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                CGRect frame1 = [obj1 frame];
                CGRect frame2 = [obj2 frame];
                
                if (frame1.origin.x == frame2.origin.x) {
                    return frame1.origin.y > frame2.origin.y;
                } else {
                    return frame1.origin.x > frame2.origin.x;
                }
            }];
            break;
            
        case ViewSortMethodByY:
            sortedViews = [views sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                CGRect frame1 = [obj1 frame];
                CGRect frame2 = [obj2 frame];
                return frame1.origin.y > frame2.origin.y;
            }];
            break;
            
        case ViewSortMethodByX:
            sortedViews = [views sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
                CGRect frame1 = [obj1 frame];
                CGRect frame2 = [obj2 frame];
                return frame1.origin.x > frame2.origin.x;
            }];
            break;
            
        case ViewSortMethodByTag:
            sortedViews = [views sortedArrayUsingComparator:^NSComparisonResult(UIView* view1, UIView* view2) {
                return view1.tag > view2.tag;
            }];
            break;
    }
    
    return sortedViews;
}

//+ (void)roundView:(UIView*)view corner:(UIRectCorner)corner cornerRadii:(CGSize)radii borderWidth:(CGFloat)width borderColor:(UIColor*)color
//{
//    if (!view) {
//        return;
//    }
//
//    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corner cornerRadii:radii];
//    CAShapeLayer *subLayer = [[CAShapeLayer alloc] init];
//    subLayer.fillColor = [UIColor clearColor].CGColor;
//    subLayer.lineWidth = width;
//    if (color) {
//        subLayer.strokeColor = color.CGColor;
//    }
//    subLayer.path = maskPath.CGPath;
//
//    CAShapeLayer* maskLayer = [[CAShapeLayer alloc] init];
//    maskLayer.path = maskPath.CGPath;
//
//    view.layer.mask = maskLayer;
//    [view.layer addSublayer:subLayer];
//}

+ (void)adjustFrameForKeyboard:(UIScrollView*)mainScrollView view:(UIView*)view gap:(CGFloat)gap keyboard:(CGFloat)y
{
    mainScrollView.contentOffset = CGPointZero;
    
    if (y >= ScreenHeight) {
        mainScrollView.contentSize = CGSizeMake(mainScrollView.frame.size.width, mainScrollView.frame.size.height);
        mainScrollView.contentOffset = CGPointZero;
        mainScrollView.scrollEnabled = NO;
    } else {
        CGPoint point = [mainScrollView convertPoint:CGPointMake(view.frame.origin.x, view.frame.origin.y + view.frame.size.height) toView:nil];
        CGFloat offset = MAX(0, point.y + gap - y);
        mainScrollView.contentSize = CGSizeMake(mainScrollView.frame.size.width, mainScrollView.frame.size.height + offset);
        mainScrollView.contentOffset = CGPointMake(0, offset);
        mainScrollView.scrollEnabled = offset > 0;
    }
}

// 画上半圆角边
+ (void)drawTopRedius:(CGRect)rect width:(CGFloat)edgeWidth color:(UIColor*)edgeColor radius:(CGFloat)edgeRadius {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //上分割线，
    CGContextSetStrokeColorWithColor(context, edgeColor.CGColor);// 线的颜色
    CGContextSetLineWidth(context, edgeWidth);// 线的宽度
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y+rect.size.height);// 起点
    
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+edgeRadius);
    CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y, rect.origin.x+edgeRadius, rect.origin.y, edgeRadius);
    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width-edgeRadius, rect.origin.y);
    CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y, rect.origin.x+rect.size.width, rect.origin.y+edgeRadius, edgeRadius);
    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathStroke);
}
// 画下半圆角边
+ (void)drawButtomRedius:(CGRect)rect width:(CGFloat)edgeWidth color:(UIColor*)edgeColor radius:(CGFloat)edgeRadius {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //下分割线，
    CGContextSetStrokeColorWithColor(context, edgeColor.CGColor);// 线的颜色
    CGContextSetLineWidth(context, edgeWidth);// 线的宽度
    CGContextMoveToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);// 起点
    
    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height-edgeRadius);
    CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height, rect.origin.x+rect.size.width-edgeRadius, rect.origin.y+rect.size.height, edgeRadius);
    CGContextAddLineToPoint(context, rect.origin.x+edgeRadius, rect.origin.y+rect.size.height);
    CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y+rect.size.height, rect.origin.x, rect.origin.y+rect.size.height-edgeRadius, edgeRadius);
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y);
    CGContextDrawPath(context, kCGPathStroke);
}
// 画中间边
+ (void)drawMiddleRedius:(CGRect)rect width:(CGFloat)edgeWidth color:(UIColor*)edgeColor radius:(CGFloat)edgeRadius {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //下分割线，
    CGContextSetStrokeColorWithColor(context, edgeColor.CGColor);// 线的颜色
    CGContextSetLineWidth(context, edgeWidth);// 线的宽度
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y);// 起点
    
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height);
    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y);
    CGContextDrawPath(context, kCGPathStroke);
}
// 画圆角边
+ (void)drawRedius:(CGRect)rect width:(CGFloat)edgeWidth color:(UIColor*)edgeColor radius:(CGFloat)edgeRadius {
    CGContextRef context = UIGraphicsGetCurrentContext();
    //上分割线，
    CGContextSetStrokeColorWithColor(context, edgeColor.CGColor);// 线的颜色
    CGContextSetLineWidth(context, edgeWidth);// 线的宽度
    CGContextMoveToPoint(context, rect.origin.x, rect.origin.y+rect.size.height-edgeRadius);// 起点
    
    CGContextAddLineToPoint(context, rect.origin.x, rect.origin.y+edgeRadius);
    CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y, rect.origin.x+edgeRadius, rect.origin.y, edgeRadius);
    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width-edgeRadius, rect.origin.y);
    CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y, rect.origin.x+rect.size.width, rect.origin.y+edgeRadius, edgeRadius);
    CGContextAddLineToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height-edgeRadius);
    CGContextAddArcToPoint(context, rect.origin.x+rect.size.width, rect.origin.y+rect.size.height, rect.origin.x+rect.size.width-edgeRadius, rect.origin.y+rect.size.height, edgeRadius);
    CGContextAddLineToPoint(context, rect.origin.x+edgeRadius, rect.origin.y+rect.size.height);
    CGContextAddArcToPoint(context, rect.origin.x, rect.origin.y+rect.size.height, rect.origin.x, rect.origin.y+rect.size.height-edgeRadius, edgeRadius);
    CGContextDrawPath(context, kCGPathStroke);
}

//图片等比例缩放
+(UIImage *)imageWithImage:(UIImage *)image scaledToFillSize:(CGSize)size
{
    CGFloat scale = MAX(size.width/image.size.width, size.height/image.size.height);
    CGFloat width = image.size.width * scale;
    CGFloat height = image.size.height * scale;
    CGRect imageRect = CGRectMake((size.width - width)/2.0f,
                                  (size.height - height)/2.0f,
                                  width,
                                  height);
    
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [image drawInRect:imageRect];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (void)loadNibNamed:(NSString *)name owner:(UIView *)owner options:(NSDictionary *)options {
    NSArray *array=[[NSBundle mainBundle] loadNibNamed:name owner:owner options:options];
    UIView *uiview;
    for (id nib in array) {
        if ([nib isKindOfClass:[owner class]]) {
            uiview=nib;
            break;
        }
    }
    owner.layer.opaque=NO;
    owner.frame=uiview.frame;
    uiview.clipsToBounds=NO;
    owner.clipsToBounds=NO;
    [owner addSubview:uiview];
    // 拷贝子视图
    //[Utility copyFrom:uiview to:owner];
}

+ (void)redirectFrom:(UIViewController *)from to:(UIViewController *)to animated:(BOOL)animated {
    if (from.navigationController) {
        [from.navigationController pushViewController:to animated:animated];
    } else {
        [from presentViewController:to animated:animated completion:nil];
    }
}

+ (void)gobackFrom:(UIViewController *)from animated:(BOOL)animated {
    if (from.navigationController) {
        [from.navigationController popViewControllerAnimated:animated];
    } else {
        [from dismissViewControllerAnimated:animated completion:nil];
    }
}


+ (UIViewController*)currentViewController:(UIWindow *)window {
    // 固定路径MenuViewController->UINavigationController->lastObject
    
    UITabBarController *rootViewController=(UITabBarController *)window.rootViewController;
    
    @try {
        
        UINavigationController *navigationController=[rootViewController.viewControllers objectAtIndex:rootViewController.selectedIndex];
        return [navigationController.viewControllers lastObject];
        
    }
    @catch (NSException *exception) {
        
        return rootViewController;
    }
}

+ (UIViewController *)getViewController:(UIView *)view {
    for (UIView* next = [view superview]; next; next=next.superview) {
        UIResponder* nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController
                                          class]]) {
            return (UIViewController*)nextResponder;
        }
    }
    return nil;
}

+ (CGAffineTransform)translatedAndScaledTransformUsingViewRect:(CGRect)viewRect fromRect:(CGRect)fromRect
{
    CGSize scales = CGSizeMake(viewRect.size.width/fromRect.size.width, viewRect.size.height/fromRect.size.height);
    CGPoint offset = CGPointMake(CGRectGetMidX(viewRect) - CGRectGetMidX(fromRect), CGRectGetMidY(viewRect) - CGRectGetMidY(fromRect));
    return CGAffineTransformMake(scales.width, 0, 0, scales.height, offset.x, offset.y);
}

+ (UIImage *)imageWithView:(UIView *)view
{
    //    UIGraphicsBeginImageContext(view.bounds.size);
    //    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    //    UIGraphicsEndImageContext();
    
    //解决图片糊掉的问题
    CGSize s = view.bounds.size;
    UIGraphicsBeginImageContextWithOptions(s, NO, [UIScreen mainScreen].scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage*img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    return img;
}


+(void) hideLeafBarButtonItem:(UIViewController *)  objectRef{
    
    for(UIBarButtonItem *item in  objectRef.navigationItem.leftBarButtonItems){
        
        item.customView.hidden=true;
    }
}



//隐藏滚动条
+(void) hideScrollIndicator:(UIScrollView *) scrollViewObj{
    
    scrollViewObj.showsVerticalScrollIndicator=false;
    scrollViewObj.showsHorizontalScrollIndicator=false;
}

+(UIImage*) getPlaceholderImage:(UIImageView*) imgObj{
    
    UIView *backImg=[[UIView alloc] initWithFrame:imgObj.frame];
    backImg.backgroundColor=[UIColor convertHexToRGB:@"e5e5e5"];
    
    return  [GZCUtility imageWithView:backImg];
}


@end


@implementation UIColor(Hex)

+ (UIColor *) colorWithHexString: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

+ (UIColor *) convertHexToRGB: (NSString *)color
{
    NSString *cString = [[color stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];
    
    // String should be 6 or 8 characters
    if ([cString length] < 6) {
        return [UIColor clearColor];
    }
    
    // strip 0X if it appears
    if ([cString hasPrefix:@"0X"])
        cString = [cString substringFromIndex:2];
    if ([cString hasPrefix:@"#"])
        cString = [cString substringFromIndex:1];
    if ([cString length] != 6)
        return [UIColor clearColor];
    
    // Separate into r, g, b substrings
    NSRange range;
    range.location = 0;
    range.length = 2;
    
    //r
    NSString *rString = [cString substringWithRange:range];
    
    //g
    range.location = 2;
    NSString *gString = [cString substringWithRange:range];
    
    //b
    range.location = 4;
    NSString *bString = [cString substringWithRange:range];
    
    // Scan values
    unsigned int r, g, b;
    [[NSScanner scannerWithString:rString] scanHexInt:&r];
    [[NSScanner scannerWithString:gString] scanHexInt:&g];
    [[NSScanner scannerWithString:bString] scanHexInt:&b];
    
    return [UIColor colorWithRed:((float) r / 255.0f) green:((float) g / 255.0f) blue:((float) b / 255.0f) alpha:1.0f];
}

@end


#import <objc/runtime.h>


@implementation UIButton(AFNetworkingReplace)

+ (void)load
{
    Method setImageForState = class_getInstanceMethod([self class], @selector(setImageForState:withURLRequest:placeholderImage:success:failure:));
    Method afreplace_setImageForState = class_getInstanceMethod([self class], @selector(afreplace_setImageForState:withURLRequest:placeholderImage:success:failure:));
    method_exchangeImplementations(setImageForState, afreplace_setImageForState);
}

- (void)afreplace_setImageForState:(UIControlState)state
                    withURLRequest:(NSURLRequest *)urlRequest
                  placeholderImage:(UIImage *)placeholderImage
                           success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                           failure:(void (^)(NSError *error))failure
{
    NSMutableURLRequest* request = [urlRequest mutableCopy];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    [self afreplace_setImageForState:state withURLRequest:request placeholderImage:placeholderImage success:success failure:failure];
}

@end


@implementation UIImageView(AFNetworkingReplace)

+ (void)load
{
    Method setImageWithURLRequest = class_getInstanceMethod([self class], @selector(setImageWithURLRequest:placeholderImage:success:failure:));
    Method afreplace_setImageWithURLRequest = class_getInstanceMethod([self class], @selector(afreplace_setImageWithURLRequest:placeholderImage:success:failure:));
    method_exchangeImplementations(setImageWithURLRequest, afreplace_setImageWithURLRequest);
}

- (void)afreplace_setImageWithURLRequest:(NSURLRequest *)urlRequest
                        placeholderImage:(UIImage *)placeholderImage
                                 success:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image))success
                                 failure:(void (^)(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error))failure {
    
    NSMutableURLRequest* request = [urlRequest mutableCopy];
    request.cachePolicy = NSURLRequestReturnCacheDataElseLoad;
    [self afreplace_setImageWithURLRequest:request placeholderImage:placeholderImage success:success failure:failure];
}


@end


@implementation UIImageView(mkf)

//- (void)setImageWithURL:(NSURL *)url placeholderImage:(UIImage*)placeholderImage animated:(BOOL)animated
//{
//    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
//    [request addValue:@"image/*" forHTTPHeaderField:@"Accept"];
//    
//    if (!animated || [[UIImageView sharedImageCache] cachedImageForRequest:request]) {
//        [self setImageWithURLRequest:request placeholderImage:placeholderImage success:nil failure:nil];
//    } else {
//        __weak __typeof(self)weakSelf = self;
//        [self setImageWithURLRequest:request placeholderImage:placeholderImage success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
//            __strong __typeof(self)strongSelf = weakSelf;
//            if ([[[request URL] absoluteString] isEqualToString:[url absoluteString]]) {
//                strongSelf.alpha = 0.3;
//                strongSelf.image = image;
//                [UIView animateWithDuration:0.3 animations:^{
//                    strongSelf.alpha = 1.0;
//                }];
//            }
//        } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
//        }];
//    }
//}

- (void)setImageInProportion:(UIImage*)image
{
    if (self.frame.size.width >= image.size.width) {
        ViewSetWidth(self, image.size.width);
        ViewSetHeight(self, image.size.height);
    } else {
        CGFloat height = image.size.height - (image.size.width - self.frame.size.width) / image.size.width * image.size.height;
        ViewSetHeight(self, height);
    }
    self.image = image;
}

@end


@implementation UIImage(mkf)

- (UIImage*)imageWithNoSurfixImage
{
    CGSize size = CGSizeMake(self.size.width * self.scale / 3.0, self.size.height * self.scale / 3.0);
    UIGraphicsBeginImageContextWithOptions(size, NO, 0);
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end


@implementation UIView (parameter)
static char UIViewParameterKey;

-(void) setParame:(NSDictionary*) dic{
    
    objc_setAssociatedObject(self, &UIViewParameterKey,dic, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
-(NSDictionary*) parame{
    
    return objc_getAssociatedObject(self, &UIViewParameterKey);
}
@end

@implementation UIImage (GZCFixOrientation)

- (UIImage *)fixOrientationWithSize:(CGSize)size {
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    // No-op if the orientation is already correct
    if (self.imageOrientation != UIImageOrientationUp) {
        
        switch (self.imageOrientation) {
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, size.width, size.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
                
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
                transform = CGAffineTransformTranslate(transform, size.width, 0);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
                
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, 0, size.height);
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                break;
            case UIImageOrientationUp:
            case UIImageOrientationUpMirrored:
                break;
        }
        
        switch (self.imageOrientation) {
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, size.width, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
                
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, size.height, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
            case UIImageOrientationUp:
            case UIImageOrientationDown:
            case UIImageOrientationLeft:
            case UIImageOrientationRight:
                break;
        }
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, size.width, size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0,0,size.height,size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0,0,size.width,size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

@end
