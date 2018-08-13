//
//  RootTabBC.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "RootTabBC.h"

@interface RootTabBC ()

@end

@implementation RootTabBC

static RootTabBC *rootBC = nil;
static dispatch_once_t predicate;

+ (instancetype)shareRootTabBC {
    dispatch_once(&predicate, ^{
        rootBC = [[RootTabBC alloc] init];
    });
    return rootBC;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.delegate = self;
        [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    HomeVC *home = [HomeVC new];
//    BaseNC *homeNC = [[BaseNC alloc] initWithRootViewController:home];
//    homeNC.index = 0;
//    [self addChildViewController:home image:@"Home_icon1" selectedImage:@"Home_icon2" Title:@"首页" Navigation:homeNC];
//
//    AllGoodsVC *goods = [AllGoodsVC new];
//    BaseNC *goodsNC = [[BaseNC alloc] initWithRootViewController:goods];
//    goodsNC.index = 1;
//    [self addChildViewController:goods image:@"Goods_icon1" selectedImage:@"Goods_icon2" Title:@"全部商品" Navigation:goodsNC];
//
//    MemberCenterVC *member = [MemberCenterVC new];
//    BaseNC *memberNC = [[BaseNC alloc] initWithRootViewController:member];
//    memberNC.index = 2;
//    [self addChildViewController:member image:@"Vip_icon" selectedImage:@"Vip_icon" Title:@"会员卡" Navigation:memberNC];
//    
//    ShoppingCartVC *cart = [ShoppingCartVC new];
//    BaseNC *cartNC = [[BaseNC alloc] initWithRootViewController:cart];
//    cartNC.index = 3;
//    [self addChildViewController:cart image:@"shopping_icon1" selectedImage:@"shopping_icon2" Title:@"购物车" Navigation:cartNC];
//
//    UserInfoVC *mine = [UserInfoVC new];
//    BaseNC *mineNC = [[BaseNC alloc] initWithRootViewController:mine];
//    mineNC.index = 4;
//    [self addChildViewController:mine image:@"My_icon1" selectedImage:@"My_icon2" Title:@"我的" Navigation:mineNC];
//
//    [self setViewControllers:@[homeNC, goodsNC, memberNC, cartNC, mineNC] animated:YES];
//    self.selectedIndex = 0;
//    [self setSelectedIndex:0];
    self.lastSelectedIndex = 0;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tabBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]]];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    UIView *sub = [self.tabBar valueForKey:@"_backgroundView"];
    for (id subView in sub.subviews) {
        if ([subView isKindOfClass:[UIImageView class]]) {
            UIImageView *shadow_view = (UIImageView *) subView;
            shadow_view.backgroundColor = kColorWithCode(@"#ECECEC");
            shadow_view.frame = CGRectMake(0, -0.5, kScreenWidth, 0.5);
        }
    }
}

- (void)addChildViewController:(UIViewController *)childViewController image:(NSString *)image selectedImage:(NSString *)selectedImage Title:(NSString *)title Navigation:(UINavigationController *)navigationVC {
    //标题
    //tabBarItem图片
    navigationVC.tabBarItem.imageInsets = UIEdgeInsetsMake(-2, 0, 2, 0);
    childViewController.tabBarItem.image = [CUSTOMIMG(image) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    childViewController.tabBarItem.selectedImage = [CUSTOMIMG(selectedImage) imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    [childViewController.tabBarItem setTitle:title];
//    [childViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorTabbarGray, NSFontAttributeName : CUSTOMFONT(10.f)} forState:UIControlStateNormal];
//    [childViewController.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName : kColorThemeGreen, NSFontAttributeName : CUSTOMFONT(10.f)} forState:UIControlStateSelected];
    //导航控制器
    [self addChildViewController:navigationVC];
}

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item {
    //获得选中的item
    NSUInteger tabIndex = [tabBar.items indexOfObject:item];
    if (tabIndex != self.selectedIndex) {
        //设置最近一次变更
        self.selectedIndex = tabIndex;
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex {
    //判断是否相等,不同才设置
    if (self.selectedIndex != selectedIndex) {
        //设置最近一次
        _lastSelectedIndex = self.selectedIndex;
        FLog(@"1 OLD:%lu , NEW:%lu", (unsigned long) self.lastSelectedIndex, (unsigned long) selectedIndex);
        [self animationWithIndex:selectedIndex];
    }
    //调用父类的setSelectedIndex
    [super setSelectedIndex:selectedIndex];
}

- (void)animationWithIndex:(NSInteger)index {
    NSMutableArray * tabbarbuttonArray = [NSMutableArray array];
    for (UIView *tabBarButton in self.tabBar.subviews) {
        if ([tabBarButton isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            [tabbarbuttonArray addObject:tabBarButton];
        }
    }
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"transform.scale";
    animation.values = @[@1.0,@1.3,@0.9,@1.15,@0.95,@1.02,@1.0];
    animation.duration = 1;
    animation.calculationMode = kCAAnimationCubic;
    [[tabbarbuttonArray[index] layer] addAnimation:animation forKey:@"TabbarAnimation"];
}

#pragma mark - tabbar转场动画
- (nullable id<UIViewControllerAnimatedTransitioning>)tabBarController:(UITabBarController *)tabBarController animationControllerForTransitionFromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    if (fromVC == nil) {
        return nil;
    }
    return [[AnimationManager alloc] init];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
