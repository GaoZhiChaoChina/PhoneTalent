//
//  ZBarQRViewController.m
//  vodSeal
//
//  Created by XiaoCan-iOS on 15/8/25.
//  Copyright (c) 2015年 XiaoCan. All rights reserved.
//

#import "ZBarQRViewController.h"
#import "ZBarSDK.h"
#import "BaseTapSound.h"
@interface ZBarQRViewController ()<ZBarReaderViewDelegate,UIAlertViewDelegate>{
    UIView *zbarVi;
}
@property (strong , nonatomic) UIImageView *lineLabelZbar;
@property (strong , nonatomic) NSTimer *lineTimerZbar;
@property (strong , nonatomic) ZBarReaderView *readerView;
@end

@implementation ZBarQRViewController


- (void)dealloc{
    if ([_lineTimerZbar isValid]) {
        [_lineTimerZbar invalidate];
        _lineTimerZbar = nil;
    }
}

- (void)viewDidAppear:(BOOL)animated{
    [[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

- (void)viewDidDisappear:(BOOL)animated{
    [[UIApplication sharedApplication] setIdleTimerDisabled:NO];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor]
    ;
    //扫描区域宽、高大小，按比例来的
    float QRWIDTH = 220/320.0*ScreenWidth;
    
    _readerView = [ZBarReaderView new];
    _readerView.readerDelegate = self;
    //能否对预览图进行手势缩放
    _readerView.allowsPinchZoom = YES;
    _readerView.trackingColor = [UIColor redColor];
    _readerView.showsFPS = NO;//是否显示帧频率
    [self.view addSubview:_readerView];
    zbarVi=[[UIView alloc]init];
    zbarVi.bounds = CGRectMake(0, 0, QRWIDTH, QRWIDTH);
    zbarVi.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
    _readerView.frame = CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    //定义扫描视图在屏幕中央
    UIView *vi=[[UIView alloc]init];
    vi.bounds = CGRectMake(0, 0, QRWIDTH+10, QRWIDTH+10);
    vi.center = CGPointMake(ScreenWidth / 2, ScreenHeight / 2);
    //_readerView.scanCrop = [self getScanCrop:vi.frame readerViewBounds:_readerView.bounds];
    //扫描区域计算
    _readerView.scanCrop = CGRectMake (( zbarVi.frame.origin.y )/ ScreenHeight ,(zbarVi.frame.origin.x)/ ScreenWidth , QRWIDTH / ScreenHeight , QRWIDTH / ScreenWidth );
    ZBarImageScanner *scanner = _readerView.scanner;
    [scanner setSymbology:ZBAR_I25 config:ZBAR_CFG_ENABLE to:0];
    //关闭闪光灯
    _readerView.torchMode = 0;
    //开始扫描
    [_readerView start];
    
    //半透明背景，只有中间的扫描部分是不透明的，下面的方法就是把扫描外的界面切割成四份，做半透明处理
    UIView *qrBacView = [[UIView alloc]init];//上
    qrBacView.frame = CGRectMake(0, 64, ScreenWidth, zbarVi.frame.origin.y - 64);
    qrBacView.backgroundColor = [UIColor blackColor];
    qrBacView.alpha = 0.6;
    [self.view addSubview:qrBacView];
    
    qrBacView = [[UIView alloc]init];//左
    qrBacView.frame = CGRectMake(0, zbarVi.frame.origin.y, zbarVi.frame.origin.x,ScreenHeight - zbarVi.frame.origin.y);
    qrBacView.backgroundColor = [UIColor blackColor];
    qrBacView.alpha = 0.6;
    [self.view addSubview:qrBacView];
    
    qrBacView = [[UIView alloc]init];//下
    qrBacView.frame = CGRectMake(zbarVi.frame.origin.x, zbarVi.frame.origin.y + QRWIDTH, ScreenWidth - zbarVi.frame.origin.x, ScreenHeight - zbarVi.frame.origin.y - QRWIDTH);
    qrBacView.backgroundColor = [UIColor blackColor];
    qrBacView.alpha = 0.6;
    [self.view addSubview:qrBacView];
    
    qrBacView = [[UIView alloc]init];//右
    qrBacView.frame = CGRectMake(zbarVi.frame.origin.x + QRWIDTH, zbarVi.frame.origin.y, ScreenWidth - zbarVi.frame.origin.x - QRWIDTH, QRWIDTH);
    qrBacView.backgroundColor = [UIColor blackColor];
    qrBacView.alpha = 0.6;
    [self.view addSubview:qrBacView];
    
    
    //扫描框
    UIImageView *qrView = [[UIImageView alloc]initWithFrame:zbarVi.frame];
    qrView.backgroundColor = [UIColor clearColor];
    //扫描栏外面的四个框
    qrView.image = [UIImage imageNamed:@"QRImage.png"];
    [self.view addSubview:qrView];
    _lineLabelZbar = [[UIImageView alloc]initWithFrame:CGRectMake(zbarVi.frame.origin.x+2.0, zbarVi.frame.origin.y + 2.0, QRWIDTH - 4.0, 3.0)];
    _lineLabelZbar.image = [UIImage imageNamed:@"QRLine.png"];
    [self.view addSubview:_lineLabelZbar];
    
    
    //手电筒开关
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(zbarVi.frame.origin.x + QRWIDTH/2.0 - 20, zbarVi.frame.origin.y + zbarVi.frame.size.height + 20, 40, 40);
    btn.selected = NO;
//    [btn setTitle:@"开启闪光灯" forState:UIControlStateNormal];
//    [btn setTitle:@"关闭闪光灯" forState:UIControlStateSelected];
    [btn setImage:[UIImage imageNamed:@"ocr_flash-off.png"] forState:UIControlStateNormal];
    //选择时候的状态
    [btn setImage:[UIImage imageNamed:@"ocr_flash-on.png"] forState:UIControlStateSelected];
    [btn setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
    [btn addTarget:self action:@selector(openOrClose:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
//    //导航栏
//    [self setBaseViewDelegate:self];
//    [self customNavigationTitle:@"扫描二维码" withFont:15.0 andTitleColor:[UIColor whiteColor]];
//    [self customNavigationLeftTitle:nil withImage:[UIImage imageNamed:@"Common_DaoHang_FanHui"] buttonStryle:ONLYIMAGE andtitleColor:nil titleFont:0];
    [self canUseSystemCamera];
}

- (void)leftButtonHaveClick:(UIButton *)sender{
    if ([_lineTimerZbar isValid]) {
        [_lineTimerZbar invalidate];
        _lineTimerZbar = nil;
    }
    _readerView.torchMode = 0;
    [self dismissViewControllerAnimated:YES completion:nil];
}

//给一个定时器，让扫描线在方框中来回移动移动
float moveZbar = 1.0;
- (void)moveLine{
    float upY = zbarVi.frame.origin.y + zbarVi.frame.size.height - 2.0 - 3.0;
    float y = _lineLabelZbar.frame.origin.y;
    y = y+moveZbar;
    CGRect lineFrame=CGRectMake(_lineLabelZbar.frame.origin.x, y, zbarVi.frame.size.width - 4.0, 3.0);
    _lineLabelZbar.frame = lineFrame;
    if (y < zbarVi.frame.origin.y + 2.0 || y > upY) {
        moveZbar = -moveZbar;
    }
    
}

//点击手电筒开关，打开或者关闭，判断是否打开
- (void)openOrClose:(UIButton *)sender{
    sender.selected = !sender.selected;
    if ([sender isSelected]) {
        _readerView.torchMode = 1;
    }else{
        _readerView.torchMode = 0;
    }
}

- (void)readerView:(ZBarReaderView *)readerView didReadSymbols:(ZBarSymbolSet *)symbols fromImage:(UIImage *)image{
    ZBarSymbol *symbol = nil;
    for (symbol in symbols)
        break;
    NSString *text = symbol.data;
    NSLog(@"%@",text);
    [[BaseTapSound shareTapSound]playSystemSound];
    
    [readerView stop];
    _lineLabelZbar.hidden = YES;
    if ([_lineTimerZbar isValid]) {
        [_lineTimerZbar invalidate];
        _lineTimerZbar = nil;
        _lineLabelZbar.hidden = YES;
    }
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"扫描成功" message:text delegate:self cancelButtonTitle:@"重新扫描" otherButtonTitles:@"确认", nil];
    alert.tag = 200;
    [alert show];
}
//alertView的代理，判断点击了什么并做处理
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (alertView.tag == 100) {
        [self leftButtonHaveClick:nil];
    }else if (alertView.tag == 200){
        if (buttonIndex == 0) {
            [_readerView start];
            _lineLabelZbar.hidden = NO;
            _lineTimerZbar = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveLine) userInfo:nil repeats:YES];
            _lineLabelZbar.hidden = NO;
        }else if (buttonIndex == 1){
            
        }
    }

}



//获取扫描区域,在这里貌似 没有什么用
-(CGRect)getScanCrop:(CGRect)rect readerViewBounds:(CGRect)readerViewBounds
{
    CGFloat x,y,width,height;
    
    x = rect.origin.x / readerViewBounds.size.width;
    y = rect.origin.y / readerViewBounds.size.height;
    width = rect.size.width / readerViewBounds.size.width;
    height = rect.size.height / readerViewBounds.size.height;
    
    return CGRectMake(x, y, width, height);
}

//调用系统相机
- (void)canUseSystemCamera{
    if (![BaseTapSound ifCanUseSystemCamera]) {

        _lineLabelZbar.hidden = YES;
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"此应用已被禁用系统相机" message:@"请在iPhone的 \"设置->隐私->相机\" 选项中,允许 \"飞熊视频\" 访问你的相机" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确认", nil];
        alert.tag = 100;
        [alert show];
    }else{
        _lineTimerZbar = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(moveLine) userInfo:nil repeats:YES];
        _lineLabelZbar.hidden = NO;
        
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
