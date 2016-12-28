//
//  UIScrollView+DataFetch.m
//  Mic
//
//  Created by chaossy on 14-3-7.
//  Copyright (c) 2014年 chaossy. All rights reserved.
//

#import "UIScrollView+DataFetch.h"
#import "LoadingView.h"
#import "UIImage+animatedGIF.h"




@implementation DFData

- (instancetype)init
{
    self = [super init];
    if (self) {
        _objects = [[NSMutableArray alloc] init];
    }
    return self;
}

@end


@interface DFTopView()

@property(nonatomic, readonly) UIView* coverView;

@end

@implementation DFTopView
{
    //    UIView* _coverView;
    UIImageView* _imageView;
    UILabel* _dateLabel;
    UIActivityIndicatorView* _loadingIndicator;
    UIImageView *_gifImageView;
}

- (instancetype)init:(UIColor*) coverViewBgColor
{
    self = [super init];
    if (self) {
        
        UIImage* image = [UIImage imageNamed:@"refresh"];
        _imageView = [[UIImageView alloc] initWithImage:image];
        [self addSubview:_imageView];
        
        ViewSetHeight(self, image.size.height + 10);
    
        NSData *gifData = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"refreshGif" ofType:@"gif"]];
        _gifImageView=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 31, 25)];
        [_gifImageView setImage:[UIImage animatedImageWithAnimatedGIFData:gifData]];
        _gifImageView.hidden=true;
        [self addSubview:_gifImageView];
 
        _coverView = [[UIView alloc] init];
        _coverView.backgroundColor = coverViewBgColor;//scrollView.backgroundColor;
        [self addSubview:_coverView];
        
        self.backgroundColor = [UIColor clearColor];
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    _imageView.center = CGPointMake(width / 2, height / 2);
    _coverView.frame = self.bounds;
    _gifImageView.center=CGPointMake(width / 2, height / 2);
    
}

- (void)updateView:(DFStatus)status
{
    if (status == DFStatusRefetching) {
        
        _gifImageView.hidden=false;
        _imageView.hidden = YES;
        
    } else {
        
        _gifImageView.hidden=true;
        _imageView.hidden = NO;
    }
}

@end


@implementation DFBottomView
{
    UIView* _coverView;
    UILabel* _loadingLabel;
    UIActivityIndicatorView* _loadingIndicator;
    UILabel* _allLoadedPromptLabel;
    
    UIImageView *_gifLoadImg;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.frame = CGRectMake(0, 0, 0, 37);
        self.backgroundColor = [UIColor clearColor];
        
        _loadingLabel = [[UILabel alloc] init];
        _loadingLabel.font = [UIFont systemFontOfSize:14.0];
        _loadingLabel.textColor = [UIColor lightGrayColor];
        _loadingLabel.textAlignment = NSTextAlignmentCenter;
        _loadingLabel.text = @"数据奋力加载中";
        [_loadingLabel sizeToFit];
        [self addSubview:_loadingLabel];
        
        
        _loadingIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
        _loadingIndicator.hidesWhenStopped = YES;
        [self addSubview:_loadingIndicator];
        
        
        _gifLoadImg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
        [_gifLoadImg setContentMode:UIViewContentModeScaleAspectFit];
        [_gifLoadImg setImage:[UIImage imageNamed:@"upload"]];
        _gifLoadImg.hidden=true;
        [self addSubview:_gifLoadImg];
        
        
        CABasicAnimation* rotationAnimation;
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * 2.0 ];
        rotationAnimation.duration = 0.7;
        rotationAnimation.cumulative = YES;
        rotationAnimation.repeatCount = GID_MAX;
        [_gifLoadImg.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        
        _allLoadedPromptLabel = [[UILabel alloc] init];
        _allLoadedPromptLabel.font = [UIFont systemFontOfSize:14.0];
        _allLoadedPromptLabel.textColor = [UIColor lightGrayColor];
        _allLoadedPromptLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_allLoadedPromptLabel];
        
        
        
        //        self.backgroundColor = [UIColor redColor];
    }
    return self;
}

