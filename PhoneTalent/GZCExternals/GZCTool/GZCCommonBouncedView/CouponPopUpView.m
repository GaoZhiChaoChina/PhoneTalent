//
//  CouponPopUpView.m
//  Mic
//
//  Created by gaozhichao on 30/12/15.
//  Copyright © 2015年 chaossy. All rights reserved.
//

#import "CouponPopUpView.h"

static const NSInteger KbackButtonHeigth = 44;
static const NSInteger KCellHeigth = 50;

@implementation CouponPopUpView{
    NSArray *_couponModeArray;
    __block OrderActivity *orderActivity;
    UIButton *_buttonBg;
}

@synthesize closing;

- (void)showInView:(UIView*)view{
    
    if (!_buttonBg) {
        _buttonBg =[UIButton buttonWithType:UIButtonTypeCustom];
    }
    _buttonBg.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    _buttonBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
    [view addSubview:_buttonBg];
    
    self.frame = CGRectMake((view.frame.size.width - self.frame.size.width) / 2, view.frame.size.height, ScreenWidth, ScreenHeight);
    [view addSubview:self];
    
    [UIView animateWithDuration:0.4 animations:^{
        ViewSetY(self, view.frame.size.height - self.frame.size.height);
        _buttonBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0.7];
    }];
}

- (instancetype)initWithFrame:(CGRect)frame payModeArray:(NSArray *)arry optionName:(NSString *)optiontitle{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _couponModeArray=arry;
       
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, ScreenHeight - 250- KbackButtonHeigth, ScreenWidth, 250)];
        view.backgroundColor=[UIColor whiteColor];
        [self addSubview:view];
        
        /**
         title
         */
        UILabel  *labelText=[[UILabel alloc]initWithFrame:CGRectMake(0,0, 130, 45)];
        labelText.font=[UIFont boldSystemFontOfSize:ScreenWidth == 320 ? 14 : 16];
        labelText.textColor = [UIColor colorWithHexString:@"060606"];
        labelText.center = CGPointMake(ScreenWidth/2, 25);
        labelText.textAlignment = NSTextAlignmentCenter;
        labelText.backgroundColor=[UIColor whiteColor];
        
        labelText.text=@"选择优惠券";
        if (optiontitle.length>0) { labelText.text= optiontitle; }
        
        [view addSubview:labelText];
        
        /**
         分割线
         */
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(0, 45, ScreenWidth, 1)];
        image.backgroundColor=[UIColor colorWithHexString:@"e0e0e0"];
        [view addSubview:image];
        
        /**
         tableView
         */
        UITableView  *table=[[UITableView alloc]initWithFrame:CGRectMake(0,46, ScreenWidth, 205)];
        table.delegate=self;
        table.dataSource=self;
        table.separatorStyle=1;
        [view addSubview:table];
        table.backgroundView=nil;

        if ([table respondsToSelector:@selector(setSeparatorInset:)])
        {
            [table setSeparatorInset:UIEdgeInsetsMake(0, 0, 0, 10)];
        }
        if ([table respondsToSelector:@selector(setLayoutMargins:)])
        {
            [table setLayoutMargins:UIEdgeInsetsMake(0, 0, 0, 10)];
        }
        table.tableFooterView = [[UIView alloc]init];
        
        /**
         *  关闭按钮
         */
        UIButton *backButton=[UIButton buttonWithType:UIButtonTypeCustom];
        backButton.frame=CGRectMake(0, ScreenHeight - KbackButtonHeigth, ScreenWidth, KbackButtonHeigth);
        [backButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:backButton];
        backButton.backgroundColor = [UIColor colorWithHexString:@"F14659"];
        [backButton setTitle:@"关闭" forState:0];
        
    }
    
    return self;
}

#pragma mark - UITableViewdelegate begin
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return KCellHeigth;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _couponModeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView  cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *identify=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:identify];
        OrderActivity *orderActivity1 =_couponModeArray[indexPath.row];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(ScreenWidth - 40, 10, 30, 30);
        
         NSString *couponId = [[NSUserDefaults standardUserDefaults] objectForKey:@"KCouponPopUpView"];
        
        if ([orderActivity1.couponId isEqualToString:couponId]) {
            [btn setImage:[UIImage imageNamed:@"cart_ticket_selected.png"] forState:UIControlStateNormal];

        }else{
            [btn setImage:[UIImage imageNamed:@"cart_ticket_unselected.png"] forState:UIControlStateNormal];
 
        }
      
        [btn addTarget:self action:@selector(DidClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=indexPath.row+100;
        [cell.contentView addSubview:btn];

        UILabel  *labelText=[[UILabel alloc]initWithFrame:CGRectMake(10, 0, ScreenWidth - 40 - 10, KCellHeigth)];
        labelText.backgroundColor=[UIColor clearColor];
        labelText.font=[UIFont boldSystemFontOfSize:ScreenWidth == 320 ? 14 : 16];
        labelText.text=orderActivity1.couponName;
        labelText.textColor=[UIColor colorWithWhite:0.208 alpha:1.000];
        [cell.contentView addSubview:labelText];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
  
    for (int i=100; i< 100 + _couponModeArray.count ;i++) {
        UIButton *btn=(UIButton*)[self viewWithTag:i];
        btn.selected=YES;
        [btn setImage:[UIImage imageNamed:@"cart_ticket_unselected.png"] forState:UIControlStateNormal];
      
    }
    
    orderActivity=_couponModeArray[indexPath.row];
    self.closing(orderActivity,indexPath.row);

    UIButton *sender=(UIButton*)[self viewWithTag:indexPath.row+100];
    [sender setImage:[UIImage imageNamed:@"cart_ticket_selected.png"] forState:UIControlStateNormal];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
//    [self close];

}
#pragma mark - UITableViewDelegate end


- (void)DidClick:(UIButton*)sender{
    
    for (int i=100; i<100 + _couponModeArray.count;i++) {
        UIButton *btn=(UIButton*)[self viewWithTag:i];
        btn.selected=YES;
        [btn setImage:[UIImage imageNamed:@"cart_ticket_unselected.png"] forState:UIControlStateNormal];
    }
    
    orderActivity=_couponModeArray[sender.tag-100];
    self.closing(orderActivity,sender.tag-100);
    
    [sender setImage:[UIImage imageNamed:@"cart_ticket_selected.png"] forState:UIControlStateNormal];
//    [self close];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self close];
}

- (void)close{
    
    [UIView animateWithDuration:0.4 animations:^{
        ViewSetY(self, self.superview.frame.size.height);
        _buttonBg.backgroundColor = [UIColor colorWithWhite:0 alpha:0];
        _buttonBg.alpha = 0;
    
    } completion:^(BOOL finished) {
        [_buttonBg removeFromSuperview];
        [self removeFromSuperview];
    
    }];
}


@end
