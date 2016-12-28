//
//  GZCBaseViewController.h
//  PhoneTalent
//
//  Created by cloud on 15/12/10.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "CustomTabbarController.h"

typedef NS_ENUM(NSInteger, NavigationStyle) {  //导航栏左右按钮的样式
    ONLYIMAGE,      //纯图片样式
    ONLYTEXT,       //纯文本样式
};
@protocol GZCBaseViewControllerDelegate <NSObject>
@optional

/**
 *导航栏左边按钮代理方法
 */
-(void)leftButtonHaveClick:(UIButton *)sender;

/**
 *导航栏右边按钮代理方法
 */
-(void)rightButtonHaveClick:(UIButton *)sender;

/**
 *导航栏下载按钮代理方法
 */
-(void)downButtonHaveClick:(UIButton *)sender;

@end

@interface GZCBaseViewController : UIViewController<MBProgressHUDDelegate,GZCBaseViewControllerDelegate>{
       MBProgressHUD *HUD;
}
@property (nonatomic,assign) id<GZCBaseViewControllerDelegate>baseViewDelegate;
@property(nonatomic, strong)   NSString *pageName;  //pv统计
@property(nonatomic,strong)    NSDictionary *parameter;//页面传递参数
@property (nonatomic, assign)  BOOL isMainPage;//一级界面
@property (nonatomic, strong)  CustomTabbarController *customTabBar;
@property (nonatomic,strong) UIButton *leftButton;
@property (nonatomic,strong)UIButton *rightButton;

- (void)addBackNavigationButton;

/**
 *  弹出黑框
 *
 *  @param text 内容
 */
-(void)HUDShow:(NSString*)text;

/**
 *  弹出黑框
 *
 *  @param text   内容
 *  @param second 多久消失
 */
-(void)HUDShow:(NSString*)text delay:(float)second;

/**
 *  弹出黑框
 *
 *  @param text   内容
 *  @param second 多久消失
 *  @param bDo    消失后是否处理其他事件,事件方法HUDdelayDo
 */
-(void)HUDShow:(NSString*)text delay:(float)second dothing:(BOOL)bDo;

/**
 *  隐藏黑框
 *
 *  @param hud 直接写HUD
 */
- (void)hudWasHidden:(MBProgressHUD *)hud;


/**
 *  添加navbar上左边按钮
 *
 *  @param imageName  按钮图片
 */
- (void)addLeafNavigationButton:(NSString*) imageName;

/**
 *  添加navbar上右边按钮
 *
 *  @param imageName 按钮图片  pressImage 按钮按下图片
 */
- (void)addRightNavigationButton:(NSString*) imageName pressImage:(NSString *)pressImage;

/**
 *  添加navbar上右边按钮样式2
 *
 *  @return  butName 按钮文字 按钮选中图片
 */
-(void)addRightNavigationButtonTitle:(NSString*) butName pressImage:(NSString *)pressBtnName;


/**
 *   添加navbar文字内容
 *
 *  @param labelText 内容
 */
- (void)titleLabel:(NSString *)labelText;


/**
 *  navbar左边按钮点击事件
 */
-(void) navBarLeafBtnClick;


/**
 *  navbar右边按钮点击事件
 */
-(void) navBarRightBtnClick;


/**
 *  navbar导航栏标题
 */
-(void)addNavTitle:(NSString *)title;


/**
 *  加载为空时显示页面
 */
-(void)createLoadEmptyView:(NSString *)imgName andText:(NSString *)text;


/**
 *  自定义push方法
 *
 *  @param controllerName  controllerName
 *  @param _isNib          是否有nib,nib名称跟controllerName一致
 */
- (void)pushNewViewController:(NSString *)controllerName isNibPage:(BOOL) _isNib;

/**
 *  自定义push方法2
 *
 *  @param controllerName controllerName
 *  @param _isNib  nn
 *  @param addViewControl 添加到哪个viewcontrol
 */
- (void)pushNewViewController:(NSString *)controllerName
                    isNibPage:(BOOL) _isNib
               addViewControl:(UIViewController*)addViewControl;


/**
 *  统一设置背景图片
 *
 *  @param backgroundImage 目标背景图片
 */
- (void)setupBackgroundImage:(UIImage *)backgroundImage;

/**
 *  push新的控制器到导航控制器
 *
 *  @param newViewController 目标新的控制器对象
 */
- (void)pushNewViewController:(UIViewController *)newViewController;

/**
 *自定义导航栏title
 */
-  (void)customNavigationTitle:(NSString *)aString withFont:(CGFloat)aSize andTitleColor:(UIColor *)titleColor;

/**
 *自定义导航栏左边按钮图片以及标题
 */
-  (void)customNavigationLeftTitle:(NSString *)aString withImage:(UIImage *)aImage buttonStryle:(NavigationStyle)aBtnStyle andtitleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont;

/**
 *自定义导航栏左边按钮为头像,并设置头像消息提醒红点是否隐藏(此方法不能与设置导航栏左边按钮图片以及标题方法同时使用)
 */
- (void)customNavigationHeaderImage:(UIImage *)headerImage orHideMessageImage:(BOOL)hidden;

/**
 *自定义导航栏左边按钮为头像,并设置头像消息提醒红点是否隐藏(此方法不能与设置导航栏左边按钮图片以及标题方法同时使用)
 */
- (void)customNavigationHeaderImageURL:(NSURL *)headerImageURL orHideMessageImage:(BOOL)hidden;

/**
 *自定义导航栏左边用户头像消息提醒红点是否隐藏
 */
- (void)orHideMessageImage:(BOOL)hidden;



/**
 *自定义导航栏右边按钮图片以及标题
 */
-  (void)customNavigationRightTitle:(NSString *)aString withImage:(UIImage *)aImage buttonStryle:(NavigationStyle)aBtnStyle andtitleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont;

/**
 *自定义导航栏背景颜色、图片
 */
- (void)customNavigationBackgroundColor:(UIColor *)color withImage:(UIImage *)aImage;

/**
 *导航栏右边下载按钮是否隐藏,默认隐藏
 */
- (void)customDownButtonHidden:(BOOL)hide;

@end
