//
//  PayListDialogView.h
//  Mic
//
//  Created by songbai on 15/4/20.
//  Copyright (c) 2015年 chaossy. All rights reserved.
//

/**
 *  弹出View居中显示，自带tabview表格和 按钮选中
 */

#import <UIKit/UIKit.h>
#import "PayMode.h"
typedef void (^PayListClosing) (PayMode *Mode);

@interface PayListDialogView : UIView<UITableViewDelegate,UITableViewDataSource>
- (instancetype)initWithFrame:(CGRect)frame payModeArray:(NSArray *)arry;
@property (nonatomic, strong) PayListClosing closing;

@end
