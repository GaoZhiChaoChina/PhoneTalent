//
//  SpecialProductViewController.m
//  Mic
//
//  Created by chaossy on 14-1-27.
//  Copyright (c) 2014年 chaossy. All rights reserved.
//

#import "EventViewController.h"
#import "GZCUtility+VIew.h"

@implementation EventViewController
{
    __weak IBOutlet UIScrollView* _scrollView;
    __weak IBOutlet UIImageView* _imageView;
    __weak IBOutlet UIWebView* _webView;
    __weak IBOutlet UIButton* _shareButton;
    UIButton *stopButton;
    BOOL ret;
    
    __weak IBOutlet UIButton *_backBtn;
    NSString *_titleName;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)dealloc
{
    NSLog(@"EventViewControllerRelease");
}

- (void)viewDidLoad
{
    [super viewDidLoad];


    ret=NO; //是否是复合形的网页

    if ([_item isKindOfClass:[NSURL class]]) { //单纯网页
       
        _webView.scrollView.scrollEnabled = YES;
        
        NSMutableURLRequest *requst=[NSMutableURLRequest requestWithURL:_item];
        
        [requst setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [_webView loadRequest:requst];
        
        ret=NO;

        
    }
    
//    else if ([_item isKindOfClass:[Event class]]) { //混合形网页(原生图片加webview)
//        
//        Event *_event=_item;
//        
//        //获取专题顶部图片，在里面直接修改实体类内容
////        [[ProductManager sharedProductManager] fetchEventDetailInfo:_item finish:^(NSString *error) {
////            
////            if (!error) {
////                
////                
////                //是否存在顶部图片
////                _shareButton.hidden = NO;
////                __weak __typeof(_imageView)weakImageView = _imageView;
////
////                [_imageView setImageWithURLRequest:[NSURLRequest requestWithURL:[_event topPicURL]]
////                                  placeholderImage:nil
////                                           success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
////                    
////                    
////                    __strong __typeof(_imageView)strongImageView = weakImageView;
////                    strongImageView.image = image;
////                    [strongImageView sizeToFit];
////                                               
////                    ret=YES;
////                    ViewSetY(_webView, _imageView.frame.size.height);
////                    
////                    
////                } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
////
////                    
////                }];
//        
//                NSLog(@"---%@",_event.url);
//                NSMutableURLRequest *requst=[NSMutableURLRequest requestWithURL:_event.url];
//
//                [requst setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
//                [_webView loadRequest:requst];
////            }
////        }];
//    }
    
    
 

    //后台有设置name,优先用它
//    _titleName=[self.parameter objectForKey:@"tempName"];
//    if ([NSString isEmpty:_titleName]==false) {
//        
//        self.navigationItem.title=_titleName;
//    }
 
    
    if (self.isMainPage) {//一级页面不显示返回
        
        [GZCUtility hideLeafBarButtonItem:self];
        [_webView setHeight:ScreenContentHeight];//有tabbar所以高度特殊处理
    
    }
    
       [GZCUtility hideScrollIndicator:_scrollView];
       [GZCUtility hideScrollIndicator:_webView.scrollView];
}



- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    int hight = [[webView stringByEvaluatingJavaScriptFromString:@"document.body.clientHeight"] intValue];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
//        if ([NSString isEmpty:_titleName]) { //后台未设置的时候，取网页的title
//            
//             self.navigationItem.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
//        }
        

        stopButton.hidden=NO;
    });
    
    NSLog(@"-------%d",hight);
    
    if (ret==NO) { //单纯的网页
        
        _webView.scrollView.scrollEnabled = YES;
        ViewSetY(_webView, 0);
        
    }else{ //复合形网页
        
        _webView.scrollView.scrollEnabled = NO;
        _webView.height=hight;
        
        float scrollH=_webView.frame.origin.y + _webView.frame.size.height;
        if (self.isMainPage) {
        
            scrollH+=self.tabBarController.tabBar.height;

        }
        _scrollView.contentSize = CGSizeMake(ScreenWidth, scrollH);
    }
    
//    [_webView webViewDidFinishLoad:webView];
    
    
  
    
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    stopButton.hidden=NO;
    

}

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    //    NSLog(@"---- %@", request);
//    return [_webView webView:webView shouldStartLoadWithRequest:request navigationType:navigationType];
    return YES;
}

//- (IBAction)shareButtonDidClick:(id)sender
//{
//    [shareViewOwner showWithModel:_event];
//}

//- (void)shareBegan:(MicSharePlatform)sharePlatform
//{
//    if (sharePlatform != MicSharePlatformSMS) {
//        [self showLoading:nil interactonEnabled:NO];
//    }
//}
//
//- (void)shareEnded:(MicSharePlatform)sharePlatform result:(MicShareResult)result message:(NSString *)message
//{
//    [self dismissLoading];
//    [self showMessage:message];
//    [shareViewOwner dismiss];
//}

- (IBAction)popViewController:(id)sender
{
    if ([_webView canGoBack]) {
        
        [_webView goBack];
        
    } else {
        
        [stopButton removeFromSuperview];
        [self.navigationController popViewControllerAnimated:YES];
    }
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [stopButton removeFromSuperview];
    stopButton.hidden=YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    _shareButton.hidden=YES;
//    stopButton.hidden=NO;
    
}
-(void)stop{
    [stopButton removeFromSuperview];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