- (void)layoutSubviews
{
    _loadingLabel.center = CGPointMake(self.frame.size.width / 2 + _loadingIndicator.frame.size.width / 2 + 5, self.frame.size.height / 2);
//    _loadingIndicator.center = CGPointMake(self.frame.size.width / 2 - _loadingLabel.frame.size.width / 2 - 5, self.frame.size.height / 2);
    _allLoadedPromptLabel.frame = self.bounds;
     _gifLoadImg.center = CGPointMake(self.frame.size.width / 2 - _loadingLabel.frame.size.width / 2 - 5, self.frame.size.height / 2);
}

- (void)updateView:(BOOL)hasMoreDataToFetch{
    
    //隐藏和显示（正在加载和转轮）
    _loadingLabel.hidden = !hasMoreDataToFetch;
    
    if (hasMoreDataToFetch) {
        
        _gifLoadImg.hidden=false;
    }
    else{
    
        _gifLoadImg.hidden=true;
    }
    
//    if (hasMoreDataToFetch && ![_loadingIndicator isAnimating]) {
//        
//        [_loadingIndicator startAnimating];
//        
//    } else if (!hasMoreDataToFetch && [_loadingIndicator isAnimating]) {
//        
//        [_loadingIndicator stopAnimating];
//    }
    
    
    _allLoadedPromptLabel.hidden = hasMoreDataToFetch;
}


- (void)setAllLoadedPrompt:(NSString *)allLoadedPrompt
{
    _allLoadedPromptLabel.text = allLoadedPrompt;
}

- (NSString*)allLoadedPrompt
{
    return _allLoadedPromptLabel.text;
}

@end



#import <objc/runtime.h>

static char ScrollViewLoadingViewKey;
static char ScrollViewTopViewKey;
static char ScrollViewBottomViewKey;
static char ScrollViewDataKey;
static char ScrollViewDatasKey;
static char DFDelegateKey;
static char ScrollViewInsetsSavedKey;
static char ScrollViewObserverKey;
static char ScrollViewRefetchEnabledKey;
static char ScrollViewFetchMoreEnabledKey;
static char ScrollViewUseCustomLoadingViewKey;
static char ScrollViewIsNoAddBottomView;
static char ScrollViewisUseNextPage;


@interface ScrollViewObserver : NSObject

@property float footViewHeight;

@end

@interface UIScrollView()

@property(nonatomic, assign) UIEdgeInsets df_insetsSaved;
@property(nonatomic, strong) ScrollViewObserver* df_observer;
@property(nonatomic, strong) NSMutableDictionary* df_datas;

@end


@implementation UIScrollView(DataFetch)


+ (void)load
{
    Method dealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method df_dealloc = class_getInstanceMethod([self class], @selector(df_dealloc));
    method_exchangeImplementations(dealloc, df_dealloc);
    
    Method setContentInset = class_getInstanceMethod([self class], @selector(setContentInset:));
    Method df_setContentInset = class_getInstanceMethod([self class], @selector(df_setContentInset:));
    method_exchangeImplementations(setContentInset, df_setContentInset);
    
    Method layoutSubviews = class_getInstanceMethod([self class], @selector(layoutSubviews));
    Method df_layoutSubviews = class_getInstanceMethod([self class], @selector(df_layoutSubviews));
    method_exchangeImplementations(layoutSubviews, df_layoutSubviews);
}

- (void)df_setContentInset:(UIEdgeInsets)contentInset
{
    self.df_insetsSaved = contentInset;
    [self df_setContentInset:contentInset];
}

- (void)df_dealloc
{
    [self df_clear];
    [self df_dealloc];
}

- (void)df_layoutSubviews
{
    [self df_layoutSubviews];
    
    ViewSetWidth(self.df_bottomView, ScreenWidth);
    ViewSetWidth(self.df_topView, ScreenWidth);
    //    self.df_loadingView.frame = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);// - self.contentInset.top - self.contentInset.bottom);
}

