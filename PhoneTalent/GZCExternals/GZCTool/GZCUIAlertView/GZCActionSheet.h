//
//  GZCActionSheet.h
//  funny
//
//  Created by gaozhichao on 15/11/23.
//  Copyright © 2015年 xiexin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GZCActionSheet;

@protocol GZCActionSheetDelegate <NSObject>

@optional
- (void)actionSheet:(GZCActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex;


@end

@interface GZCActionSheet : UIControl

@property (nonatomic, weak) id<GZCActionSheetDelegate> delegate;
@property (nonatomic, assign, readonly) NSInteger cancelButtonIndex;
@property (nonatomic, strong) UIColor *titleColor;


- (instancetype)initWithTitle:(NSString *)title delegate:(id<GZCActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonIndexSet:(NSIndexSet *)destructiveIndexSet otherButtonTitles:(NSArray *)otherButtonTitles;
- (void)showInView:(UIView *)superView;
- (void)hideActionSheet;
@end
