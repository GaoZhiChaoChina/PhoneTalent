//
//  GZCPuzzleGameViewController.m
//  PhoneTalent
//
//  Created by cloud on 15/12/14.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCPuzzleGameViewController.h"
@interface GZCPuzzleGameViewController ()
{
    CGFloat _everynumber;
}
@end

@implementation GZCPuzzleGameViewController
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self addNavTitle:@"拼图游侠"];
    self.navigationController.navigationBarHidden = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self addLeafNavigationButton:@"title_back"];
    [self initImage];
  
}

- (void)initImage{
    NSDictionary *dict = [[NSDictionary alloc] init];
    _everynumber= (ScreenWidth - 40)/self.numberX;
    
    dict = [self SeparateImage:[UIImage imageNamed:@"Pom1.png"] ByX:self.numberX andY:self.numberY cacheQuality:1];
    
    _tempimage = [[UIImageView alloc] initWithFrame:CGRectMake(20+_everynumber*(self.numberX-1),20+_everynumber*(self.numberY-1), _everynumber, _everynumber)];
    self.tempimage.tag = 100;
    [self.view addSubview:self.tempimage];
    
    
    for(int i =0;i<self.numberX;i++)
    {
        for (int j = 0; j<self.numberY; j++)
        {
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString *filepath = [path stringByAppendingPathComponent:[NSString stringWithFormat:@"win_%d_%d.jpg",i,j]];
            UIImage *image = [UIImage imageWithContentsOfFile:filepath];
            
            self.imgView = [[ImageView alloc] initWithImage:image];
            
            self.imgView.tag = i*(self.numberX-1)+j;
            if(i==1)
            {
                self.imgView.tag = i*(self.numberX-1)+j+1;
            }
            if(i==2)
            {
                self.imgView.tag = i*(self.numberX-1)+j+2;
            }
            if(i==3)
            {
                self.imgView.tag = i*(self.numberX-1)+j+3;
            }
            if(i==4)
            {
                self.imgView.tag = i*(self.numberX-1)+j+4;
            }
            if(i==5)
            {
                self.imgView.tag = i*(self.numberX-1)+j+5;
            }
            
            self.imgView.delegate = self;
            self.imgView.frame = CGRectMake(_everynumber*i+20, _everynumber*j+20, _everynumber, _everynumber);
            [self.view addSubview:self.imgView];
        }
    }
    ImageView *img=(ImageView *)[self.view viewWithTag:self.imgView.tag];
    img.hidden= YES;
}

-(void)movedeciton:(UIImageView *)imageview
{
    CGFloat wid = imageview.frame.origin.x;
    CGFloat hig = imageview.frame.origin.y;
    
    if (wid+_everynumber-2<self.tempimage.frame.origin.x  && self.tempimage.frame.origin.x<wid+_everynumber+2 ) {
        if (hig-2<self.tempimage.frame.origin.y && self.tempimage.frame.origin.y < hig+2) {
            NSLog(@"right");
            [self rightchange:imageview];
        }
        
    }
    if (wid-_everynumber-2<self.tempimage.frame.origin.x && self.tempimage.frame.origin.x<wid-_everynumber+2 ) {
        if (hig-2 < self.tempimage.frame.origin.y && self.tempimage.frame.origin.y<hig+2) {
            NSLog(@"left");
            [self leftchange:imageview];
            
        }
    }
    
    if (hig+_everynumber-2 <self.tempimage.frame.origin.y && self.tempimage.frame.origin.y<hig+_everynumber+2) {
        if (wid-2<self.tempimage.frame.origin.x  && self.tempimage.frame.origin.x<wid+2) {
            NSLog(@"down");
            [self downchange:imageview];
        }
    }
    
    if (hig-_everynumber-2 < self.tempimage.frame.origin.y  && self.tempimage.frame.origin.y<hig-_everynumber+2) {
        if (wid-2<self.tempimage.frame.origin.x && self.tempimage.frame.origin.x < wid+2) {
            NSLog(@"up");
            [self upchange:imageview];
        }
    }
    
}


-(void)upchange:(UIImageView *)image
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    image.frame = CGRectMake(image.frame.origin.x, image.frame.origin.y-_everynumber, _everynumber, _everynumber);
    self.tempimage.frame = CGRectMake(image.frame.origin.x,image.frame.origin.y+_everynumber , _everynumber, _everynumber);
    [UIView  commitAnimations];
}
-(void)leftchange:(UIImageView *)image
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    image.frame = CGRectMake(image.frame.origin.x-_everynumber, image.frame.origin.y, _everynumber, _everynumber);
    self.tempimage.frame = CGRectMake(image.frame.origin.x+_everynumber,image.frame.origin.y, _everynumber, _everynumber);
    [UIView  commitAnimations];
}
-(void)rightchange:(UIImageView *)image
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    image.frame = CGRectMake(image.frame.origin.x+_everynumber, image.frame.origin.y, _everynumber, _everynumber);
    self.tempimage.frame = CGRectMake(image.frame.origin.x-_everynumber,image.frame.origin.y, _everynumber, _everynumber);
    [UIView  commitAnimations];
}
-(void)downchange:(UIImageView *)image
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3f];
    [UIView setAnimationDelegate:self];
    image.frame = CGRectMake(image.frame.origin.x, image.frame.origin.y+_everynumber, _everynumber, _everynumber);
    self.tempimage.frame = CGRectMake(image.frame.origin.x,image.frame.origin.y-_everynumber , _everynumber, _everynumber);
    [UIView  commitAnimations];
}

-(NSDictionary*)SeparateImage:(UIImage*)image ByX:(int)x andY:(int)y cacheQuality:(float)quality
{
    
    //kill errors
    if (x<1) {
        NSLog(@"illegal x!");
        return nil;
    }else if (y<1) {
        NSLog(@"illegal y!");
        return nil;
    }
    if (![image isKindOfClass:[UIImage class]]) {
        NSLog(@"illegal image format!");
        return nil;
    }
    
    //attributes of element
    float _xstep=image.size.width*1.0/y;
    float _ystep=image.size.height*1.0/x;
    
    NSMutableDictionary*_mutableDictionary=[[NSMutableDictionary alloc]initWithCapacity:1];
    
    NSString*prefixName=@"win";
    
    //snap in context and create element image view
    for (int i=0; i<x; i++)
    {
        for (int j=0; j<y; j++)
        {
            CGRect rect=CGRectMake(_xstep*j, _ystep*i, _xstep, _ystep);
            CGImageRef imageRef=CGImageCreateWithImageInRect([image CGImage],rect);
            UIImage* elementImage=[UIImage imageWithCGImage:imageRef];
            
            UIImageView*_imageView=[[UIImageView alloc] initWithImage:elementImage];
            _imageView.frame=rect;
            NSString*_imageString=[NSString stringWithFormat:@"%@_%d_%d.jpg",prefixName,i,j];
            [_mutableDictionary setObject:_imageView forKey:_imageString];
            //CFRelease(imageRef);
            if (quality<=0)
            {
                continue;
            }
            quality=(quality>1)?1:quality;
            
            NSString *path = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents"];
            NSString*_imagePath=[path stringByAppendingPathComponent:_imageString];			NSData* _imageData=UIImageJPEGRepresentation(elementImage, quality);
            [_imageData writeToFile:_imagePath atomically:YES];
        }
    }
    //return dictionary including image views
    NSDictionary *_dictionary=_mutableDictionary;
    return _dictionary;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
