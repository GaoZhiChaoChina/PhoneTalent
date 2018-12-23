//
//  GZCMineViewController.m
//  PhoneTalent
//
//  Created by cloud on 15/12/4.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCMineViewController.h"
#import "GZCHeaderView.h"

@interface GZCMineViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) GZCHeaderView *headerView;     // 上面蓝色的 view，可以自定义
@property (strong, nonatomic) UITableView *tableView;
@property (assign, nonatomic) CGFloat headerViewHeight;     // headerView 高度

@end

@implementation GZCMineViewController

+ (void)load{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [GZCUtility setClearColorTheme:self.navigationController];
    self.headerViewHeight = 180;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addLeafNavigationButton:@""];
    
    [self.view addSubview:self.tableView];
    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@(0));
    }];
    
    [self.view addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(@(0));
        make.height.equalTo(@(self.headerViewHeight));
    }];
}
    
    // 监听 tableView.contentOffset，也可以用 kvo 监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    
    CGRect frame = self.headerView.frame;
    if (offsetY < 0) {
        frame.size.height = self.headerViewHeight - offsetY;
        frame.origin.y = 0;             // 及时归零
    } else {
        frame.size.height = self.headerViewHeight;
        frame.origin.y = - offsetY;
    }
    self.headerView.frame = frame;
}
    
    // --------------------------- 以下代码不是实验重点 ---------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
        cell.textLabel.text = @"hello world";
    }
    return cell;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterViewID"];
    if (view == nil) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterViewID"];
        view.contentView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];;
    }
    return view;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
//        _tableView.sectionHeaderHeight = 20;
        _tableView.showsVerticalScrollIndicator = false;
        
        // 占位用的 view，高度 180
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 1, self.headerViewHeight)];
        view.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = view;
        
        // 占位用的 view，高度 180
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(view.frame), CGRectGetWidth(view.frame), 10)];
        lineView.backgroundColor = [UIColor clearColor];
        _tableView.tableHeaderView = lineView;
    }
    return _tableView;
}
    
    // 蓝色的 headerView
- (GZCHeaderView *)headerView {
    if (_headerView == nil) {
        _headerView = [[GZCHeaderView alloc] init];
    }
    return _headerView;
}
    
@end
