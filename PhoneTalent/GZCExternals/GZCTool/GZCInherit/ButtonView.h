
//
//  ButtonView.h
//  Genuine Parts
//
//  Created by 李 慧 on 12-3-19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ButtonView : UIButton{
    
 
}

 

//frame:宽度，高度为0，默认为图片的宽度高度
//path:背景图片路径 ，(如果不需要设置 直接改为nil)
//title:text(如果不设置为nil)
//isExtrude 是否拉伸,默认是不拉伸
//ExtrudeLeft=stretchableImageWithLeftCapWidth  
//ExtrudeTop=topCapHeight
//HighlightedImage：高亮图片，为nil表示没有
//controlState:控件的状态
//图片来源: 1.工程  2.沙盒
-(id) initWithFrameAndMoreProject:(CGRect)frame
                             path:(NSString*)path
                            title:(NSString*)title
                        isExtrude:(BOOL) isExtrude
                      ExtrudeLeft:(float)ExtrudeLeft
                       ExtrudeTop:(float) ExtrudeTop
                      HighlightedImage:(NSString*) HighlightedImage
                     controlState:(UIControlState) controlState
                       sourceMode:(FileMode) sourceMode;


-(id) initWithFrame:(CGRect)frame
               path:(NSString*)path
              title:(NSString*)title
         sourceMode:(FileMode) sourceMode;



-(id) initWithFrame:(CGRect)frame
               path:(NSString*)path
              title:(NSString*)title
         sourceMode:(FileMode) sourceMode
          isExtrude:(BOOL)isExtrude
        extrudeLeft:(float)extrudeLeft
         extrudeTop:(float)extrudeTop
           fontSize:(float)fontSize;


                    
//button:选中按钮，其他按钮为不选中
//TabbarItemArr:按钮数组
-(void) SwitchBtnBack:(UIButton *)button TabbarItemArr:(NSMutableArray*)TabbarItemArr;

 

@end
