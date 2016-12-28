//
//  PayListDialogView.m
//  Mic
//
//  Created by songbai on 15/4/20.
//  Copyright (c) 2015年 chaossy. All rights reserved.
//

#import "PayListDialogView.h"

@implementation PayListDialogView{
    NSArray *payModeArray;
    __block PayMode *payMode;
}
@synthesize closing;
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */
- (instancetype)initWithFrame:(CGRect)frame payModeArray:(NSArray *)arry{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        payModeArray=arry;
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
        [btn addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:btn];
        btn.backgroundColor=[UIColor blackColor];
        btn.alpha=0.3;
        UIView *view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth-40, 250)];
        ViewSetSize(view, CGSizeMake(ScreenWidth-40, 220));
        view.center=self.center;
        
        view.backgroundColor=[UIColor whiteColor];
        view.layer.cornerRadius=10;
        [self addSubview:view];
        
        UIButton *btnClose=[UIButton buttonWithType:UIButtonTypeCustom];
        btnClose.frame=CGRectMake(view.width-40-10, 15-10, 42, 42);
        [btnClose setImage:[UIImage imageNamed:@"det_rev_no.png"] forState:UIControlStateNormal];
        [btnClose addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:btnClose];
        
        
        UILabel  *labelText=[[UILabel alloc]initWithFrame:CGRectMake((view.width-130)/2,15, 130, 20)];
        labelText.backgroundColor=[UIColor clearColor];
        labelText.font=[UIFont boldSystemFontOfSize:16];
        labelText.text=@"请选择支付方式";
        labelText.textColor=[UIColor colorWithRed:0.937 green:0.282 blue:0.353 alpha:1.000];
        [view addSubview:labelText];
        
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(20, 50, view.width-40, 1)];
        image.backgroundColor=[UIColor colorWithRed:0.858 green:0.853 blue:0.873 alpha:1.000];
        [view addSubview:image];
        
        
        UITableView  *table=[[UITableView alloc]initWithFrame:CGRectMake(10,60, view.width-20, 150)];
        table.delegate=self;
        table.dataSource=self;
        table.backgroundView=nil;
        table.separatorStyle=0;
        //        table.backgroundColor = [UIColor clearColor];
        //        table.layer.borderWidth=0.5;
        //        table.layer.cornerRadius=10;
        //        table.layer.borderColor=[UIColor colorWithWhite:0.918 alpha:1.000].CGColor;
        [view addSubview:table];
        
    }
    
    return self;
}
#pragma mark - UITableViewDataSource
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return payModeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *identify=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identify];
    
    if (cell==nil) {
        
        cell=[[UITableViewCell alloc]initWithStyle:0 reuseIdentifier:identify];
        PayMode *Mode=payModeArray[indexPath.row];
        
        UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame=CGRectMake(15, 18, 28, 28);
        
        int payId = [[[NSUserDefaults standardUserDefaults] objectForKey:@"kSelectPayIdDetailView"] intValue];
        
        if (payId==Mode.payId) {
            
            [btn setImage:[UIImage imageNamed:@"del_select_press.png"] forState:UIControlStateNormal];
            
            
        }else{
            //payid 为0的时候，设置列表第一个为默认支付方式
            
            if (payId==0) {
                
                if (indexPath.row==0) {
                    
                    [btn setImage:[UIImage imageNamed:@"del_select_press.png"] forState:UIControlStateNormal];
                    
                }else{
                    
                    [btn setImage:[UIImage imageNamed:@"del_select"] forState:UIControlStateNormal];
                }
                
            }else{
                
                [btn setImage:[UIImage imageNamed:@"del_select"] forState:UIControlStateNormal];
            }
        }
        
        
        
        
        [btn addTarget:self action:@selector(DidClick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=indexPath.row+100;
        btn.selected=YES;
        [cell.contentView addSubview:btn];
        
        
        UIImageView *image=[[UIImageView alloc]initWithFrame:CGRectMake(50, 7, 45, 45)];
        image.backgroundColor=[UIColor clearColor];
        [cell.contentView addSubview:image];
        
        
        UILabel  *labelText=[[UILabel alloc]initWithFrame:CGRectMake(110, 7, 156, 22)];
        labelText.backgroundColor=[UIColor clearColor];
        labelText.font=[UIFont boldSystemFontOfSize:16];
        labelText.text=Mode.payName;
        labelText.textColor=[UIColor colorWithWhite:0.208 alpha:1.000];
        [cell.contentView addSubview:labelText];
        
        UILabel  *labelSize=[[UILabel alloc]initWithFrame:CGRectMake(110, 7+22, 156, 22)];
        labelSize.backgroundColor=[UIColor clearColor];
        labelSize.font=[UIFont boldSystemFontOfSize:10];
        labelSize.text=Mode.payName;
        labelSize.textColor=[UIColor colorWithRed:0.680 green:0.719 blue:0.722 alpha:1.000];
        [cell.contentView addSubview:labelSize];
        
        
        if (Mode.payId==1) {
            
            image.image=[UIImage imageNamed:@"zhifubao"];
            labelSize.text=@"推荐安装支付宝的用户使用";
            
        }else if (Mode.payId==2){
            
            image.image=[UIImage imageNamed:@"zhifubao"];
            labelSize.text=@"推荐支付宝网页用户使用";
            
        }else{
            
            image.image=[UIImage imageNamed:@"det_share_wx"];
            labelSize.text=@"推荐安装微信的用户使用";
            
        }
        
    }
    return cell;
}



#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    for (int i=100; i<105;i++) {
        UIButton *btn=(UIButton*)[self viewWithTag:i];
        btn.selected=YES;
        [btn setImage:[UIImage imageNamed:@"del_select.png"] forState:UIControlStateNormal];
    }
    payMode=payModeArray[indexPath.row];
    self.closing(payMode);
    
    [[NSUserDefaults standardUserDefaults] setObject:@(payMode.payId) forKey:@"kSelectPayIdDetailView"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    UIButton *sender=(UIButton*)[self viewWithTag:indexPath.row+100];
    [sender setImage:[UIImage imageNamed:@"del_select_press.png"] forState:UIControlStateNormal];
    [self close];
}


-(void)DidClick:(UIButton*)sender{
    
    for (int i=100; i<105;i++) {
        UIButton *btn=(UIButton*)[self viewWithTag:i];
        btn.selected=YES;
        [btn setImage:[UIImage imageNamed:@"del_select.png"] forState:UIControlStateNormal];
    }
    payMode=payModeArray[sender.tag-100];
    self.closing(payMode);
    
    [[NSUserDefaults standardUserDefaults] setObject:@(payMode.payId) forKey:@"kSelectPayIdDetailView"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    
    if (sender.selected) {
        [sender setImage:[UIImage imageNamed:@"del_select_press.png"] forState:UIControlStateNormal];
        
    }else{
        [sender setImage:[UIImage imageNamed:@"del_select.png"] forState:UIControlStateNormal];
    }
    sender.selected=!sender.selected;
    [self close];
}
-(void)close{
    [self removeFromSuperview];
}




@end