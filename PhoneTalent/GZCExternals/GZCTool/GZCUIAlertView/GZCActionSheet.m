//
//  GZCActionSheet.m
//  funny
//
//  Created by gaozhichao on 15/11/23.
//  Copyright © 2015年 xiexin. All rights reserved.
//

#import "GZCActionSheet.h"

#define   MYScreen_Width [UIScreen mainScreen].bounds.size.width
#define   MYScreen_Height [UIScreen mainScreen].bounds.size.height

const CGFloat GZCCellHeight = 50.f;
const CGFloat GZCSeparatorHeight = 5.f;
const CGFloat GZCAnimationDuration = .2f;
const CGFloat GZCFontSize = 18.f;


@interface GZCActionSheet () <UITableViewDataSource, UITableViewDelegate>
{
    UITableView *_tableView;
    UIButton *_cancleButton;
    UILabel *_titleLabel;
    UIView *_sheetView;

}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *cancleTitle;
@property (nonatomic, strong) NSArray *otherTitles;
@property (nonatomic, strong) NSIndexSet *destructiveIndexSet;
@end

@implementation GZCActionSheet

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithTitle:(NSString *)title delegate:(id<GZCActionSheetDelegate>)delegate cancelButtonTitle:(NSString *)cancelButtonTitle destructiveButtonIndexSet:(NSIndexSet *)destructiveIndexSet otherButtonTitles:(NSArray *)otherButtonTitles
{
    self = [super init];
    if (self) {
        _delegate = delegate;
        _title = title;
        _cancleTitle = cancelButtonTitle;
        _destructiveIndexSet = destructiveIndexSet;
        _otherTitles = otherButtonTitles;
        
        [self setup];
    }
    return self;
}


- (void)setup
{
    _titleColor = [UIColor blackColor];
    _sheetView = [[UIView alloc] init];
    
    //1、_titleLabel
    if (_title.length) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.numberOfLines = 2;
        _titleLabel.text = _title;
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.backgroundColor = [UIColor whiteColor];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont fontWithName:@"DFPWaWaW5-GB" size:14.0f];;
        _titleLabel.userInteractionEnabled = YES;
        _titleLabel.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,GZCCellHeight);
        [_sheetView addSubview:_titleLabel];
    }
    
    //2、_tableView
    _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.separatorInset = UIEdgeInsetsMake(0, 15, 0, 15);
    _tableView.backgroundColor = [UIColor whiteColor];
    _tableView.rowHeight = GZCCellHeight;
    
    CGFloat screenHeight = MYScreen_Height - 28;
    CGFloat totalHeight = _otherTitles.count * GZCCellHeight + GZCCellHeight + GZCSeparatorHeight +( _title.length ? GZCCellHeight : 0);
    BOOL moreThanScreen = totalHeight > screenHeight;
    
    if (!moreThanScreen) {
        _tableView.bounces = NO;
    }
    else {
        _tableView.bounces = YES;
    }
    
    _tableView.backgroundColor = [UIColor whiteColor];
    
    if (!moreThanScreen) {
        _tableView.frame = CGRectMake(0, ( _title.length ? GZCCellHeight : 0), [UIScreen mainScreen].bounds.size.width,(GZCCellHeight * _otherTitles.count));
    }
    else {
        _tableView.frame = CGRectMake(0, ( _title.length ? GZCCellHeight : 0), [UIScreen mainScreen].bounds.size.width,(screenHeight - GZCCellHeight * 2) - GZCSeparatorHeight);
        
    }
    
    [_sheetView addSubview:_tableView];
    
    
    //3、_cancleButton
    NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:_cancleTitle
                                                                          attributes:@{
                                                                                       NSFontAttributeName:[UIFont fontWithName:@"DFPWaWaW5-GB" size:GZCFontSize] ,
                                                                                       NSForegroundColorAttributeName: _titleColor,
                                                                                       }];
    _cancleButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _cancleButton.backgroundColor = [UIColor whiteColor];
    [_cancleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_cancleButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    [_cancleButton addTarget:self action:@selector(cancelButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    [_sheetView addSubview:_cancleButton];
    _cancleButton.frame = CGRectMake(0, _tableView.frame.origin.y + _tableView.bounds.size.height + GZCSeparatorHeight, [UIScreen mainScreen].bounds.size.width,GZCCellHeight);
    
    
    //4、_sheetView
    CGFloat sheetHeight = moreThanScreen ? screenHeight : totalHeight;
    _sheetView.frame = CGRectMake(0,MYScreen_Height - sheetHeight, MYScreen_Width, sheetHeight);
    _sheetView.backgroundColor = [UIColor blackColor];
    [self addSubview:_sheetView];
    
    [self addTarget:self action:@selector(hideActionSheet) forControlEvents:UIControlEventTouchUpInside];
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4f];
    _cancelButtonIndex = _otherTitles.count;
    
    
}

- (void)showInView:(UIView *)superView
{
    [superView.window addSubview:self];
    self.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width,[UIScreen mainScreen].bounds.size.height);
    
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.fromValue = @(800);
    animation.duration = GZCAnimationDuration;
    [_sheetView.layer addAnimation:animation forKey:@"com.history.animation"];
}

