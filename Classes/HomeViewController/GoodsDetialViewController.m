//
//  GoodsDetialViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/25.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "GoodsDetialViewController.h"
#import <JavaScriptCore/JavaScriptCore.h>
#import "AssessDetailViewController.h"
#import "MaterialsViewController.h"
#import "AssessListViewController.h"
#import "GetScoreView.h"
#import "YouSoreViewController.h"


@interface GoodsDetialViewController ()<UIWebViewDelegate,chickCollectionViewDelegate>
@property (strong, nonatomic) UIWebView *webView;
@property (nonatomic,weak) JSContext * context;
@property (nonatomic, strong) GetScoreView *scoreVIiew;
@property (nonatomic, strong) UIView *aplaView;




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
    self.webView.delegate = self;

    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];




    [self getScore];



}

- (void)getScore
{
    self.aplaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, BYSScreenHeight)];
    self.aplaView.backgroundColor = [UIColor blackColor];
    self.aplaView.alpha = 0.4;
    [self.view addSubview:self.aplaView];
    self.aplaView.hidden = YES;

    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmiss:)];
    [self.aplaView addGestureRecognizer:tap];

    _scoreVIiew = [[GetScoreView alloc]initWithFrame:CGRectMake(0, BYSScreenHeight/2.5, BYSScreenWidth, BYSScreenHeight)];
    [self.view addSubview:_scoreVIiew];
    _scoreVIiew.backgroundColor = [UIColor whiteColor];
    _scoreVIiew.hidden = YES;
    _scoreVIiew.chickDelegate = self;
}
- (void)chickCollectionViewDelegate:(NSInteger)tag WithId:(NSInteger)preson_id
{
    [self.navigationController pushViewController:[YouSoreViewController new] animated:YES];
}
- (void)dissmiss:(UIButton *)sender
{
    self.aplaView.hidden = YES;
    self.scoreVIiew.hidden = YES;
}
- (UIWebView *)webView
{
    if (!_webView) {

        _webView = [[UIWebView alloc]initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)];



        [self.view addSubview:_webView];
        
    }
    return _webView;

}
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    _context[@"assessDetail"] =
    ^{

        [self.navigationController pushViewController:[AssessDetailViewController new] animated:YES];
        
    };
    _context[@"ingredientsList"]=^
    {
        [self.navigationController pushViewController:[MaterialsViewController new] animated:YES];

    };
    _context[@"evaluateSeeMore"]=^
    {
        [self.navigationController pushViewController:[AssessListViewController new] animated:YES];
    };

    _context[@"grade"] = ^
    {
        self.aplaView.hidden = NO;
        self.scoreVIiew.hidden = NO;


    };

    
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
