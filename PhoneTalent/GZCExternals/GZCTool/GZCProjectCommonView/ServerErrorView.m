//
//  ServerErrorView.m
//  Mic
//
//  Created by chaossy on 14-12-3.
//  Copyright (c) 2014年 chaossy. All rights reserved.
//

#import "ServerErrorView.h"

//@interface ServerErrorView()
//@property(nonatomic, weak) id<ServerErrorViewDelegate> delegate;
//@end

@implementation ServerErrorView{
    
    __weak IBOutlet UIButton *iphoneText;
}

+ (void)show
{
    UIWindow* window = [[[UIApplication sharedApplication] delegate] window];
    UIView* view = [window viewWithTag:kWindowServerErrorViewTag];
    if (view == nil) {
        view = [[[NSBundle mainBundle] loadNibNamed:@"ServerErrorView" owner:nil options:nil] objectAtIndex:0];
        view.tag = kWindowServerErrorViewTag;
        view.frame = window.frame;
        [window addSubview:view];
    }
}
-(void)awakeFromNib{
    [super awakeFromNib];
    NSString *servicePhoneNmuber=[[NSUserDefaults standardUserDefaults]objectForKey:@"servicePhoneNmuber"];

    [iphoneText setTitle:[NSString stringWithFormat:@"客服热线 %@",servicePhoneNmuber] forState:0];
}
- (IBAction)phoneButtonDidClick:(id)sender
{
    NSString *servicePhoneNmuber=[[NSUserDefaults standardUserDefaults]objectForKey:@"servicePhoneNmuber"];

    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",servicePhoneNmuber]]];
}

- (IBAction)cancelButtonDidClick:(id)sender
{
    [self removeFromSuperview];
}

@end
