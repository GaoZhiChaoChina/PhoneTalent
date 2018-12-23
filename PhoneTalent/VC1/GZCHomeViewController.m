//
//  GZCHomeViewController.m
//  PhoneTalent
//
//  Created by cloud on 15/12/4.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCHomeViewController.h"
#import "ViewController1.h"
@interface GZCHomeViewController ()<UIScrollViewDelegate>
{
    UIWebView *_webView;
}
@end

@implementation GZCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addNavTitle:@"欢乐购"];
    [self addLeafNavigationButton:@""];

    _webView=[[UIWebView alloc]initWithFrame:CGRectMake(0,0,ScreenWidth,ScreenHeight)];

    _webView.scrollView.scrollEnabled = YES;
    _webView.scalesPageToFit = YES;
    NSMutableURLRequest *requst=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com/"]];
    
    [requst setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [_webView loadRequest:requst];
 
    [self.view addSubview:_webView];
     [GZCUtility hideLeafBarButtonItem:self];
    
    [self addBackNavigationButton];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView.contentOffset.y > 49) {
        [self.customTabBar hiddenTabbar];
    }else{
        [self.customTabBar showTabbar];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
