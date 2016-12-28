//
//  LeafScrollView.m
//  funny
//
//  Created by gaozhichao on 15/11/20.
//  Copyright © 2015年 xiexin. All rights reserved.
//

#import "LeafScrollView.h"

#define Screen_width [UIScreen mainScreen].bounds.size.width
#define Screen_Higth [UIScreen mainScreen].bounds.size.height
#define RATE 2
#define SWITCH_Y -TOP_FLAG_HIDE
#define ORIGINAL_POINT CGPointMake(self.bounds.size.width/2, -20)
@implementation LeafScrollView

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization cod
     
        self.frame = CGRectMake(0, 0, Screen_width, Screen_Higth);
        //刷新标志
        _refreshImgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
        self.refreshImgView.center = ORIGINAL_POINT;
        self.refreshImgView.image = [UIImage imageNamed:@"upload"];
        [self addSubview:self.refreshImgView];
        
        if(!_isLoading){
            
            [self startRotate];
            self.refreshImgView.center = CGPointMake(self.refreshImgView.center.x,self.bounds.size.height/3.0f);
        }
    }
    return self;
}

-(void)setRefreshImage:(UIImage *)image{
    self.refreshImgView.image = image;
}     

-(void)startRotate{
    _isLoading = YES;
    stopRotating = NO;
    angle = 0;
    [self rotateRefreshImage];
}
-(void)endUpdating{
    stopRotating = YES;
}
-(void)rotateRefreshImage{
    CGAffineTransform endAngle = CGAffineTransformMakeRotation(angle * (M_PI / 180.0f));
    
    [UIView animateWithDuration:0.01 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.refreshImgView.transform = endAngle;
    } completion:^(BOOL finished) {
        angle += 10;
        if(!stopRotating){
            self.refreshImgView.hidden = NO;
            self.hidden = NO;
            [self rotateRefreshImage];
        }else{
            //上升隐藏
            [UIView animateWithDuration:0.2 animations:^{
                self.refreshImgView.hidden = YES;
                self.hidden = YES;
            } completion:^(BOOL finished) {
                _isLoading = NO;
            }];
        }
    }];
}

@end
