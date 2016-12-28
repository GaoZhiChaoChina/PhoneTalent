//
//  ImageView.h
//  Genuine Parts
//
//  Created by 谢鑫 on 12-3-5.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol imagedelegate <NSObject>
@optional
-(void)movedeciton:(UIImageView *)imageview;
@end


@interface ImageView : UIImageView

@property (nonatomic,retain) id<imagedelegate> delegate;

//自适应大小图片(工程) 
- (id)initWithFrame:(CGRect)frame
           ImageUrl:(NSString*)imgurl
         IsAutoSize:(BOOL) IsAutoSize;

//自适应大小图片(沙盒)
- (id)initWithFrame:(CGRect)frame
   ImageDocumentUrl:(NSString*)ImageDocumentUrl
         IsAutoSize:(BOOL) IsAutoSize;

//重新设置新图片
-(void) setCustomImage:(NSString*)imgurl;

//重新设置图片
-(void) setCustomImageDocument:(NSString*)imgurl;


@end



