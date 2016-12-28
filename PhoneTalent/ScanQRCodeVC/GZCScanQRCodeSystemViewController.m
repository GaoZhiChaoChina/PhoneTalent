//
//  GZCScanQRCodeSystemViewController.m
//  PhoneTalent
//
//  Created by cloud on 15/12/4.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCScanQRCodeSystemViewController.h"
#import <AVFoundation/AVFoundation.h>
//#import "ZBarQRViewController.h"
//#import "ZBarSDK.h"
static const char *kScanQRCodeQueueName = "ScanQRCodeQueue";

@interface GZCScanQRCodeSystemViewController () <AVCaptureMetadataOutputObjectsDelegate,UIAlertViewDelegate,GZCBaseViewControllerDelegate,UIImagePickerControllerDelegate>

@property (strong, nonatomic) UIView *sanFrameView;
@property (strong, nonatomic) UIButton *button;
@property (strong, nonatomic) UIButton *lightButton;

@property (nonatomic) AVCaptureSession *captureSession;
@property (nonatomic) AVCaptureVideoPreviewLayer *videoPreviewLayer;
@property (nonatomic) BOOL lastResult;
@property (nonatomic, strong) UIImagePickerController *imagePicer;

@end

@implementation GZCScanQRCodeSystemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavTitle:@"扫一扫"];
    [self.button setTitle:@"开始" forState:UIControlStateNormal];
    [self.lightButton setTitle:@"打开照明" forState:UIControlStateNormal];
    _lastResult = YES;
    [self startReading];
    self.baseViewDelegate = self;
    [self addRightNavigationButtonTitle:@"相册" pressImage:@""];
}

- (UIView *)sanFrameView{
    if (!_sanFrameView) {
        _sanFrameView = [[UIView alloc]initWithFrame:CGRectMake(40, 100, 300, 300)];
        [self.view addSubview:_sanFrameView];
    }
    return _sanFrameView;
}

- (UIButton *)button{
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.frame = CGRectMake(0, 0, 100, 40);
        _button.center =  CGPointMake(self.view.center.x, 500);
        _button.backgroundColor = [UIColor redColor];
        [_button addTarget:self action:@selector(startScanner:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_button];
    }
    return _button;
}

- (UIButton *)lightButton{
    if (!_lightButton) {
        _lightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _lightButton.bounds = CGRectMake(0, 0, 100, 40);
        _lightButton.center =  CGPointMake(self.view.center.x, 50);
        _lightButton.backgroundColor = [UIColor blueColor];
        [_lightButton addTarget:self action:@selector(openSystemLight:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_lightButton];

    }
    return _lightButton;
}

- (void)dealloc
{
    [self stopReading];
}

-(void) navBarRightBtnClick{
    
    [self stopReading];
    [self loadImagePickerView];
  
}

#pragma mark -- UIImagePicker

- (void)loadImagePickerView
{
    if (!_imagePicer) {
        _imagePicer = [[UIImagePickerController alloc] init];
        _imagePicer.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        _imagePicer.delegate = self;
        _imagePicer.allowsEditing = YES;
    }
    [self presentViewController:_imagePicer animated:YES completion:^{
        
    }];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    
    __weak __typeof(self) weakSelf = self;
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    
    [self dismissViewControllerAnimated:YES completion:^{
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        
        [strongSelf getInfoWithImage:image];
    }];
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self startReading];
    [self.imagePicer dismissViewControllerAnimated: YES completion:nil];
    
}
//获取图片信息
-(void)getInfoWithImage:(UIImage *)img{
    
    
    if ((img.size.width >280)&&(img.size.height >280))
    {
        img = [self scaleToSize:img size:CGSizeMake(280, 280)];
    }
    
    UIImage *loadImage= img;
    
    CGImageRef imageToDecode = loadImage.CGImage;
    
    ZXLuminanceSource *source = [[ZXCGImageLuminanceSource alloc] initWithCGImage:imageToDecode];
    
    ZXHybridBinarizer *binarizer = [[ZXHybridBinarizer alloc] initWithSource: source];
    
    ZXBinaryBitmap *bitmap = [[ZXBinaryBitmap alloc] initWithBinarizer:binarizer];
    
    NSError *error = nil;
    
    ZXDecodeHints *hints = [ZXDecodeHints hints];
    
    ZXQRCodeMultiReader * reader = [[ZXQRCodeMultiReader alloc]init];
    
    NSArray *rs =[reader decodeMultiple:bitmap hints:hints error:&error];
    
    for (ZXResult *resul in rs) {
        [self scanQRCodeSuccess:resul.text];
    }
    
}


