//
//  PlaceholderTextView.h
//  funny
//
//  Created by gaozhichao on 15/11/19.
//  Copyright © 2015年 xiexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlaceholderTextView : UITextView

/*!
 * @brief 占位符文本,与UITextField的placeholder功能一致
 */
@property (nonatomic, strong) NSString *placeholder;

/*!
 * @brief 占位符文本颜色
 */
@property (nonatomic, strong) UIColor *placeholderTextColor;


@end
