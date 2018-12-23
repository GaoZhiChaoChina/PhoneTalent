//
//  NinaPagerView.m
//  NinaPagerView
//
//  Created by 高志超 on 16/3/23.
//  Copyright © 2016年 高志超. All rights reserved.
//

#import "NinaPagerView.h"
#import "UIParameter.h"
#import "NinaBaseView.h"
#define MaxNums  10

@implementation NinaPagerView
{
    NinaBaseView *_pagerView;
    NSArray *_titleArray;
    NSArray *_classVCArray;
    NSArray *_colorArray;
    NSMutableArray *viewNumArray;
    BOOL viewAlloc[MaxNums];
    BOOL fontChangeColor;
}

- (instancetype)initWithTitles:(NSArray *)titles WithVCs:(NSArray *)childVCs WithColorArrays:(NSArray *)colors {
    if (self = [super init]) {
        //Need You Edit,title for the toptabbar
        self.frame = CGRectMake(0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT);
        _titleArray = titles;
        _classVCArray = childVCs;
        _colorArray = colors;
         [self createPagerView:_titleArray WithVCs:_classVCArray WithColors:_colorArray];
    }
    return self;
}

#pragma mark - CreateView
- (void)createPagerView:(NSArray *)titles WithVCs:(NSArray *)childVCs WithColors:(NSArray *)colors {
    viewNumArray = [NSMutableArray array];
    //No Need to edit
    if (colors.count > 0) {
        for (NSInteger i = 0; i < colors.count; i++) {
            switch (i) {
                case 0:
                     _selectColor = colors[0];
                    break;
                case 1:
                    _unselectColor = colors[1];
                    break;
                case 2:
                    _underlineColor = colors[2];
                    break;
                default:
                    break;
            }  
        }
    }
    if (titles.count > 0 && childVCs.count > 0) {
        _pagerView = [[NinaBaseView alloc] initWithFrame:CGRectMake(0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT) WithSelectColor:_selectColor WithUnselectorColor:_unselectColor WithUnderLineColor:_underlineColor];
        _pagerView.titleArray = _titleArray;
        [_pagerView addObserver:self forKeyPath:@"currentPage" options:NSKeyValueObservingOptionOld | NSKeyValueObservingOptionNew context:nil];
        [self addSubview:_pagerView];
        //First ViewController present to the screen
        if (_classVCArray.count > 0 && _titleArray.count > 0) {
            NSString *className = _classVCArray[0];
            Class class = NSClassFromString(className);
            if (class) {
                UIViewController *ctrl = class.new;
                ctrl.view.frame = CGRectMake(FUll_VIEW_WIDTH * 0, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT - PageBtn);
                [_pagerView.scrollView addSubview:ctrl.view];
                viewAlloc[0] = YES;
            }
        }
    }else {
        NSLog(@"You should correct titlesArray or childVCs count!");
    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context {
    if ([keyPath isEqualToString:@"currentPage"]) {
        NSInteger page = [change[@"new"] integerValue];
        if (_titleArray.count > 5) {
            CGFloat topTabOffsetX = 0;
            if (page >= 2) {
                if (page <= _titleArray.count - 3) {
                    topTabOffsetX = (page - 2) * More5LineWidth;
                }
                else {
                    if (page == _titleArray.count - 2) {
                        topTabOffsetX = (page - 3) * More5LineWidth;
                    }else {
                        topTabOffsetX = (page - 4) * More5LineWidth;
                    }
                }
            }
            else {
                if (page == 1) {
                    topTabOffsetX = 0 * More5LineWidth;
                }else {
                    topTabOffsetX = page * More5LineWidth;
                }
            }
            [_pagerView.topTab setContentOffset:CGPointMake(topTabOffsetX, 0) animated:YES];
        }
        for (NSInteger i = 0; i < _titleArray.count; i++) {
            if (page == i && i <= _classVCArray.count - 1) {
                NSString *className = _classVCArray[i];
                Class class = NSClassFromString(className);
                if (class && viewAlloc[i] == NO) {
                    UIViewController *ctrl = class.new;
                    ctrl.view.frame = CGRectMake(FUll_VIEW_WIDTH * i, 0, FUll_VIEW_WIDTH, FUll_CONTENT_HEIGHT - PageBtn);
                    [_pagerView.scrollView addSubview:ctrl.view];
                    viewAlloc[i] = YES;
                }else if (!class) {
                    NSLog(@"您所提供的vc%li类并没有找到。  Your Vc%li is not found in this project!",(long)i + 1,(long)i + 1);
                }
            }else if (page == i && i > _classVCArray.count - 1) {
                NSLog(@"您没有配置对应Title%li的VC",(long)i + 1);
            }
        }
    }
}

@end
