//
//  ImageView.m
//  Genuine Parts
//
//  Created by 谢鑫 on 12-3-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ImageView.h"
#import <QuartzCore/QuartzCore.h>
#import "GZCFileController.h"


@implementation ImageView

@synthesize delegate;

- (id) initWithImage:(UIImage *)image
{
    if (self = [super initWithImage:image]) {
        [self setUserInteractionEnabled:YES];
        [self setMultipleTouchEnabled:YES];
        self.layer.borderWidth = 2;
        self.layer.borderColor = UIColor.redColor.CGColor;
        
    }
    return self;
}

-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if([delegate respondsToSelector:@selector(movedeciton:)])
    {
        [delegate movedeciton:self];
    }
}


-(void) dealloc{

    NSLog(@"ImageViewRelease");
}

//自适应大小图片(工程目录)
- (id)initWithFrame:(CGRect)frame
           ImageUrl:(NSString*)imgurl
         IsAutoSize:(BOOL) IsAutoSize{
    
    self = [super initWithFrame:frame];
    if (self) {
    
		
		UIImage *img=[UIImage imageNamed:imgurl];
        
        if (IsAutoSize) {
            
            frame.size.width = img.size.width;
            frame.size.height = img.size.height;
            self.frame = frame;
        }
   
		[self setImage:img];
	 
		
    }
    return self;
}

//自适应大小图片（沙盒）
- (id)initWithFrame:(CGRect)frame
   ImageDocumentUrl:(NSString*)ImageDocumentUrl
         IsAutoSize:(BOOL) IsAutoSize{
    
    self = [super initWithFrame:frame];
    if (self) {
    
		NSString *path =[GZCFileController DocumentPath:ImageDocumentUrl];
		UIImage *img=[[UIImage alloc] initWithContentsOfFile:path];
        
        
        if (IsAutoSize) {
            
            frame.size.width = img.size.width;
            frame.size.height = img.size.height;
            self.frame = frame;
        }
        
		[self setImage:img];
		 
    }
    return self;
}


//重新设置图片 工程
-(void) setCustomImage:(NSString*)imgurl{

    NSString *path = [[NSBundle mainBundle] pathForResource:imgurl ofType:@""];
    UIImage *img=[[UIImage alloc] initWithContentsOfFile:path];
    [self setImage:img];
    
}

//重新设置图片 沙盒
-(void) setCustomImageDocument:(NSString*)imgurl{

    NSString *path = [GZCFileController DocumentPath:imgurl];
    UIImage *img=[[UIImage alloc] initWithContentsOfFile:path];
    [self setImage:img];
}
 

@end
