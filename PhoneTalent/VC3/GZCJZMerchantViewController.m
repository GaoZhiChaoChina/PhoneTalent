//
//  GZCJZMerchantViewController.m
//  PhoneTalent
//
//  Created by cloud on 15/12/4.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCJZMerchantViewController.h"
#import "GZCPuzzleGameViewController.h"
@implementation GZCJZMerchantViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
    self.view.backgroundColor = [UIColor whiteColor];   
    [self addLeafNavigationButton:@""];

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(sendPuzzleGameViewController) forControlEvents:UIControlEventTouchUpInside];
    btn.frame = CGRectMake(20, 100, 100, 50);
    [btn setTitle:@"拼图游戏" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self.view addSubview:btn];
    
    
    
//    [self sendPuzzleGameViewController];
    
}

-(void)sendPuzzleGameViewController{
    GZCPuzzleGameViewController *puzzleGame = [[GZCPuzzleGameViewController alloc]init];
    puzzleGame.numberX = 3;
    puzzleGame.numberY = 3;
    [self.navigationController pushViewController:puzzleGame animated:YES];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
