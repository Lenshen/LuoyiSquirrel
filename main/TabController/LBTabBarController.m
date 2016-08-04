//
//  LBTabBarController.m
//  XianYu
//
//  Created by li  bo on 16/5/28.
//  Copyright © 2016年 li  bo. All rights reserved.
//

#import "LBTabBarController.h"
#import "NavigationViewController.h"

#import "HomeViewController.h"
#import "ImformationViewController.h"
#import "MineViewController.h"
//#import "LBpostViewController.h"
#import "ResourceViewController.h"

#import "LBTabBar.h"
#import "UIImage+Image.h"


#import "SubLBXScanViewController.h"
//#import "MyQRViewController.h"
#import "LBXScanView.h"
#import <objc/message.h>
#import "SearchViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"
#import "GoodsViewController.h"
#import "MarkViewController.h"

#import "PostConmmentViewController.h"
#import "ContentViewController.h"




@interface LBTabBarController ()<LBTabBarDelegate>

@end

@implementation LBTabBarController

#pragma mark - 第一次使用当前类的时候对设置UITabBarItem的主题
+ (void)initialize
{
    UITabBarItem *tabBarItem = [UITabBarItem appearanceWhenContainedInInstancesOfClasses:@[self]];
    
    NSMutableDictionary *dictNormal = [NSMutableDictionary dictionary];
    dictNormal[NSForegroundColorAttributeName] = [UIColor grayColor];
    dictNormal[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    NSMutableDictionary *dictSelected = [NSMutableDictionary dictionary];
    dictSelected[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    dictSelected[NSFontAttributeName] = [UIFont systemFontOfSize:11];

    [tabBarItem setTitleTextAttributes:dictNormal forState:UIControlStateNormal];
    [tabBarItem setTitleTextAttributes:dictSelected forState:UIControlStateSelected];

}

- (void)viewDidLoad {
    [super viewDidLoad];

    [self setUpAllChildVc];

    //创建自己的tabbar，然后用kvc将自己的tabbar和系统的tabBar替换下
    LBTabBar *tabbar = [[LBTabBar alloc] init];
    tabbar.myDelegate = self;
    //kvc实质是修改了系统的_tabBar
    [self setValue:tabbar forKeyPath:@"tabBar"];


}


#pragma mark - ------------------------------------------------------------------
#pragma mark - 初始化tabBar上除了中间按钮之外所有的按钮

- (void)setUpAllChildVc
{


    HomeViewController *HomeVC = [[HomeViewController alloc] init];
    [self setUpOneChildVcWithVc:HomeVC Image:@"tabbar_home" selectedImage:@"tabbar_home_selected" title:@"首页"];

    GoodsViewController *FishVC = [[GoodsViewController alloc] init];
    [self setUpOneChildVcWithVc:FishVC Image:@"tabbar_message_center" selectedImage:@"tabbar_message_center_selected" title:@"资源"];

    ResourceViewController *MessageVC = [[ResourceViewController alloc] init];
    [self setUpOneChildVcWithVc:MessageVC Image:@"tabbar_discover" selectedImage:@"tabbar_discover_selected" title:@"资讯"];

    MineViewController *MineVC = [[MineViewController alloc] init];
    [self setUpOneChildVcWithVc:MineVC Image:@"tabbar_profile" selectedImage:@"tabbar_profile_selected" title:@"我的"];


}

#pragma mark - 初始化设置tabBar上面单个按钮的方法

/**
 *  @author li bo, 16/05/10
 *
 *  设置单个tabBarButton
 *
 *  @param Vc            每一个按钮对应的控制器
 *  @param image         每一个按钮对应的普通状态下图片
 *  @param selectedImage 每一个按钮对应的选中状态下的图片
 *  @param title         每一个按钮对应的标题
 */
- (void)setUpOneChildVcWithVc:(UIViewController *)Vc Image:(NSString *)image selectedImage:(NSString *)selectedImage title:(NSString *)title
{
    NavigationViewController *nav = [[NavigationViewController alloc] initWithRootViewController:Vc];


//    Vc.view.backgroundColor = [self randomColor];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    Vc.navigationItem.backBarButtonItem = item;

    UIImage *myImage = [UIImage imageNamed:image];
    myImage = [myImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    //tabBarItem，是系统提供模型，专门负责tabbar上按钮的文字以及图片展示
    Vc.tabBarItem.image = myImage;

    UIImage *mySelectedImage = [UIImage imageNamed:selectedImage];
    mySelectedImage = [mySelectedImage imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];

    Vc.tabBarItem.selectedImage = mySelectedImage;

    //tabBarItem字体的设置
    //正常状态
    NSMutableDictionary *normalText = [NSMutableDictionary dictionary];
    normalText[NSForegroundColorAttributeName] = [UIColor colorWithRed:123/255.0 green:123/255.0 blue:123/255.0 alpha:1.0];
    [Vc.tabBarItem setTitleTextAttributes:normalText forState:UIControlStateNormal];



    //选中状态
    NSMutableDictionary *selectedText = [NSMutableDictionary dictionary];
    selectedText[NSForegroundColorAttributeName] = NavigationColor;
    [Vc.tabBarItem setTitleTextAttributes:selectedText forState:UIControlStateSelected];

    Vc.tabBarItem.title = title;

    Vc.navigationItem.title = title;

    [self addChildViewController:nav];
    
}



#pragma mark - ------------------------------------------------------------------
#pragma mark - LBTabBarDelegate
//点击中间按钮的代理方法
- (void)tabBarPlusBtnClick:(LBTabBar *)tabBar
{



    [self openScanner];

}

- (void)openScanner
{


    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];

    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;

    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;

    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;

    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;

    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;

    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;

    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];

    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;

    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;
    
//    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];


}

//- (UIColor *)randomColor
//{
//    CGFloat r = arc4random_uniform(256);
//    CGFloat g = arc4random_uniform(256);
//    CGFloat b = arc4random_uniform(256);
//    return [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1.0];
//
//}

@end
