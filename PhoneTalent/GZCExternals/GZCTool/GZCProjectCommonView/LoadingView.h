//
//  LoadingView.h
//  Mic
//
//  Created by chaossy on 14-3-24.
//  Copyright (c) 2014年 chaossy. All rights reserved.
//

#import <UIKit/UIKit.h>


@protocol LoadingViewDelegate;

typedef NS_ENUM(NSUInteger, LoadingViewStatus) {
    LoadingViewStatusAnimating = 0,
    LoadingViewStatusEmpty,
    LoadingViewStatusError,
};

typedef NS_ENUM(NSUInteger, LoadingEmptyViewStyle) {
    LoadingEmptyViewStyleImage = 0x01,
    LoadingEmptyViewStyleText = 0x02,
    LoadingEmptyViewStyleButton = 0x04,
};

@interface LoadingView : UIView

@property(nonatomic, assign) LoadingViewStatus status;
@property(nonatomic, weak) id<LoadingViewDelegate> delegate;

@property(nonatomic, assign) LoadingEmptyViewStyle emptyViewStyle;
@property(nonatomic, strong) NSString* emptyPrompt;
@property(nonatomic, strong) UIImage* emptyImage;
@property(nonatomic, strong) NSString* emptyButtonTitle;

- (void)setEmptyView:(UIView*)emptyView;

@end


@protocol LoadingViewDelegate <NSObject>
@optional
- (void)loadingViewDataDidReload:(LoadingView*)loadingView;
- (void)loadingViewEmptyButtonDidClick:(LoadingView*)loadingView;
@end