- (void)hideActionSheet
{
    CABasicAnimation *animation = [CABasicAnimation animation];
    animation.keyPath = @"position.y";
    animation.toValue = @(800);
    animation.duration = GZCAnimationDuration;
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [_sheetView.layer addAnimation:animation forKey:@"com.history.animation"];
    
    [UIView animateKeyframesWithDuration:GZCAnimationDuration
                                   delay:GZCAnimationDuration
                                 options:UIViewKeyframeAnimationOptionCalculationModeLinear
                              animations:^{
                                  self.alpha = 0.f;
                              }
                              completion:^(BOOL finished) {
                                  [self removeFromSuperview];
                              }];
}

- (void)cancelButtonClicked
{
    [self hideActionSheet];
    
    if ([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [_delegate actionSheet:self clickedButtonAtIndex:_cancelButtonIndex];
    }
}


- (void)setTitleColor:(UIColor *)titleColor
{
    if (_titleColor != titleColor) {
        _titleColor = titleColor;
        [_tableView reloadData];
        NSAttributedString *attributedTitle = [[NSAttributedString alloc] initWithString:_cancleTitle
                                                                              attributes:@{
                                                                                           NSFontAttributeName: [UIFont systemFontOfSize:GZCFontSize],
                                                                                           NSForegroundColorAttributeName: _titleColor,
                                                                                           }];
        [_cancleButton setAttributedTitle:attributedTitle forState:UIControlStateNormal];
    }
}

#pragma mark - TableView DataSource & Delegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _otherTitles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * kCellIdf = @"kCellIdf";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIdf];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellIdf];
    }
    cell.accessoryType = UITableViewCellAccessoryNone;
    cell.textLabel.text = _otherTitles[indexPath.row];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.font = [UIFont fontWithName:@"DFPWaWaW5-GB" size:GZCFontSize];
    
    if ([_destructiveIndexSet containsIndex:indexPath.row]) {
        cell.textLabel.textColor = [UIColor redColor];
    }
    else {
        cell.textLabel.textColor = self.titleColor;
    }
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.01f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self hideActionSheet];
    
    if ([_delegate respondsToSelector:@selector(actionSheet:clickedButtonAtIndex:)]) {
        [_delegate actionSheet:self clickedButtonAtIndex:indexPath.row];

    }
}

//- (void)albumButtonDidClick:(id)sender{
//    
//    [_MKFPublicPhotoClass albumButtonDidClick: self.mySubmitWorkController];
//    
//}
//- (void)takeButtonDidClick:(id)sender{
//    
//    [_MKFPublicPhotoClass takeButtonDidClick:self.mySubmitWorkController];
//}
//
//- (void) selectImageFinish :(NSData*) imageData{
//    
//    NSLog(@"imageData=%@",imageData);
//    UIImage *image = [UIImage imageWithData:imageData];
//    FunnySubmitWorkController *funnySubmitWorkController =[[FunnySubmitWorkController alloc]init];
//    funnySubmitWorkController.submitImage = image;
//    [self.mySubmitWorkController.navigationController pushViewController:funnySubmitWorkController animated:YES];
//    
//}
//
@end
