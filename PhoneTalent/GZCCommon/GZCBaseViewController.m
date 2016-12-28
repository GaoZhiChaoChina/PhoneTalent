//
//  GZCBaseViewController.m
//  PhoneTalent
//
//  Created by cloud on 15/12/10.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "GZCBaseViewController.h"
#define  NAVGATION_TITLE_FONT  22

@interface GZCBaseViewController()
@property (nonatomic,strong)UIImageView *navigationView;
@property (nonatomic,strong)UIImageView *redPointImage;
@property (nonatomic,strong)UIButton *downButton;
@property (nonatomic,strong)UILabel *titleLabel;

@end


@implementation GZCBaseViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
//    self.navigationController.navigationBarHidden = YES;
//    self.view.backgroundColor = [UIColor colorWithRed:246/255.0 green:246/255.0 blue:246/255.0 alpha:1.0];
    [self addLeafNavigationButton:@"title_back"];

}

- (void)addBackNavigationButton{
    
    UIButton *l_backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [l_backBtn setBackgroundColor:[UIColor clearColor]];
    [l_backBtn setBackgroundImage:[UIImage imageNamed:@"title_back.png"] forState:UIControlStateNormal];
    [l_backBtn addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
  
    UIBarButtonItem *bar_Btn = [[UIBarButtonItem alloc]  initWithCustomView:l_backBtn];
    self.navigationItem.leftBarButtonItem = bar_Btn;
    
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -16;
    self.navigationItem.leftBarButtonItems=@[spaceItem,self.navigationItem.leftBarButtonItem];
  
}
-(void) goBack{
    
    [self.navigationController popViewControllerAnimated:true];
}

-(void) initHUD
{
    if (HUD == nil ) {
        /*
         UIWindow *defaultWindow = [HKGlobal defaultWindow];
         HUD = [[MBProgressHUD alloc]initWithView:defaultWindow];
         [defaultWindow addSubview:HUD];
         HUD.delegate = self;
         */
        HUD = [[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:HUD];
        HUD.delegate = self;
    }
    
}
-(void)HUDShow:(NSString*)text
{
    
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeIndeterminate;
    [HUD show:YES];
}
-(void)HUDShow:(NSString*)text delay:(float)second
{
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    [HUD show:YES];
    [HUD hide:YES afterDelay:second];
}

-(void)HUDShow:(NSString*)text delay:(float)second dothing:(BOOL)bDo
{
    [self initHUD];
    HUD.labelText = text;
    HUD.mode = MBProgressHUDModeText;
    [HUD show:YES];
    [HUD hide:YES afterDelay:second dothing:bDo];
}
-(void)HUDdelayDo
{
    
}

- (void)hudWasHidden:(MBProgressHUD *)hud{
    
    [HUD removeFromSuperview];
    HUD = nil;
}

- (void)addLeafNavigationButton:(NSString*) imageName {
    
    NSString *tempImageName=@"title_back";
    //NSString *tempImageName_press=@"title_back_press";
    if (![NSString  gzc_isEmpty:imageName]) {
        
        tempImageName=imageName;
    }
    
    
    UIImage *img=[UIImage imageNamed:tempImageName];
    
    UIButton *l_backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, img.size.width, img.size.height)];
    [l_backBtn setBackgroundColor:[UIColor clearColor]];
    [l_backBtn setBackgroundImage:img forState:UIControlStateNormal];
    
    [l_backBtn addTarget:self action:@selector(navBarLeafBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar_Btn = [[UIBarButtonItem alloc]  initWithCustomView:l_backBtn];
    self.navigationItem.leftBarButtonItem = bar_Btn;
    
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width = -16;
    self.navigationItem.leftBarButtonItems=@[spaceItem,self.navigationItem.leftBarButtonItem];
    
    
}
//修改了导航按钮的右边按钮
- (void)addRightNavigationButton:(NSString*) imageName pressImage:(NSString *)pressImage{
    
    NSString *tempImageName=@"sug_confirm";
    NSString *tempImageName_press=@"sug_confirm_press";
    if (![NSString  gzc_isEmpty:imageName]) {
        
        tempImageName=imageName;
        tempImageName_press=pressImage;
    }
    
    UIImage *img=[UIImage imageNamed:tempImageName];
    
    UIButton *l_backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0,img.size.width, img.size.height)];
    [l_backBtn setBackgroundColor:[UIColor clearColor]];
    [l_backBtn setBackgroundImage:img
                         forState:UIControlStateNormal];
    [l_backBtn setBackgroundImage:[UIImage imageNamed:tempImageName_press] forState:UIControlStateHighlighted];
    [l_backBtn setBackgroundImage:[UIImage imageNamed:tempImageName_press] forState:UIControlStateSelected];
    
    [l_backBtn addTarget:self action:@selector(navBarRightBtnClick)
        forControlEvents:UIControlEventTouchUpInside];
    
    
    UIBarButtonItem *bar_Btn = [[UIBarButtonItem alloc]  initWithCustomView:l_backBtn];
    self.navigationItem.rightBarButtonItem = bar_Btn;
    
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width =-16;
    self.navigationItem.rightBarButtonItems=@[spaceItem,self.navigationItem.rightBarButtonItem];
}
//导航栏右边按钮文字
-(void)addRightNavigationButtonTitle:(NSString*) butName pressImage:(NSString *)pressBtnName{
    
    NSString *tmpButName=@"编辑";
    NSString *pressBtnName_press=@"完成";
    
    if (![NSString  gzc_isEmpty:butName]) {
        
        tmpButName=butName;
        pressBtnName_press=pressBtnName;
    }
    
    UIButton *l_backBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 44, 44)];
    [l_backBtn setBackgroundColor:[UIColor clearColor]];
    [l_backBtn setTitle:tmpButName forState:UIControlStateNormal];
    [l_backBtn setTitle:pressBtnName_press forState:UIControlStateSelected];
    [l_backBtn.titleLabel setFont:[UIFont fontWithName:@"DFPWaWaW5-GB" size:17]];
    
    [l_backBtn addTarget:self
                  action:@selector(navBarRightBtnClick)
        forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *bar_Btn = [[UIBarButtonItem alloc]  initWithCustomView:l_backBtn];
    self.navigationItem.rightBarButtonItem = bar_Btn;
    
    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    spaceItem.width =-10;
    
    self.navigationItem.rightBarButtonItems=@[spaceItem,self.navigationItem.rightBarButtonItem];
}

