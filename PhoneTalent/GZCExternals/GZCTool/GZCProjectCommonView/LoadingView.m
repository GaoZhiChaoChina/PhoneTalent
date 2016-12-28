//
//  LoadingView.m
//  Mic
//
//  Created by chaossy on 14-3-24.
//  Copyright (c) 2014年 chaossy. All rights reserved.
//

#import "LoadingView.h"
#import "UIImage+animatedGIF.h"

@interface LoadingEmptyView : UIView

@property(nonatomic, readonly) UIImageView* imageView;
@property(nonatomic, readonly) NSLayoutConstraint* imageViewLayoutConstraint;
@property(nonatomic, readonly) UILabel* label;
@property(nonatomic, readonly) NSLayoutConstraint* labelLayoutConstraint;
@property(nonatomic, readonly) UIButton* button;

//@property(nonatomic, strong) UIImage* image;
//@property(nonatomic, strong) NSString* prompt;
//@property(nonatomic, strong) NSString* buttonPrompt;
//- (void)addButtonTarget:(id)target action:(SEL)action;

@end

@implementation LoadingEmptyView
{
    __weak IBOutlet UIImageView* _imageView;
    __weak IBOutlet NSLayoutConstraint* _imageViewLayoutConstraint;
    __weak IBOutlet UILabel* _label;
    __weak IBOutlet NSLayoutConstraint* _labelLayoutConstraint;
    __weak IBOutlet UIButton* _button;
}

- (void)awakeFromNib
{
    [_button setBackgroundImage:[UIImage imageWithColor:ColorNormalPink] forState:UIControlStateNormal];
    [_button setBackgroundImage:[UIImage imageWithColor:ColorHighlightedPink] forState:UIControlStateHighlighted];
    _button.layer.cornerRadius = 5.0;
    _button.layer.masksToBounds = YES;
}

@end

//#define kAnimationTopY    34.0
//#define kAnimationBottomY    66.0

@implementation LoadingView
{
    UIImageView* _logoImageView;
    UIActivityIndicatorView* _indicatorView;
    //    UIView* animatingView;
    //    BOOL animating;
    //    UILabel* errorLabel;
    UIImageView* _errorImageView;
    LoadingEmptyView* _emptyView;
    UITapGestureRecognizer* _tapGestureRecognizer;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        
        self.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
        self.clipsToBounds = YES;
        
        
        self.backgroundColor = [UIColor whiteColor];
        
        
        
        NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pic_loading@2x" ofType:@"gif"]];
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loading_fallsize_bg_new"]];
        [_logoImageView setImage:[UIImage animatedImageWithAnimatedGIFData:gifData]];
        
        
        ViewSetOrigin(_logoImageView, CGPointMake((ScreenWidth - _logoImageView.frame.size.width) / 2,  (ScreenNoBarContentHeight-44 - _logoImageView.frame.size.height) / 2));
        
        [self addSubview:_logoImageView];
        
        
//        _indicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//        _indicatorView.hidesWhenStopped = YES;
//        _indicatorView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin;
//        ViewSetOrigin(_indicatorView, CGPointMake((ScreenWidth - _indicatorView.frame.size.width) / 2, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 20.0));
//        [self addSubview:_indicatorView];
        
        
        
        _errorImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"bg_err_pic"]];
        [self addSubview:_errorImageView];
        
        _emptyView = (LoadingEmptyView*)[[NSBundle mainBundle] loadNibNamed:@"LoadingEmptyView" owner:nil options:nil][0];
        self.emptyViewStyle = LoadingEmptyViewStyleImage | LoadingEmptyViewStyleText;
        _emptyView.width=ScreenWidth;
        _emptyView.height=ScreenHeight-44-20;
        
//        _emptyView.center=self.center;
        [self addSubview:_emptyView];
        
        self.status = LoadingViewStatusAnimating;
        
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(loadingViewTapped)];
        [self addGestureRecognizer:_tapGestureRecognizer];
    }
    return self;
}

- (void)setEmptyView:(UIView*)emptyView
{
    [_emptyView removeFromSuperview];
    _emptyView = nil;
    [self addSubview:emptyView];
}

- (void)setEmptyViewStyle:(LoadingEmptyViewStyle)emptyViewStyle
{
    _emptyViewStyle = emptyViewStyle;
    
    if (!(_emptyViewStyle & LoadingEmptyViewStyleImage)) {
        _emptyView.imageViewLayoutConstraint.constant = 0;
        _emptyView.imageView.image = nil;
    }
    
    if (!(_emptyViewStyle & LoadingEmptyViewStyleText)) {
        _emptyView.labelLayoutConstraint.constant = 0;
        _emptyView.label.text = @"";
    }
    
    _emptyView.button.hidden = !(_emptyViewStyle & LoadingEmptyViewStyleButton);
}

- (void)setEmptyImage:(UIImage *)image
{
    if (_emptyViewStyle & LoadingEmptyViewStyleImage) {
        _emptyView.imageView.image = image;
    }
}

