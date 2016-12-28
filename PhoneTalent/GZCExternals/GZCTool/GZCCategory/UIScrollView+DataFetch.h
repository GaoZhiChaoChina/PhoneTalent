//
//  UIScrollView+DataFetch.h
//  Mic
//
//  Created by chaossy on 14-3-7.
//  Copyright (c) 2014年 chaossy. All rights reserved.
//

#import "LoadingView.h"

typedef enum {
    DFStatusInitial = 0, //初始化
    DFStatusRefetching,    //首次加载
    DFStatusFetchingMore, //加载更多
    DFStatusRefreshing,   //刷新
    DFStatusIdle, //加载完成
    DFStatusFail, //加载错误
} DFStatus;

typedef enum {
    DFCommandRefresh = 0,  //页面首次加载或切换刷新的时候
    DFCommandBottom,       //上拉刷新
    DFCommandTop,          //下拉刷新
} DFCommand;


@protocol DFDelegate;
@class DFTopView, DFBottomView;
@class DFData;
@class AFHTTPRequestOperation;

@interface UIScrollView(DataFetch) <LoadingViewDelegate>

- (void)df_addDataFetchSuppport:(id<DFDelegate>)delegate;
- (void)df_clear;
- (void)df_startFetch;
- (void)df_updateForDataChange;

@property(nonatomic, readonly) DFData* df_data;
- (DFData*)df_dataWithTag:(NSInteger)tag;
- (DFData*)df_setDataWithTag:(NSInteger)tag;

@property(nonatomic, weak) id<DFDelegate> df_dataFetchDelegate;
@property(nonatomic, assign) BOOL df_refetchEnabled; //是否开启下拉刷新
@property(nonatomic, assign) BOOL df_fetchMoreEnabled;//是否开启上拉加载更多
@property(nonatomic, assign) BOOL df_useCustomLoadingView;
@property(nonatomic ,readonly) LoadingView* df_loadingView;
@property(nonatomic, readonly) DFTopView* df_topView;
@property(nonatomic, readonly) DFBottomView* df_bottomView;
@property   BOOL  isNoAddBottomView;
@property   BOOL  isUseNextPage;
@end


@protocol DFDelegate <NSObject>
@optional
- (NSUInteger)scrollViewValidObjectsCount:(UIScrollView*)scrollView;
- (void)loadingViewEmptyButtonDidClick:(UIScrollView*)scrollView;
-(float)backFootViewHeight;
-(void) refreshData;
- (AFHTTPRequestOperation*)fetchDidStart:(UIScrollView*)scrollView nextPage:(NSString*) nextPage  finish:(void (^)(NSString *nextPage, NSArray* incomings, NSString* error))finish;
- (AFHTTPRequestOperation*)fetchDidStart:(UIScrollView*)scrollView index:(int)index finish:(void (^)(int totalCount, NSArray* incomings, NSString* error))finish;
@end


@interface DFTopView : UIView
@property(nonatomic)  float oldOffsetY;
@end


@interface DFBottomView : UIView

@property(nonatomic, strong) NSString* allLoadedPrompt;

@end


@interface DFData : NSObject
@property(nonatomic, strong) NSMutableArray* objects;
@property(nonatomic, assign) DFStatus status;
@property(nonatomic, assign) DFCommand command;
@property(nonatomic, assign) int totalCount;
@property(nonatomic, strong) NSDate* lastUpdateDate;
@property(nonatomic, strong) AFHTTPRequestOperation* operation;
@property(nonatomic, strong) id userInfo;
@property(nonatomic, strong) NSString *nextPage;

@end
