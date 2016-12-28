//
//  GZCPuzzleGameViewController.h
//  PhoneTalent
//
//  Created by cloud on 15/12/14.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCBaseViewController.h"

@interface GZCPuzzleGameViewController : GZCBaseViewController<imagedelegate>

@property (nonatomic, strong) UIImageView *tempimage;
@property (nonatomic, strong) ImageView *imgView;;
@property (nonatomic, assign) int numberX;
@property (nonatomic, assign) int numberY;

@end
