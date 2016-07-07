//
//  ViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/6.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ViewController.h"
#import "SubLBXScanViewController.h"
//#import "MyQRViewController.h"
#import "LBXScanView.h"
#import <objc/message.h>
//#import "ScanResultViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"
//add try
//add try again

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}
- (IBAction)zbar:(id)sender {


    
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
    [self.navigationController pushViewController:vc animated:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
