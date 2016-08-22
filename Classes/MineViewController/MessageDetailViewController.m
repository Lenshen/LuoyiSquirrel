//
//  MessageDetailViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/18.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MessageDetailViewController.h"

@interface MessageDetailViewController ()

@property (nonatomic, strong)UILabel *timeLabel;

@property (nonatomic, strong)UILabel *contentLabel;

@end

@implementation MessageDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"消息详情";
    self.view.backgroundColor = [UIColor whiteColor];
    [self configUI];





}

- (void)configUI
{
    UIImageView *leftImageView =[[UIImageView alloc]initWithFrame:CGRectMake(10, 15+64, 25, 25)];
    leftImageView.image = [UIImage imageNamed:@"clock_message"];

    UILabel *sysLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(leftImageView.frame)+10, 15+64,200,21)];
    sysLabel.font = [UIFont systemFontOfSize:17];
    sysLabel.text = @"系统通知";

    _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth-150-10, 15+64, 150, 21)];
    _timeLabel.text = @"2016-8 18:50";
    _timeLabel.font = [UIFont systemFontOfSize:14];
    _timeLabel.textColor = [UIColor grayColor];
    _timeLabel.textAlignment = NSTextAlignmentRight;

    UILabel *lineLabel  = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(sysLabel.frame)+20, BYSScreenWidth, 0.7)];
    lineLabel.backgroundColor = TableviewColor;

    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineLabel.frame)+20, BYSScreenWidth-10-10, BYSScreenHeight-64-200)];
    _contentLabel.text = @"        “太可怕！北京人周末没事儿千万别去这里！太悲惨……”近日，很多北京人的微信朋友圈里流传着一则帖子，里面列举了游客在辽宁东戴河旅游区骑快艇被宰、车胎莫名被扎、吃海鲜被要高价、被服务员强行揽客砸车等遭遇，受到不少网民吐槽。东戴河真有这么乱吗？记者驱车前往东戴河暗访发现，这里的个别业户存在不诚信经营甚至恶意欺诈的行为，政府监管面临“猫捉老鼠”的挑战。";
    _contentLabel.numberOfLines = 0;
    [_contentLabel sizeToFit];


    [self.view addSubview:leftImageView];
    [self.view addSubview:sysLabel];
    [self.view addSubview:_timeLabel];
    [self.view addSubview:lineLabel];
    [self.view addSubview:_contentLabel];
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
