//
//  AdvertViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/26.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "AdvertViewController.h"

@interface AdvertViewController ()

@property (strong, nonatomic) UIWebView *webView;

@end

@implementation AdvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets= NO;
    self.view.backgroundColor = [UIColor whiteColor];



}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSLog(@"%@",self.urlString);
    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0,64,BYSScreenWidth, BYSScreenHeight-64)];

    NSURLRequest *request   = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:@"http://www.baidu.com"]];
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
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
