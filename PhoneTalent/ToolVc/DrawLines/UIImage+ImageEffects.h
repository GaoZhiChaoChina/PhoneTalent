#import <UIKit/UIKit.h>

@interface UIImage (ImageEffects)

- (UIImage *)applyLightEffect;
- (UIImage *)applyExtraLightEffect;
- (UIImage *)applyDarkEffect;
- (UIImage *)applyTintEffectWithColor:(UIColor *)tintColor;
- (UIImage *)imageWithColor:(UIColor *)color;
- (UIImage *)applyBlurWithRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

/**
 *  返回一像素（size(1,1)）这个color颜色的图片
 *
 *  @param color 一个颜色指标
 *
 *  @return 图片
 */
+ (UIImage *)ff_imageWithColor:(UIColor *)color;

@end
