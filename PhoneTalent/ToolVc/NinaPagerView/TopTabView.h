//
//  TopTabView.h
//  一两理财
//
//  Created by 高志超 on 15/10/13.
//  Copyright © 2015年 高志超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TopTabView : UIView


- (instancetype)initWithFrame:(CGRect)frame withTitle:(NSString *)title withTitleColor:(UIColor *)titleColor withUnselectedImage:(NSString *)unselectedImage withSelectedImage:(NSString *)selectedImage ;

@property (nonatomic, strong) UIImageView *unselectedImage; /**<  未被选中时的图片   **/
@property (nonatomic, strong) UIImageView *selectedImage; /**<  被选中时的图片   **/
@property (nonatomic, strong) UILabel *title; /**<  按钮中间的标题   **/

@end
