//
//  GZCPublicAnimation.h
//  PhoneTalent
//
//  Created by cloud on 15/12/5.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GZCPublicAnimation : NSObject

DECLARE_SINGLETON(GZCPublicAnimation);

-(void) showAnimation:(UIView*) showView;

@end
