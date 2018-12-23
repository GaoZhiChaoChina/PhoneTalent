//
//  GZCMineViewController.m
//  PhoneTalent
//
//  Created by cloud on 15/12/4.
//  Copyright (c) 2015年 cloud. All rights reserved.
//

#import "ToolController.h"
#import "DrawLinesViewController.h"
#import "UIParameter.h"
#import "NinaPagerView.h"

@interface ToolController ()<UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSArray* dataAray;

@end

@implementation ToolController

+ (void)load{
    NSLog(@"%s",__func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavTitle:@"贝塞尔曲线"];
    [self addLeafNavigationButton:@""];
    
    [GZCUtility setClearColorTheme:self.navigationController];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.tableView];
    self.dataAray = @[@"贝塞尔曲线画图",@"tab"];

    [self.tableView  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(@(0));
    }];

}
    
    // 监听 tableView.contentOffset，也可以用 kvo 监听
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
}
    
    // --------------------------- 以下代码不是实验重点 ---------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataAray.count;
}
    
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell"];
    NSString *str = self.dataAray[indexPath.row];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mycell"];
        cell.textLabel.text = str;
    }
    return cell;
}
    
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UITableViewHeaderFooterView *view = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"UITableViewHeaderFooterViewID"];
    if (view == nil) {
        view = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:@"UITableViewHeaderFooterViewID"];
        view.contentView.backgroundColor = [UIColor colorWithWhite:0.92 alpha:1.0];;
    }
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *dict = (NSDictionary *)[self.dataAray objectAtIndex:indexPath.row];
    NSLog(@"点中的哪一行%@", dict);

    switch (indexPath.row) {
        case 0:
            {
                DrawLinesViewController *vc = [[DrawLinesViewController alloc] init];
                [self.navigationController pushViewController:vc animated:YES];
            }
            break;
        case 1:
        {
            [self addTabsView];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)addTabsView {
    self.title = @"Nina";
    self.navigationController.navigationBar.translucent = NO;
    //Need You Edit
    /**<  上方显示标题，如果您只传入  Titles showing on the topTab   **/
    NSArray *titleArray =   @[
                              @"大连市",
                              @"甘井子",
                              @"星海广场",
                              @"西岗",
                              @"马栏子",
                              @"革镇堡",
                              @"中山",
                              @"人民广场",
                              @"中山广场"
                              ];
    /**< 每个标题下对应的控制器，只需将您创建的控制器类名加入下列数组即可(注意:数量应与上方的titles数量保持一致，若少于titles数量，下方会打印您缺少相应的控制器，同时默认设置的最大控制器数量为10=。=)  。
     ViewControllers to the titles on the topTab.Just add your VCs' Class Name to the array. Wanning:the number of ViewControllers should equal to the titles.Meanwhile,default max VC number is 10.
     **/
    NSArray *vcsArray = @[
                          @"FirstViewController",
                          @"SecondViewController",
                          @"ThirdViewController",
                          @"ForthViewController",
                          @"FifthViewController",
                          @"SixthViewController",
                          @"SeventhViewController",
                          @"EighthViewController",
                          @"NinthViewController",
                          ];
    /**< 您可以选择是否要改变标题选中的颜色(默认为黑色)、未选中的颜色(默认为灰色)或者下划线的颜色(默认为色值是ff6262)。如果传入颜色数量不够，则按顺序给相应的部分添加颜色。
     You can choose whether change your titles' selectColor(default is black),unselectColor(default is gray) and underline color(default is Color value ff6262).**/
    NSArray *colorArray = @[
                            [UIColor brownColor], /**< 选中的标题颜色 Title SelectColor  **/
                            [UIColor grayColor], /**< 未选中的标题颜色  Title UnselectColor **/
                            [UIColor redColor], /**< 下划线颜色 Underline Color   **/
                            ];
    /**< 创建ninaPagerView，控制器第一次是根据您划的位置进行相应的添加的，类似网易新闻虎扑看球等的效果，后面再滑动到相应位置时不再重新添加，如果想刷新数据，您可以在相应的控制器里加入刷新功能，低耦合。需要注意的是，在创建您的控制器时，设置的frame为FUll_CONTENT_HEIGHT，即全屏高减去导航栏高度再减去Tabbar的高度，如果这个高度不是您想要的，您可以去UIParameter.h中进行设置XD。
     A tip you should know is that when init the VCs frames,the default frame i set is FUll_CONTENT_HEIGHT,it means fullscreen height - NavigationHeight - TabbarHeight.If the frame is not what you want,just go to UIParameter.h to change it!XD**/
    NinaPagerView *ninaPagerView = [[NinaPagerView alloc] initWithTitles:titleArray WithVCs:vcsArray WithColorArrays:colorArray];
    [self.view addSubview:ninaPagerView];
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 40;
        _tableView.sectionHeaderHeight = 20;
        _tableView.showsVerticalScrollIndicator = false;
    }
    return _tableView;
}
@end