- (void)df_clear
{
    if (self.df_observer) {
        [self removeObserver:self.df_observer forKeyPath:@"contentOffset"];
        [self removeObserver:self.df_observer forKeyPath:@"contentInset"];
        //        [self removeObserver:self.df_observer forKeyPath:@"frame"];
        self.df_observer = nil;
    }
}

- (DFData*)df_setDataWithTag:(NSInteger)tag
{
    DFData* data = [self df_dataWithTag:tag];
    if (!data) {
        data = [[DFData alloc] init];
    }
    self.df_datas[@(tag)] = data;
    self.df_data = data;
    
    [UIView animateWithDuration:0.4 animations:^{
        [self df_updateForDataChange];
    }];
    
    return data;
}

- (DFData*)df_dataWithTag:(NSInteger)tag
{
    return self.df_datas[@(tag)];
}

- (void)df_addDataFetchSuppport:(id<DFDelegate>)delegate
{
    NSParameterAssert(!self.df_loadingView);
    NSParameterAssert(!self.df_topView);
    NSParameterAssert(!self.df_bottomView);
    NSParameterAssert(!self.df_data);
    NSParameterAssert(!self.df_dataFetchDelegate);
    
    float footViewHeight=0;
    if(delegate&&[delegate respondsToSelector:@selector(backFootViewHeight)]){//加载更多的时候，防止表尾和底部视图冲突（隐藏表尾，修改底部视图的y值）
        
        footViewHeight=[delegate backFootViewHeight];
    }
    
    self.df_observer = [ScrollViewObserver new];
    self.df_observer.footViewHeight=footViewHeight;
    
    //kvo
    [self addObserver:self.df_observer forKeyPath:@"contentOffset" options:NSKeyValueObservingOptionNew context:NULL];
    [self addObserver:self.df_observer forKeyPath:@"contentInset" options:NSKeyValueObservingOptionNew context:NULL];
    //    [self addObserver:self.df_observer forKeyPath:@"frame" options:NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld context:NULL];
    
    self.df_dataFetchDelegate = delegate;
    //如果是这种分页模式,或者你也可以自己设置isUseNextPage
    if ([self.df_dataFetchDelegate respondsToSelector:@selector(fetchDidStart:nextPage:finish:)]) {
        
            self.isUseNextPage=true;
    }
    
    
    
    if(!self.isNoAddBottomView){//是否添加底部视图
        
        self.df_bottomView = [[DFBottomView alloc] init];
        self.df_bottomView.allLoadedPrompt = @"亲,到底了!";//_(:з」∠)_";
        [self addSubview:self.df_bottomView];
        ViewSetWidth(self.df_bottomView, ScreenWidth);
    }
    
    //顶部视图
    self.df_topView = [[DFTopView alloc] init:self.backgroundColor];
    [self addSubview:self.df_topView];
    ViewSetWidth(self.df_topView, ScreenWidth);
    
    
    // todo: contentinset change
    //加载视图
    self.df_loadingView = [[LoadingView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    self.df_loadingView.delegate = self;
    [self addSubview:self.df_loadingView];
    self.df_loadingView.hidden = YES;
    //    self.df_loadingView.frame = // - self.contentInset.top - self.contentInset.bottom);
    
    
    
    //初始化数据源
    self.df_datas = [NSMutableDictionary dictionary];
    self.df_data = [[DFData alloc] init];
    self.df_insetsSaved = self.contentInset;
    //    _initialContentInsets = contentInset;
    //    _initialContentInsets.bottom += bottomView.frame.size.height;
    //    _scrollView.contentInset = _initialContentInsets;
    //    _scrollView.scrollIndicatorInsets = contentInset;
    
    self.df_fetchMoreEnabled = YES; //是否开启上拉加载更多
    //    self.scrollIndicatorInsets = insets;
    
    
    [GZCUtility hideScrollIndicator:self];
}

- (NSInteger)df_objectsCount:(DFData*)data
{
    if ([self.df_dataFetchDelegate respondsToSelector:@selector(scrollViewValidObjectsCount:)]) {
        return [self.df_dataFetchDelegate scrollViewValidObjectsCount:self];
    } else {
        return data.objects.count;
    }
}

- (BOOL)df_updateStatus
{
    if (self.df_data.command == DFCommandRefresh) {//页面首次加载或切换刷新的时候
        // for loadingView's frame
        self.df_data.status = DFStatusInitial; //初始化
    }
    
    if (self.df_data.status == DFStatusInitial) {//初始化
        
        self.df_data.status = DFStatusRefreshing;  //标记为刷新
        
    } else if (self.df_data.status == DFStatusFail) { //失败
        
        if (self.df_data.objects.count == 0) {
            
            self.df_data.status = DFStatusRefreshing;
            
        } else {
            
            self.df_data.status = DFStatusIdle;
        }
    }
    
    if (self.df_data.status == DFStatusIdle) {    //加载完成
        
        if (self.df_data.command == DFCommandTop) { //下啦刷新
            
            self.df_data.status = DFStatusRefetching;
            
        } else { //上拉加载更多
            
            NSParameterAssert(self.df_data.command == DFCommandBottom);
            
             if ([self isNextPage]) {
                    
                    self.df_data.status = DFStatusFetchingMore; //还有下一页，标记加载更多
                    
                } else {
                    
                    return NO;
                }
        
            
        }
        
    }
    else if (self.df_data.status == DFStatusFetchingMore) {  //加载更多
        
        if (self.df_data.command == DFCommandTop) {
            
            self.df_data.status = DFStatusRefetching;
            
        } else { //正在加载更多,直接返回
            
            return NO;
        }
        
    }
    else if (self.df_data.status == DFStatusRefetching) {  //刷新
        
        if (self.df_data.command == DFCommandBottom) {
            
            if ([self isNextPage]) {
                    
                    self.df_data.status = DFStatusFetchingMore;
                    
                }
                else
                {
                    
                    return NO;
                }
    
        }
        else{
            
            return  NO;
        }
    }
    
    return YES;
}



-(BOOL) isNextPage {//是否还有下一页

    if(self.isUseNextPage){
    
        if (![NSString isEmpty:self.df_data.nextPage]
            &&![self.df_data.nextPage isEqualToString:@"0"]) {//nextpage不为空，表示还有下一页
            
            return  true;
        }
        return false;
    
    }else{
    
       return   self.df_data.totalCount > [self df_objectsCount:self.df_data];
    
    }
}

- (void)df_startFetch
{
    if (![self df_updateStatus]) {//修改状态
        return;
    }
    
    //    if (self.data.status == FetchStatusRefreshing) {
    //        [self setContentOffset:CGPointMake(0, -self.insetsSaved.top) animated:NO];
    //    }
    
    [UIView animateWithDuration:0.4 animations:^{
        
        [self df_updateForDataChange]; //修改刷新时候的状态（将connectionView向下内容偏移, 转轮开启）
        
        if (self.df_data.status == DFStatusRefetching) {
            
            [self setContentOffset:CGPointMake(self.contentOffset.x, -self.df_insetsSaved.top - self.df_topView.frame.size.height) animated:NO];
        }
        
    }];
    
    
    //计算页码
    int index = 0;
    switch (self.df_data.status) {
            
        case DFStatusRefetching:
        case DFStatusRefreshing:
            index = 0;
            break;
        case DFStatusFetchingMore:
            if (self.isUseNextPage) {
                
                index = self.df_data.nextPage.intValue;
            }
            else{
                
                index = (int)[self df_objectsCount:self.df_data];
            }
            break;
        default:
            NSParameterAssert(0);
            index = 0;
            break;
    }
    
    
    if (self.df_data.operation.executing) { //取消上次请求
        
        [self.df_data.operation cancel];
    }
    
    
    DFData* data = self.df_data;
    if (self.isUseNextPage) {
        
        
        if([self.df_dataFetchDelegate respondsToSelector:@selector(fetchDidStart:nextPage:finish:)]&&self.df_dataFetchDelegate){
        
            [self.df_dataFetchDelegate  fetchDidStart:self nextPage:[Utility convetString:index] finish:^(NSString *nextPage, NSArray *incomings, NSString *error){
                
                [self handleEvent:data error:error totalCount:0 nextPage:nextPage incomings:incomings];
                
            }];
        
        }
        
        
    }
    else{

        if([self.df_dataFetchDelegate respondsToSelector:@selector(fetchDidStart:index:finish:)]&&self.df_dataFetchDelegate){
            
            data.operation = [self.df_dataFetchDelegate fetchDidStart:self index:index finish:^(int totalCount, NSArray *incomings, NSString *error) {
                
                [self handleEvent:data error:error totalCount:totalCount nextPage:nil incomings:incomings];
                
            }];
            
        }

    }
}



-(void) handleEvent:(DFData*) data
              error:(NSString*)error
         totalCount:(int)totalCount
           nextPage:(NSString *)nextPage
          incomings:(NSArray *)incomings
{

    if (data.command == DFCommandRefresh) {
        
        [data.objects removeAllObjects];
    }
    if (error) {
        
        data.status = DFStatusFail;
        
    } else {
        
        
        data.status = DFStatusIdle;//加载完成
        data.lastUpdateDate = [NSDate date];
        
        if (self.isUseNextPage) {
            
            data.nextPage=nextPage;
        }
        else{
            
             data.totalCount = totalCount;
        }
        
        
        
//        NSLog(@"totalCount=%d",totalCount);
//        NSLog(@"datacount=%lu",(unsigned long)data.objects.count);
        
        if (data.command == DFCommandTop) {//下拉刷新
            
            [data.objects removeAllObjects];
        }
        
        [data.objects addObjectsFromArray:incomings];
        
    }
    
    //还原视图状态（内容偏移恢复，转轮消失）
    [UIView animateWithDuration:0.4 animations:^{
        
        if (self.contentOffset.y <= -self.df_insetsSaved.top) {
            
            [self setContentOffset:CGPointMake(0, -self.df_insetsSaved.top) animated:NO];
        }
        
        [self df_updateForDataChangeWithData:data];
        
    }];
    
    if (self.df_data.command == DFCommandRefresh) {//页面首次加载或切换刷新的时候,将页面调整到最上面
        
        self.contentOffset = CGPointMake(0, -self.df_insetsSaved.top);
    }
    
    if ([self respondsToSelector:@selector(reloadData)]) {
        
        [self performSelector:@selector(reloadData)];
    }
    
    if (self.df_dataFetchDelegate&&[self.df_dataFetchDelegate respondsToSelector:@selector(refreshData)]) {
        
        [self.df_dataFetchDelegate refreshData];
    }
}

- (void)loadingViewDataDidReload:(LoadingView*)loadingView
{
    NSParameterAssert(self.df_data.status == DFStatusFail);
    self.df_data.command = DFCommandRefresh;
    [self df_startFetch];
}

- (void)loadingViewEmptyButtonDidClick:(LoadingView*)loadingView
{
    if ([self.df_dataFetchDelegate respondsToSelector:@selector(loadingViewEmptyButtonDidClick:)]) {
        [self.df_dataFetchDelegate loadingViewEmptyButtonDidClick:self];
    }
}

- (void)df_updateForDataChange
{
    [self df_updateForDataChangeWithData:self.df_data];
}

- (void)df_updateForDataChangeWithData:(DFData*)data
{
    //修改topview,bottom的状态 主要是隐藏，转轮状态
    [self.df_topView updateView:data.status];
    
    BOOL hasMoreDataToFetch = [self isNextPage];
    
    [self.df_bottomView updateView:hasMoreDataToFetch];
    

    //修改loadview的状态
    if (data.status == DFStatusRefreshing) {//刷新
        
        self.df_loadingView.hidden = NO;
        self.df_loadingView.status = LoadingViewStatusAnimating;
        
    } else if (data.objects.count == 0) { //数据有空的时候
        
        self.df_loadingView.hidden = NO;
        
        if (data.status == DFStatusIdle) { //加载完成
            
            self.df_loadingView.status = LoadingViewStatusEmpty;
            
        } else if (data.status == DFStatusFail) {  //加载错误
            
            self.df_loadingView.status = LoadingViewStatusError;
        }
        
        
    } else {
        
        self.df_loadingView.hidden = YES;
    }
    
    
    
    
    //设置下拉刷新的时候内容偏移，connectionView向下偏移，转轮显示
    //加载完成，还原connectionView的内容偏移
    UIEdgeInsets insets = self.contentInset;
    if (data.status == DFStatusRefetching) { //首次加载，connectionView向下偏移，转轮显示
        
        if (insets.top != self.df_topView.frame.size.height + self.df_insetsSaved.top) {
            
            insets.top = self.df_topView.frame.size.height + self.df_insetsSaved.top;
        }
        
    } else { //上拉加载更多
        
        if (insets.top != self.df_insetsSaved.top) {
            
            insets.top = self.df_insetsSaved.top;
        }
    }
    
    [self df_setContentInset:insets];
    
    
    //正在加载的时候，不让拖动
     self.scrollEnabled = self.df_loadingView ? self.df_loadingView.hidden : YES;
    //    NSLog(@"%d, %@", self.scrollEnabled, self.df_loadingView);
}

- (void)setDf_loadingView:(LoadingView *)loadingView
{
    objc_setAssociatedObject(self, &ScrollViewLoadingViewKey, loadingView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LoadingView*)df_loadingView
{
    return objc_getAssociatedObject(self, &ScrollViewLoadingViewKey);
}

- (void)setDf_bottomView:(DFBottomView *)bottomView
{
    objc_setAssociatedObject(self, &ScrollViewBottomViewKey, bottomView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DFBottomView*)df_bottomView
{
    return objc_getAssociatedObject(self, &ScrollViewBottomViewKey);
}

- (void)setDf_topView:(DFTopView *)topView
{
    objc_setAssociatedObject(self, &ScrollViewTopViewKey, topView, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DFTopView*)df_topView
{
    return objc_getAssociatedObject(self, &ScrollViewTopViewKey);
}

- (void)setDf_datas:(NSMutableDictionary *)datas
{
    objc_setAssociatedObject(self, &ScrollViewDatasKey, datas, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSMutableDictionary*)df_datas
{
    return objc_getAssociatedObject(self, &ScrollViewDatasKey);
}

- (void)setDf_data:(DFData *)data
{
    objc_setAssociatedObject(self, &ScrollViewDataKey, data, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (DFData*)df_data
{
    return objc_getAssociatedObject(self, &ScrollViewDataKey);
}

- (void)setDf_dataFetchDelegate:(id<DFDelegate>)dataFetchDelegate
{
    objc_setAssociatedObject(self, &DFDelegateKey, dataFetchDelegate, OBJC_ASSOCIATION_ASSIGN);
}

- (id<DFDelegate>)df_dataFetchDelegate
{
    return objc_getAssociatedObject(self, &DFDelegateKey);
}

- (void)setDf_insetsSaved:(UIEdgeInsets)insetsSaved
{
    NSValue* value = [NSValue valueWithUIEdgeInsets:insetsSaved];
    objc_setAssociatedObject(self, &ScrollViewInsetsSavedKey, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (UIEdgeInsets)df_insetsSaved
{
    NSValue* value = objc_getAssociatedObject(self, &ScrollViewInsetsSavedKey);
    return [value UIEdgeInsetsValue];
}

- (void)setDf_observer:(ScrollViewObserver *)observer
{
    objc_setAssociatedObject(self, &ScrollViewObserverKey, observer, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (ScrollViewObserver*)df_observer
{
    return objc_getAssociatedObject(self, &ScrollViewObserverKey);
}

//是否开启下拉刷新
- (void)setDf_refetchEnabled:(BOOL)refetchEnabled
{
    NSNumber* number = [NSNumber numberWithBool:refetchEnabled];
    objc_setAssociatedObject(self, &ScrollViewRefetchEnabledKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)df_refetchEnabled
{
    NSNumber* number = objc_getAssociatedObject(self, &ScrollViewRefetchEnabledKey);
    return [number boolValue];
}

- (void)setDf_fetchMoreEnabled:(BOOL)fetchMoreEnabled
{
    NSNumber* number = [NSNumber numberWithBool:fetchMoreEnabled];
    objc_setAssociatedObject(self, &ScrollViewFetchMoreEnabledKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    
    UIEdgeInsets insets = self.df_insetsSaved;
    if (fetchMoreEnabled) {
        insets.bottom += self.df_bottomView.frame.size.height;
    }
    self.df_bottomView.allLoadedPrompt = @"";
    [self df_setContentInset:insets];
}

- (BOOL)df_fetchMoreEnabled
{
    NSNumber* number = objc_getAssociatedObject(self, &ScrollViewFetchMoreEnabledKey);
    return [number boolValue];
}

- (void)setDf_useCustomLoadingView:(BOOL)useCustomLoadingView
{
    if (useCustomLoadingView) {
        [self.df_loadingView removeFromSuperview];
        self.df_loadingView = nil;
    } else {
        
    }
    NSNumber* number = [NSNumber numberWithBool:useCustomLoadingView];
    objc_setAssociatedObject(self, &ScrollViewUseCustomLoadingViewKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)df_useCustomLoadingView
{
    NSNumber* number = objc_getAssociatedObject(self, &ScrollViewUseCustomLoadingViewKey);
    return [number boolValue];
}

- (void)setIsNoAddBottomView:(BOOL ) isNoAddBottomView
{
    objc_setAssociatedObject(self, &ScrollViewIsNoAddBottomView,@(isNoAddBottomView), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) isNoAddBottomView{
    
    NSNumber* number = objc_getAssociatedObject(self, &ScrollViewIsNoAddBottomView);
    return [number boolValue];
}

- (void)setIsUseNextPage:(BOOL ) isUseNextPageValue
{
    objc_setAssociatedObject(self, &ScrollViewisUseNextPage,@(isUseNextPageValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL) isUseNextPage{
    
    NSNumber* number = objc_getAssociatedObject(self, &ScrollViewisUseNextPage);
    return [number boolValue];
}

@end




@implementation ScrollViewObserver
//kvo
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(UIScrollView*)scrollView change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqualToString:@"contentOffset"]) {
        
        
        
        //        NSLog(@"contentOffset=%f",scrollView.contentOffset.y);
        //下拉刷新
        if (scrollView.df_refetchEnabled) {//开启了下拉刷新
            
            //移到connectionview上面
            ViewSetY(scrollView.df_topView, scrollView.contentOffset.y + scrollView.df_insetsSaved.top);
            ViewSetY(scrollView.df_topView.coverView, -scrollView.contentOffset.y - scrollView.df_insetsSaved.top);
            
            scrollView.df_topView.hidden = scrollView.df_insetsSaved.top + scrollView.contentOffset.y >= 0;
            
            if (/*!_justRefetched &&*/ !scrollView.isDragging && scrollView.contentOffset.y < -scrollView.df_topView.frame.size.height - scrollView.df_insetsSaved.top) {
                
                scrollView.df_data.command = DFCommandTop;
                [scrollView df_startFetch];
            }
            
        } else {
            
            scrollView.df_topView.hidden = YES;
        }
        
        
        //设置底部视图的位置（scrollView.contentSize.height-self.footViewHeight）
        ViewSetY(scrollView.df_bottomView, MAX(scrollView.bounds.size.height - scrollView.df_insetsSaved.top- self.footViewHeight, scrollView.contentSize.height-self.footViewHeight));
        
        //设置loadview的位置
        ViewSetY(scrollView.df_loadingView, scrollView.contentOffset.y);
        
        //上拉加载更多
        if (scrollView.contentOffset.y + scrollView.bounds.size.height > MAX(scrollView.contentSize.height, scrollView.bounds.size.height)) {
            

            if ([scrollView isNextPage]) {
                
                NSLog(@"1");
                scrollView.df_data.command = DFCommandBottom;
                [scrollView df_startFetch];
            }
        }
        
        
        [scrollView sendSubviewToBack:scrollView.df_topView];
        [scrollView sendSubviewToBack:scrollView.df_bottomView];
        [scrollView bringSubviewToFront:scrollView.df_loadingView];
        
        
    }
}

@end
