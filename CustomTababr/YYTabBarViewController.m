//
//  YYTabBarViewController.m
//  CustomTababr
//
//  Created by 何亚运 on 2017/2/17.
//  Copyright © 2017年 YYStar. All rights reserved.
//

#import "YYTabBarViewController.h"
#import "RedViewController.h"
#import "YellowViewController.h"
#import "BlueViewController.h"
#import "YYTabBarButton.h"


static NSInteger const kTag = 100000;

@interface YYTabBarViewController ()
// 上次选中
@property (nonatomic,weak) UIButton *forwordSelectButton;

@end

@implementation YYTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    // 先将原有的tabbar给移除掉， 然后添加自定义的tabbar即可
    
    [self setupChildController];
    [self setupTabBar];
}

// 添加子控制器
- (void)setupChildController {
    RedViewController *redVC = [[RedViewController alloc] init];
    YellowViewController *yellowVC = [[YellowViewController alloc] init];
    BlueViewController *blueVC = [[BlueViewController alloc] init];
    
    self.viewControllers = @[redVC,yellowVC,blueVC];
}
// 设置tabbar
- (void)setupTabBar {
    // 获取tabbar的frame
    CGRect rect = self.tabBar.frame;
    // 创建一个view覆盖原有的tabbar
    UIView *tabbarView = [UIView new];
    tabbarView.frame = rect;
    tabbarView.backgroundColor = [UIColor grayColor];
    [self.view addSubview:tabbarView];
    // 移除原有的tabbar
    [self.tabBar removeFromSuperview];
    NSArray *tabbarTitle = @[@"red",@"yellow",@"blue"];
    // 添加barButton，并且计算frame
    for (int i = 0; i < self.viewControllers.count; i++) {
        YYTabBarButton *btn = [[YYTabBarButton alloc] init];
        
        CGFloat x = i * tabbarView.frame.size.width/self.viewControllers.count;
        btn.frame = CGRectMake(x, 0, tabbarView.frame.size.width/self.viewControllers.count, tabbarView.frame.size.height);
        [tabbarView addSubview:btn];
        [btn setTitle:tabbarTitle[i] forState:UIControlStateNormal];
        btn.tag = kTag + i;
        [btn addTarget:self action:@selector(clickTabBarVutton:) forControlEvents:UIControlEventTouchUpInside];
        // 默认进来的时候选中第一个
        if (i == 0) {
//            btn.selected = YES;
            self.forwordSelectButton = btn;
            [self.forwordSelectButton setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
        }
    }
    
}

//TODO: buttonClick
- (void)clickTabBarVutton:(UIButton *)button {
    // 移除之前选中
//    self.forwordSelectButton.selected = NO;
    // 选中的字体颜色也要移除
    [self.forwordSelectButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];

    // 当前选中
//    button.selected = YES;
    
    // 将当前选中，给之前选中
    self.forwordSelectButton = button;
    
    // button.tag-kTag为当前选中的index
    // 设置选中的控制器
//    self.selectedViewController = self.childViewControllers[button.tag-kTag];
    self.selectedIndex = button.tag-kTag;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