- (void)titleLabel:(NSString *)labelText{
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(6  , 6, 116, 21)];
    lab.text = labelText;
    lab.textAlignment = NSTextAlignmentCenter;
    lab.font = [UIFont fontWithName:@"TrebuchetMS-Bold" size:18];
    lab.backgroundColor = [UIColor clearColor];
    lab.textColor = [UIColor whiteColor];
    
    self.navigationItem.titleView = lab;
}

/**
 *  navi导航按钮点击事件 集成的类中重写就行
 */
-(void) navBarLeafBtnClick
{
    [self.navigationController popViewControllerAnimated:true];
}

-(void) navBarRightBtnClick
{
    
}
/**
 *  nav导航标题方法设置
 *
 *  @param title 标题
 */
-(void)addNavTitle:(NSString *)title
{
    //colorWithHexString:@"ef485a"
    self.navigationController.navigationBar.translucent=NO;
    self.navigationItem.title=title;
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:@"DFPWaWaW5-GB" size:NAVGATION_TITLE_FONT],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    
}

/**
 *  评论为空时候显示页面
 */
-(void)createLoadEmptyView:(NSString *)imgName andText:(NSString *)text
{
    UIView *loadingEmptyView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    loadingEmptyView.backgroundColor=[UIColor colorWithHexString:@"f5f3f3"];
    
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake((ScreenWidth-135)/2, 85, 135,90)];
    [img setImage:[UIImage imageNamed:imgName]];
    [loadingEmptyView addSubview:img];
    
    UILabel *l=[[UILabel alloc] initWithFrame:CGRectMake((ScreenWidth-200)/2, img.frame.origin.y+img.frame.size.height+25, 200, 50)];
    l.text=text;
    l.numberOfLines=0;
    l.textAlignment=NSTextAlignmentCenter;
    l.textColor=[UIColor colorWithHexString:@"bfbfbf"];
    l.font=[UIFont fontWithName:@"DFPWaWaW5-GB" size:22];
    [loadingEmptyView addSubview:l];
    
    [self.view addSubview:loadingEmptyView];
    
}

/**
 *  自定义push方法
 *
 *  @param controllerName  controllerName
 *  @param _isNib          是否有nib,nib名称跟controllerName一致
 */
