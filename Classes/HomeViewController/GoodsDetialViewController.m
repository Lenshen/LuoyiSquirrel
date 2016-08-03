//
//  GoodsDetialViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/25.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "GoodsDetialViewController.h"

@interface GoodsDetialViewController ()
@property (strong, nonatomic) UIWebView *webView;


@end

@implementation GoodsDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    NSString *mainPath = [[NSBundle mainBundle]bundlePath]
    ;
    NSString *htmlString = @"/web/goodsDetail.html";
    NSString *path = [mainPath stringByAppendingString:htmlString];


    NSURLRequest *request   = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"file://%@",[path stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]]]]];


    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
}

- (UIWebView *)webView
{
    if (!_webView) {

        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];



        [self.view addSubview:_webView];
        
    }
    return _webView;
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
