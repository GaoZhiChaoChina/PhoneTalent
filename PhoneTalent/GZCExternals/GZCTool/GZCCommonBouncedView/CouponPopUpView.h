//
//  CouponPopUpView.h
//  Mic
//
//  Created by gaozhichao on 30/12/15.
//  Copyright © 2015年 chaossy. All rights reserved.
//


/**
 *  从底部弹出View，自带tabview表格和 按钮选中
 */

#import <UIKit/UIKit.h>
#import "OrderActivity.h"

//@protocol CouponPopUpViewDelegate;

typedef void (^CouponPopUpViewBlock) (OrderActivity *activity ,NSInteger inderPath_row);

@interface CouponPopUpView : UIView<UITableViewDelegate,UITableViewDataSource>

/**
 *  购物车优惠券弹框
 *
 *  @param frame       view位置
 *  @param arry        优惠券数组
 *  @param optiontitle 弹框title
 *
 *  @return 本对象
 */
- (instancetype)initWithFrame:(CGRect)frame payModeArray:(NSArray *)arry optionName:(NSString *)optiontitle;

/**
 *  显示方式
 *
 *  @param view 显示在那个view上
 */
- (void)showInView:(UIView*)view;
//@property(nonatomic, weak) id<CouponPopUpViewDelegate> delegate;
@property (nonatomic, strong) CouponPopUpViewBlock closing;
@end

//@protocol CouponPopUpViewDelegate
//- (void)selectButtonDidClick:(CouponPopUpView*)view;
//@end
