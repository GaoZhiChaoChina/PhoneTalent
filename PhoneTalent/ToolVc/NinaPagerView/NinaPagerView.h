//
//  NinaPagerView.h
//  NinaPagerView
//
//  Created by 高志超 on 16/3/23.
//  Copyright © 2016年 高志超. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NinaPagerView : UIView

- (instancetype)initWithTitles:(NSArray *)titles WithVCs:(NSArray *)childVCs WithColorArrays:(NSArray *)colors;
@property (strong, nonatomic) UIColor *selectColor; /**<  选中时的颜色   **/
@property (strong, nonatomic) UIColor *unselectColor; /**<  未选中时的颜色   **/
@property (strong, nonatomic) UIColor *underlineColor; /**<  下划线的颜色   **/

@end
