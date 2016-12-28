//
//  ButtonView.m
//  Genuine Parts
//
//  Created by 李 慧 on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "ButtonView.h"
#import "GZCFileController.h"
 

@implementation ButtonView
 



-(id) initWithFrameAndMoreProject:(CGRect)frame
                         path:(NSString*)path
                         title:(NSString*)title
                         isExtrude:(BOOL) isExtrude
                         ExtrudeLeft:(float)ExtrudeLeft
                         ExtrudeTop:(float) ExtrudeTop
                         HighlightedImage:(NSString*) HighlightedImage
                         controlState:(UIControlState) controlState
                        sourceMode:(FileMode) sourceMode;
{
    
	self = [super initWithFrame:frame];
	if(path!=nil)
	{
        
        NSString *filepath= [self backPath:sourceMode path:path];
        UIImage *buttonImageNormal=[UIImage imageWithContentsOfFile:filepath];
        
        if(isExtrude){ //如果拉伸
            
            UIImage *stretchableButtonImageNormal = [buttonImageNormal
                                                     stretchableImageWithLeftCapWidth:ExtrudeLeft topCapHeight:ExtrudeTop];
            
            [self setBackgroundImage:stretchableButtonImageNormal
                            forState:UIControlStateNormal];
            
        } else{
            
            [self setBackgroundImage:buttonImageNormal
                            forState:UIControlStateNormal];
        }
        
    
        if (HighlightedImage!=nil) { //触摸后的处理
            
               NSString *highlightedFilePath= [self backPath:sourceMode path:HighlightedImage];
               UIImage *buttonImageNormal=[UIImage imageWithContentsOfFile:highlightedFilePath];
            
               UIImage *stretchableButtonImageNormal = [buttonImageNormal
                                                     stretchableImageWithLeftCapWidth:ExtrudeLeft topCapHeight:ExtrudeTop];
              [self setBackgroundImage: stretchableButtonImageNormal forState:controlState];
            
        }
        
        //自适应
		if (frame.size.width == 0 ) {
			frame.size.width = buttonImageNormal.size.width;
		}
		if (frame.size.height == 0) {
			frame.size.height = buttonImageNormal.size.height;
		}
        
		self.frame = frame;

	}
    
	if(title!=nil)
	{
		self.titleLabel.font = [UIFont systemFontOfSize:12];
		[self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
	}
    
	return self;
}

 

-(id) initWithFrame:(CGRect)frame
               path:(NSString*)path
              title:(NSString*)title
         sourceMode:(FileMode) sourceMode
          isExtrude:(BOOL)isExtrude
        extrudeLeft:(float)extrudeLeft
         extrudeTop:(float)extrudeTop
           fontSize:(float)fontSize
{
    
    self = [super initWithFrame:frame];
    if(path!=nil)
    {
        
        [self setBackImg:path
               isExtrude:isExtrude
             extrudeLeft:extrudeLeft
              extrudeTop:extrudeTop
              sourceMode:sourceMode
            controlState:UIControlStateNormal
                   frame:frame
         
         
         ];
        
        
    }
    
    if(title!=nil)
    {
        
        float fontSizeRef=12;
        if (fontSize!=0) {
            
            fontSizeRef=fontSize;
        }
        self.titleLabel.font = [UIFont systemFontOfSize:fontSizeRef];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return self;
}




-(id) initWithFrame:(CGRect)frame
               path:(NSString*)path
              title:(NSString*)title
         sourceMode:(FileMode) sourceMode{
    
    self = [super initWithFrame:frame];
    if(path!=nil&&path.length>0)
    {
        
        UIImage *buttonImageNormal=[UIImage imageNamed:path];
        [self setBackgroundImage:buttonImageNormal  forState:UIControlStateNormal];
        
        //自适应
        if (frame.size.width == 0 ) {
            frame.size.width = buttonImageNormal.size.width;
        }
        if (frame.size.height == 0) {
            frame.size.height = buttonImageNormal.size.height;
        }
        
        self.frame = frame;
        
    }
    
    if(title!=nil)
    {
        self.titleLabel.font = [UIFont systemFontOfSize:12];
        [self setTitle:title forState:UIControlStateNormal];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }
    
    return self;
}


//设置触摸的按钮被选中，其他按钮为为不选中
//button:触摸按钮
//TabbarItemArr:按钮数组
-(void) SwitchBtnBack:(UIButton *)button TabbarItemArr:(NSMutableArray*)TabbarItemArr{
    
    for (UIButton *ItemBtn in TabbarItemArr) {
        
        if (ItemBtn==button) {
            
            ItemBtn.selected=YES;
            
        }else {
            ItemBtn.selected=NO;
        }
    }
    
}



-(void) setBackImg:(NSString*) imgPath
         isExtrude:(BOOL) isExtrude
       extrudeLeft:(float)extrudeLeft
        extrudeTop:(float) extrudeTop
        sourceMode:(FileMode) sourceMode
      controlState:(UIControlState) controlState
             frame:(CGRect)frame{
    
    
    
  
    UIImage *buttonImageNormal=[UIImage imageNamed:imgPath];
    
    if(!isExtrude){
        
        
        [self setBackgroundImage:buttonImageNormal
                        forState:controlState];
        
        
    } else{
        
        
        buttonImageNormal= [buttonImageNormal stretchableImageWithLeftCapWidth:extrudeLeft
                                                                  topCapHeight:extrudeTop];
        
        [self setBackgroundImage:buttonImageNormal
                        forState:controlState];
    }
    
    if (frame.size.width == 0 ) {
        frame.size.width = buttonImageNormal.size.width;
    }
    if (frame.size.height == 0) {
        frame.size.height = buttonImageNormal.size.height;
    }
    
    self.frame = frame;
}

-(NSString*) backPath:(FileMode) sourceMode  path:(NSString*)path{
    
    NSString *filepath=@"";
    if (sourceMode==FileModeProduct) {
        
        filepath = [[NSBundle mainBundle] pathForResource:path ofType:nil];
    }
    else{
        
        filepath = [GZCFileController DocumentPath:path];
    }
    
    return filepath;
}


@end


 