//
//  ViewController.m
//  DemoText
//
//  Created by gaozhichao on 2016/10/21.
//  Copyright © 2016年 gaozhichao. All rights reserved.
//

#import "DrawLinesViewController.h"
#import <objc/runtime.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "UIImage+ImageEffects.h"
#import "CustomView.h"
#import "AppSystemManager.h"
#import "NSString+JsonToDic.h"
static void *CustomAlertView =  @"CustomAlertView";
@interface DrawLinesViewController ()<UIAlertViewDelegate>
 @property (nonatomic, strong) CADisplayLink *displayLink;
@property (nonatomic, assign) int countNumber;

@end


@implementation DrawLinesViewController

@synthesize string = _myString;


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.string = @"ha";
    
    _myString = @"niha";
    
    
    CustomView *customView = [[CustomView alloc]initWithFrame:CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height)];
    [self.view addSubview:customView];
    
    NSDictionary *dic = (NSDictionary *)[AppSystemManager app_getSystemInfo:0];
    
    NSLog(@"%@",dic);
    
    NSLog(@"%@",[AppSystemManager app_getSystemInfo:APP_CFBundleDisplayName]);

    
    
       
    UIImageView *image = [[UIImageView alloc]initWithImage:[[UIImage imageNamed:@"q" ] imageWithColor:[UIColor colorWithRed:((float)((0x111111 & 0xFF0000) >> 16))/255.0 green:((float)((0x111111 & 0xFF00) >> 8))/255.0 blue:((float)(0x111111 & 0xFF))/255.0 alpha:1]]];
//    image.backgroundColor = [UIColor redColor];
    image.frame = CGRectMake(100, 300, 100, 100);
    [self.view addSubview:image];
    
    UIImageView *image1 = [[UIImageView alloc]initWithImage:[UIImage ff_imageWithColor:[UIColor redColor]]];
    //    image.backgroundColor = [UIColor redColor];
    image1.backgroundColor = [UIColor redColor];
    image1.center = CGPointMake(100, 290);
//    image1.frame = CGRectMake(100, 450, 10, 10);
    [self.view addSubview:image1];
    
    [NSString dictionaryWithJsonString:@"affagaerhwru5u5"];
    
//    [self cusAlertView];
    NSString *goToWebViewName;
    
#if sdf
    goToWebViewName =  @"FFBrandNavWebViewController";
#else
    goToWebViewName =  @"FFWebBrowserViewController";
#endif
    
//    [[ZCFingerSDK sharedInstance] authenticateUser:self];
    
//    [self authenticateUser];
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateTextColor)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    self.displayLink.paused = YES;
    self.displayLink.frameInterval = 60;
    
    self.countNumber = 0;
    [self startAnimation];
    
    

}


-(void)updateTextColor{
    
    NSLog(@"输出字幕%f==%d",self.displayLink.timestamp,self.countNumber++);
    
}
- (void)startAnimation{
//    self.beginTime = CACurrentMediaTime();
    self.displayLink.paused = NO;
}
- (void)stopAnimation{
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}

- (void)cusAlertView{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"niha" message:@"" delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:@"contiune", nil];
    
    void (^block)(NSInteger) = ^(NSInteger butonIndex){
        
        if (butonIndex == 0) {
            [self doCancel];
            
        }else{
            [self doOther];
        }
        
    };
    
    objc_setAssociatedObject(alert, CustomAlertView, block, OBJC_ASSOCIATION_COPY);
    
    [alert show];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    void (^block)(NSInteger)= objc_getAssociatedObject(alertView, CustomAlertView);
    
    block(buttonIndex);
    
}

- (void)doCancel{
    
}
- (void)doOther{
    
}

- (NSString *)description{
    
    return [NSString stringWithFormat:@"<%@: %p,\" %@ %@ >",[self class],self , _myString,self.string];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