- (void)pushNewViewController:(NSString *)controllerName isNibPage:(BOOL) _isNib {
    
    if (controllerName.length <= 0)
        return;
    
    Class   class_Page = NSClassFromString((NSString *)controllerName);
    
    id viewCtrl_Page = _isNib ? [[class_Page alloc]
                                 initWithNibName:controllerName
                                 bundle:nil]
    : [[class_Page alloc] init];
    
    if (_parameter) {
        
        [viewCtrl_Page setParameter:_parameter];
    }
    
    [self.navigationController pushViewController:viewCtrl_Page animated:YES];
}
- (void)pushNewViewController:(NSString *)controllerName
                    isNibPage:(BOOL) _isNib
               addViewControl:(UIViewController*)addViewControl{
    
    if (controllerName.length <= 0)
        return;
    
    Class   class_Page = NSClassFromString((NSString *)controllerName);
    
    id viewCtrl_Page = _isNib ? [[class_Page alloc]
                                 initWithNibName:controllerName
                                 bundle:nil]
    : [[class_Page alloc] init];
    
    if (_parameter) {
        
        [viewCtrl_Page setParameter:_parameter];
    }
    
    [addViewControl.navigationController pushViewController:viewCtrl_Page animated:YES];
}




-(UIImageView *)navigationView{
    if (!_navigationView) {
        _navigationView=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 64.0)];
        _navigationView.backgroundColor=[UIColor grayColor];
        _navigationView.userInteractionEnabled = YES;
        [self.view addSubview:_navigationView];
    }
    return _navigationView;
}
-(UIButton *)downButton{
    if (!_downButton) {
        self.downButton=[UIButton buttonWithType:UIButtonTypeCustom];
        _downButton.frame = CGRectMake(self.view.frame.size.width-70.0, 28,25, 25);
        [_downButton setImage:[UIImage imageNamed:@"HomePage_Button_HuanCun"] forState:UIControlStateNormal];
        [_downButton addTarget:self action:@selector(downBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _downButton.hidden = YES;
        [self.navigationView addSubview:_downButton];
    }
    return _downButton;
}
-(UILabel *)titleLabel{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.frame.size.width/2.0-90.0, 27, 180, 30)];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.navigationView addSubview:_titleLabel];
    }
    return _titleLabel;
}
- (void)setupBackgroundImage:(UIImage *)backgroundImage {
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    backgroundImageView.image = backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
}

- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}

-  (void)customNavigationTitle:(NSString *)aString withFont:(CGFloat)aSize andTitleColor:(UIColor *)titleColor{
    self.titleLabel.text = aString;
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.textColor = titleColor;
    self.titleLabel.font = [UIFont fontWithName:@ "Arial Rounded MT Bold"  size:(aSize)];
}

//自定义导航栏左边按钮为头像,并设置头像消息提醒红点是否隐藏
- (void)customNavigationHeaderImage:(UIImage *)headerImage orHideMessageImage:(BOOL)hidden{
    if (_leftButton) {
        [_leftButton removeFromSuperview];
    }
    if (_redPointImage) {
        [_redPointImage removeFromSuperview];
    }
    _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame=CGRectMake(10.0, 27.0, 30.0, 30.0);
    _leftButton.layer.cornerRadius = 15.0;
    _leftButton.clipsToBounds = YES;
    [_leftButton setImage:headerImage forState:UIControlStateNormal];
    [self.navigationView addSubview:_leftButton];
    
    _redPointImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 25, 8, 8)];
    _redPointImage.backgroundColor = [UIColor redColor];
    _redPointImage.layer.cornerRadius = 4.0;
    _redPointImage.clipsToBounds = YES;
    [self.navigationView addSubview:_redPointImage];
    _redPointImage.hidden = hidden;
    [_leftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}


//自定义导航栏左边用户头像消息提醒红点是否隐藏
- (void)orHideMessageImage:(BOOL)hidden{
    if (_redPointImage) {
        [_redPointImage removeFromSuperview];
    }
    _redPointImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 25, 8, 8)];
    _redPointImage.backgroundColor = [UIColor redColor];
    _redPointImage.layer.cornerRadius = 4.0;
    _redPointImage.clipsToBounds = YES;
    [self.navigationView addSubview:_redPointImage];
    [self.navigationView bringSubviewToFront:_redPointImage];
    _redPointImage.hidden = hidden;
}





