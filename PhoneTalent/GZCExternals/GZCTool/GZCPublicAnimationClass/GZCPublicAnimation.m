//
//  GZCPublicAnimation.m
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCPublicAnimation.h"

@implementation GZCPublicAnimation

IMPLEMENT_SINGLETON(GZCPublicAnimation);

-(void) showAnimation:(UIView*) showView{
    
    showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.4, 0.4);
    [UIView animateWithDuration:0.2 animations:^{
        
        showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1.1, 1.1);
        
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
            
            showView.transform = CGAffineTransformScale(CGAffineTransformIdentity, 1, 1);
            
        } completion:^(BOOL finished2) {
            
            showView.hidden=false;
            
        }];
    }];
}
@end
