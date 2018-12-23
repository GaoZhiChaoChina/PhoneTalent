//
//  CustomTabbarController.m
//  tarbar-选中状态-背景色
//
//  Created by ZMC on 15/12/6.
//  Copyright © 2015年 Zmc. All rights reserved.
//

#import "CustomTabbarController.h"
#import "CustomTabbar.h"
#import "CustomNavController.h"
#define  TABBAR_TITLE_FONT  15

@interface CustomTabbarController ()<UITabBarControllerDelegate,CustomTabbarDelegate>
{
    NSArray*_tabArray;
    CustomTabbar*_costomtab;
}
@end

@implementation CustomTabbarController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tabBar.hidden = YES;
    NSArray*VcArray=@[@"GZCHomeViewController",
                      @"GZCScanQRCodeSystemViewController",
                      @"GZCJZMerchantViewController",
                      @"ToolController",
                      @"GZCMineViewController"];
    
    NSArray*VCTitles=@[@"欢乐购",
                       @"扫一扫",
                       @"娱乐",
                       @"工具",
                       @"发现"];
    
    NSArray *image=@[@"tabbar_home_os7",
                    @"tabbar_discover_os7",
                    @"tabbar_message_center_os7",
                    @"tabbar_message_center_os7",
                    @"tabbar_profile_os7",];
    
    
    NSArray*selectImage=@[@"tabbar_home_selected_os7",
                          @"tabbar_discover_selected_os7",
                          @"tabbar_message_center_selected_os7",
                          @"tabbar_message_center_selected_os7",
                          @"tabbar_profile_selected_os7",];
    
    
    CustomTabbar*customtabbar=[[CustomTabbar alloc]initWithTitles:VCTitles images:image selectedImages:selectImage tabBarStyle:CustomTabbarStyleNormal norTextColor:[UIColor grayColor] selectedTextColor:[UIColor orangeColor] bgColor:[UIColor whiteColor] selectedColor:[UIColor cyanColor]];
    customtabbar.tabbarDelegate=self;
    customtabbar.tabBarFont=[UIFont systemFontOfSize:TABBAR_TITLE_FONT];
    [self.view addSubview:customtabbar];
    
    NSMutableArray*tabArray=[NSMutableArray array];
    for (int i=0; i<VcArray.count;i++) {
        Class cls=NSClassFromString(VcArray[i]);
        UIViewController*vc=[[cls alloc]init];
        CustomNavController*nav=[[CustomNavController alloc]initWithRootViewController:vc];
        [tabArray addObject:nav];
        _tabArray=tabArray;
    }
    self.viewControllers=tabArray;
    _costomtab=customtabbar;
}

//点击按钮显示
- (void) clickThisBtnAtIndex:(NSInteger)index{
    self.selectedIndex=index;
}
- (void)showTabbar{
    _costomtab.hidden=NO;
}
- (void)hiddenTabbar{
    _costomtab.hidden=YES;
}
@end