//自定义导航栏左边按钮为头像,并设置头像消息提醒红点是否隐藏
- (void)customNavigationHeaderImageURL:(NSURL *)headerImageURL orHideMessageImage:(BOOL)hidden{
    if (_leftButton) {
        [_leftButton removeFromSuperview];
    }
    if (_redPointImage) {
        [_redPointImage removeFromSuperview];
    }
    _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    _leftButton.frame=CGRectMake(10.0, 27.0, 30.0, 30.0);
    _leftButton.layer.cornerRadius = 15.0;
    _leftButton.clipsToBounds = YES;
    //    [_leftButton sd_setBackgroundImageWithURL:headerImageURL forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"HomePage_Button_WoDe"]];
    
    [self.navigationView addSubview:_leftButton];
    
    _redPointImage = [[UIImageView alloc] initWithFrame:CGRectMake(35, 25, 8, 8)];
    _redPointImage.backgroundColor = [UIColor redColor];
    _redPointImage.layer.cornerRadius = 4.0;
    _redPointImage.clipsToBounds = YES;
    [self.navigationView addSubview:_redPointImage];
    _redPointImage.hidden = hidden;
    [_leftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//自定义导航栏左边按钮图片以及标题
-  (void)customNavigationLeftTitle:(NSString *)aString withImage:(UIImage *)aImage buttonStryle:(NavigationStyle)aBtnStyle andtitleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont{
    if (_leftButton) {
        [_leftButton removeFromSuperview];
    }
    _leftButton=[UIButton buttonWithType:UIButtonTypeCustom];
    if (aBtnStyle==ONLYIMAGE) {
        _leftButton.frame=CGRectMake(10.0, 27.0, 30.0, 30.0);
        [_leftButton setImage:aImage forState:UIControlStateNormal];
    }else{
        _leftButton.frame=CGRectMake(10.0, 30.0, 60.0, 30.0);
        [_leftButton setTitle:aString forState:UIControlStateNormal];
        [_leftButton setTitleColor:titleColor forState:UIControlStateNormal];
    }
    _leftButton.titleLabel.font=[UIFont systemFontOfSize:titleFont];
    [self.navigationView addSubview:_leftButton];
    [_leftButton addTarget:self action:@selector(leftBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//自定义导航栏右边按钮图片以及标题
-  (void)customNavigationRightTitle:(NSString *)aString withImage:(UIImage *)aImage buttonStryle:(NavigationStyle)aBtnStyle andtitleColor:(UIColor *)titleColor titleFont:(CGFloat)titleFont{
    if (_rightButton) {
        [_rightButton removeFromSuperview];
    }
    _rightButton=[UIButton buttonWithType:UIButtonTypeCustom];
    if (aBtnStyle==ONLYIMAGE) {
        _rightButton.frame=CGRectMake(self.view.frame.size.width - 30, 30, 25, 25);
        [_rightButton setImage:aImage forState:UIControlStateNormal];
    }else{
        _rightButton.frame=CGRectMake(self.view.frame.size.width-70.0, 30, 60, 30);
        [_rightButton setTitle:aString forState:UIControlStateNormal];
        [_rightButton setTitleColor:titleColor forState:UIControlStateNormal];
    }
    _rightButton.titleLabel.font=[UIFont systemFontOfSize:titleFont];
    [self.navigationView addSubview:_rightButton];
    [_rightButton addTarget:self action:@selector(rightBtnClick:) forControlEvents:UIControlEventTouchUpInside];
}

//自定义导航栏背景颜色、图片
- (void)customNavigationBackgroundColor:(UIColor *)color withImage:(UIImage *)aImage{
    self.navigationView.backgroundColor=color;
    self.navigationView.image=aImage;
}


//导航栏右边下载按钮是否隐藏
- (void)customDownButtonHidden:(BOOL)hide{
    self.downButton.hidden = hide;
}

//导航栏上按钮的代理方法
-(void)leftBtnClick:(UIButton *)sender{
    if ([self.baseViewDelegate respondsToSelector:@selector(leftButtonHaveClick:)]) {
        [self.baseViewDelegate leftButtonHaveClick:sender];
    }
}
-(void)rightBtnClick:(UIButton *)sender{
    if ([self.baseViewDelegate respondsToSelector:@selector(rightButtonHaveClick:)]) {
        [self.baseViewDelegate rightButtonHaveClick:sender];
    }
}
-(void)downBtnClick:(UIButton *)sender{
    if ([self.baseViewDelegate respondsToSelector:@selector(downButtonHaveClick:)]) {
        [self.baseViewDelegate downButtonHaveClick:sender];
    }
}
#pragma mark - Life cycle


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - View rotation

- (BOOL)shouldAutorotate {
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations {
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation {
    return UIInterfaceOrientationPortrait;
}


@end