//二维码缩放识别 针对于zxing识别图片的限制
- (UIImage *)scaleToSize:(UIImage *)img size:(CGSize)size{
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    // 绘制改变大小的图片
    [img drawInRect:CGRectMake(0, 0, size.width, size.height)];
    // 从当前context中创建一个改变大小后的图片
    UIImage* scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    // 返回新的改变大小后的图片
    return scaledImage;
}

- (void)scanQRCodeSuccess:(NSString *)urlString
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlString] options:@{} completionHandler:^(BOOL success) {
        
    }];
}

- (BOOL)startReading
{
    [_button setTitle:@"停止" forState:UIControlStateNormal];
    // 获取 AVCaptureDevice 实例
    NSError * error;
    AVCaptureDevice *captureDevice = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    // 初始化输入流
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:captureDevice error:&error];
    if (!input) {
        NSLog(@"%@", [error localizedDescription]);
        return NO;
    }
    // 创建会话
    _captureSession = [[AVCaptureSession alloc] init];
    // 添加输入流
    [_captureSession addInput:input];
    // 初始化输出流
    AVCaptureMetadataOutput *captureMetadataOutput = [[AVCaptureMetadataOutput alloc] init];
    // 添加输出流
    [_captureSession addOutput:captureMetadataOutput];
    
    // 创建dispatch queue.
    dispatch_queue_t dispatchQueue;
    dispatchQueue = dispatch_queue_create(kScanQRCodeQueueName, NULL);
    [captureMetadataOutput setMetadataObjectsDelegate:self queue:dispatchQueue];
    // 设置元数据类型 AVMetadataObjectTypeQRCode
    [captureMetadataOutput setMetadataObjectTypes:[NSArray arrayWithObject:AVMetadataObjectTypeQRCode]];
    
    // 创建输出对象
    _videoPreviewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_captureSession];
    [_videoPreviewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    [_videoPreviewLayer setFrame:self.sanFrameView.layer.bounds];
    [_sanFrameView.layer addSublayer:_videoPreviewLayer];
    // 开始会话
    [_captureSession startRunning];
    
    return YES;
}

- (void)stopReading
{
    [_button setTitle:@"开始" forState:UIControlStateNormal];
    // 停止会话
    [_captureSession stopRunning];
    _captureSession = nil;
}

- (void)reportScanResult:(NSString *)result
{
    [self stopReading];
    if (!_lastResult) {
        return;
    }
    _lastResult = NO;
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"二维码扫描"
                                                    message:result
                                                   delegate:self
                                          cancelButtonTitle:@"取消"
                                          otherButtonTitles:@"确定",nil];
    [alert show];
    // 以及处理了结果，下次扫描
    _lastResult = YES;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            break;
        case 1:
            [self scanQRCodeSuccess:alertView.message];
            break;
            
        default:
            break;
    }
}

- (void)systemLightSwitch:(BOOL)open
{
    if (open) {
        [_lightButton setTitle:@"关闭照明" forState:UIControlStateNormal];
    } else {
        [_lightButton setTitle:@"打开照明" forState:UIControlStateNormal];
    }
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    if ([device hasTorch]) {
        [device lockForConfiguration:nil];
        if (open) {
            [device setTorchMode:AVCaptureTorchModeOn];
        } else {
            [device setTorchMode:AVCaptureTorchModeOff];
        }
        [device unlockForConfiguration];
    }
}

#pragma AVCaptureMetadataOutputObjectsDelegate

-(void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects
      fromConnection:(AVCaptureConnection *)connection
{
    if (metadataObjects != nil && [metadataObjects count] > 0) {
        AVMetadataMachineReadableCodeObject *metadataObj = [metadataObjects objectAtIndex:0];
        NSString *result;
        if ([[metadataObj type] isEqualToString:AVMetadataObjectTypeQRCode]) {
            result = metadataObj.stringValue;
        } else {
            NSLog(@"不是二维码");
        }
        [self performSelectorOnMainThread:@selector(reportScanResult:) withObject:result waitUntilDone:NO];
    }
}
- (void)startScanner:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([button.titleLabel.text isEqualToString:@"开始"]) {
        [self startReading];
    } else {
        [self stopReading];
    }
}

- (void)openSystemLight:(id)sender
{
    UIButton *button = (UIButton *)sender;
    if ([button.titleLabel.text isEqualToString:@"打开照明"]) {
        [self systemLightSwitch:YES];
    } else {
        [self systemLightSwitch:NO];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
