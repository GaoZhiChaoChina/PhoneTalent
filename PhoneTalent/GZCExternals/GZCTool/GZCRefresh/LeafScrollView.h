//
//  LeafScrollView.h
//  funny
//
//  Created by gaozhichao on 15/11/20.
//  Copyright © 2015年 xiexin. All rights reserved.
//

#import <UIKit/UIKit.h>
#define TOP_SCROLL_SPACE 120.0f


//@class LeafScrollView;

@interface LeafScrollView : UIView{
    CGFloat angle;
    BOOL stopRotating;
}
@property (nonatomic,assign,readonly) BOOL isLoading;
@property (strong, nonatomic)  UIImageView *refreshImgView;

- (id)init;
/**
 *  内容视图大小，可根据此摆放你的内容视图
 */
@property (assign,nonatomic) CGRect contentRect;
/**
 *  刷新时的图片
 *
 *  @param image 图片
 */
-(void)setRefreshImage:(UIImage *)image;

/**
 *  您需要展示的视图，可展示范围可通过contentRect获取
 */
@property(strong,nonatomic) UIView *contentView;
/**
 *  停止刷新状态
 */
-(void)endUpdating;

@end