- (void)setEmptyPrompt:(NSString *)emptyPrompt
{
    if (_emptyViewStyle & LoadingEmptyViewStyleText) {
        _emptyView.label.text = emptyPrompt;
    }
}

- (void)setEmptyButtonTitle:(NSString *)emptyButtonTitle
{
    if (_emptyViewStyle & LoadingEmptyViewStyleButton) {
        [_emptyView.button setTitle:emptyButtonTitle forState:UIControlStateNormal];
        [_emptyView.button addTarget:self action:@selector(emptyButtonDidClick) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (void)emptyButtonDidClick
{
    if ([_delegate respondsToSelector:@selector(loadingViewEmptyButtonDidClick:)]) {
        [_delegate loadingViewEmptyButtonDidClick:self];
    }
}

//- (void)addEmptyButtonTarget:(id)target action:(SEL)action
//{
//    if (_emptyViewStyle & LoadingEmptyViewStyleButton) {
//        [_emptyView.button addTarget:target action:@selector(action) forControlEvents:UIControlEventTouchUpInside];
//    }
//}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    ViewSetOrigin(_logoImageView, CGPointMake((ScreenWidth - _logoImageView.frame.size.width) / 2,  (ScreenNoBarContentHeight-44 - _logoImageView.frame.size.height) / 2));
    
//    ViewSetOrigin(_indicatorView, CGPointMake((ScreenWidth - _indicatorView.frame.size.width) / 2, _logoImageView.frame.origin.y + _logoImageView.frame.size.height + 20.0));
    
    //    errorLabel.frame = CGRectMake(20, 0, self.frame.size.width - 40.0, self.frame.size.height);
    ViewSetOrigin(_errorImageView, CGPointMake((ScreenWidth - _errorImageView.frame.size.width) / 2, (ScreenHeight - _errorImageView.frame.size.height) / 2));
}

//- (void)startAnimation
//{
//    if (animating) {
//        return;
//    }
//
//    animating = YES;
//    [animatingView.layer removeAllAnimations];
//
//    CABasicAnimation* animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
//    animation.duration = 1.5;
//    animation.repeatCount = CGFLOAT_MAX;
//    animation.removedOnCompletion = NO;
//    animation.fillMode = kCAFillModeForwards;
//    animation.autoreverses = NO;
//    animation.fromValue = @0;
//    animation.toValue = @(kAnimationTopY-kAnimationBottomY);
//    [animatingView.layer addAnimation:animation forKey:nil];
//}

//- (void)stopAnimation
//{
//    if (!animating) {
//        return;
//    }
//
//    animating = NO;
//    [animatingView.layer removeAllAnimations];
//}

//- (void)setEmptyImage:(UIImage *)emptyImage
//{
//    if ([_emptyView isKindOfClass:[LoadingEmptyView class]]) {
//        LoadingEmptyView* defaultEmptyView = (LoadingEmptyView*)_emptyView;
//        defaultEmptyView.imageView setImage: emptyImage;
//    }
//}
//
//- (void)setEmptyPrompt:(NSString *)emptyPrompt
//{
//    if ([_emptyView isKindOfClass:[LoadingEmptyView class]]) {
//        LoadingEmptyView* defaultEmptyView = (LoadingEmptyView*)_emptyView;
//        defaultEmptyView.prompt = emptyPrompt;
//    }
//}
//
//- (void)setEmptyButtonTitle:(NSString *)emptyButtonTitle
//{
//    if ([_emptyView isKindOfClass:[LoadingEmptyView class]]) {
//        LoadingEmptyView* defaultEmptyView = (LoadingEmptyView*)_emptyView;
//        defaultEmptyView.buttonTitle = emptyButtonTitle;
//    }
//}
//
//- (void)setEmptyView:(UIView*)emptyView
//{
//    [_emptyView removeFromSuperview];
//    _emptyView = emptyView;
//    ViewSetSize(_emptyView, self.frame.size);
//    [self addSubview:_emptyView];
//}

- (void)setStatus:(LoadingViewStatus)status
{
    _status = status;
    
    _logoImageView.hidden = status != LoadingViewStatusAnimating;
    _errorImageView.hidden = status != LoadingViewStatusError;
    _emptyView.hidden = status != LoadingViewStatusEmpty;
    
//    if (status == LoadingViewStatusAnimating) {
//        [_indicatorView startAnimating];
//        
//    } else {
//        [_indicatorView stopAnimating];
//        //        if (status == LoadingViewStatusError) {
//        //            errorLabel.text = _errorPrompt;
//        //        }
//    }
}

- (void)loadingViewTapped
{
    if (_status == LoadingViewStatusError) {
        if ([_delegate respondsToSelector:@selector(loadingViewDataDidReload:)]) {
            [_delegate loadingViewDataDidReload:self];
        }
    }
}

@end
