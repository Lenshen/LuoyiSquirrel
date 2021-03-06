//
//  SignInViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "SignInViewController.h"
#import "BYSAlertView.h"
#import "BYSHttpTool.h"
#import "BYSHttpParameter.h"
@interface SignInViewController()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *convertButton;
@property (nonatomic,strong) NSString *signSting;
@property (nonatomic,strong) UILabel *signLabel;
@property (nonatomic,assign) NSInteger signInteger;
@property (nonatomic,strong) BYSAlertView *alertView;



@property (nonatomic,strong) NSString *times;
@property (nonatomic,strong) NSString *serialTimes;





@end


@implementation SignInViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"签到";
    [self.view addSubview:self.imageView];




    
    
}
- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,64, BYSScreenWidth, BYSScreenHeight-64)];
        _imageView.image = [UIImage imageNamed:@"sign_background"];
        _imageView.userInteractionEnabled = YES;

        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-50, 50, 100, 100)];
        imageview.image = [UIImage imageNamed:@"sign_imageButton"];

        _convertButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _convertButton.frame = CGRectMake(self.view.center.x-40,CGRectGetMaxY(imageview.frame)-10 ,80,30);
        _convertButton.backgroundColor = NavigationColor;
        _convertButton.layer.cornerRadius = 5;

        [_convertButton setTitle:@"点我签到" forState:UIControlStateNormal];
        _convertButton.titleLabel.font = [UIFont systemFontOfSize:15];

        [_convertButton addTarget:self action:@selector(sign:) forControlEvents:UIControlEventTouchUpInside];
        [_convertButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];

        

        _signLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.center.x-80, CGRectGetMaxY(_convertButton.frame)+25, 160, 30)];
        self.signSting = @"365";
        self.signInteger = [self.signSting integerValue];



        NSString *str = [NSString stringWithFormat:@"你已连续签到 %ld 天",self.signInteger];

        NSMutableAttributedString *mutaAttribute = [[NSMutableAttributedString alloc]initWithString:str];
        [mutaAttribute addAttributes:@{NSForegroundColorAttributeName:NavigationColor} range:NSMakeRange(7, self.signSting.length)];

        [mutaAttribute addAttributes:@{NSUnderlineStyleAttributeName:@"1"} range:NSMakeRange(7, self.signSting.length)];
        _signLabel.textColor = [UIColor grayColor];


        _signLabel.attributedText = mutaAttribute;
        _signLabel.textAlignment = NSTextAlignmentCenter;
        _signLabel.font = [UIFont systemFontOfSize:14];







        [_imageView addSubview:imageview];
        [_imageView addSubview:_signLabel];
        [_imageView addSubview:_convertButton];




    }
    return _imageView;
}
- (void)sign:(UIButton *)sender
{






    [BYSHttpTool POST:APP_member_service Parameters:[BYSHttpParameter api_sign_in] Success:^(id responseObject) {


        NSLog(@"%@",responseObject);
        NSString *str = responseObject[@"message"];
//        [self getMutableStri:self.codeString];


        [self setAlertUI:str];

    } Failure:^(NSError *error) {
        
    }];





}

- (void)viewWillAppear:(BOOL)animated{

    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];

    //去除导航栏下方的横线

    [BYSHttpTool POST:APP_member_service Parameters:[BYSHttpParameter api_get_sign] Success:^(id responseObject) {


        NSLog(@"%@",responseObject);
        //        self.codeString = responseObject[@"data"];
        //        [self getMutableStri:self.codeString];


        NSDictionary *dic = responseObject[@"data"];
        self.times = dic[@"Times"];
        self.serialTimes = [NSString stringWithFormat:@"%@",dic[@"SerialTimes"]] ;






        NSString *str = [NSString stringWithFormat:@"你已连续签到 %@ 天",self.serialTimes];

        NSLog(@"%ld",self.serialTimes.length);

        NSMutableAttributedString *mutaAttribute = [[NSMutableAttributedString alloc]initWithString:str];
        [mutaAttribute addAttributes:@{NSForegroundColorAttributeName:NavigationColor} range:NSMakeRange(7,self.serialTimes.length)];

        [mutaAttribute addAttributes:@{NSUnderlineStyleAttributeName:@"1"} range:NSMakeRange(7, self.serialTimes.length)];
        _signLabel.textColor = [UIColor grayColor];


        _signLabel.attributedText = mutaAttribute;

    } Failure:^(NSError *error) {
        
    }];

 
}

- (void)setAlertUI:(NSString *)str
{

    _alertView = [[BYSAlertView alloc]initWithFrame:CGRectMake(15,-110, BYSScreenWidth-15*2, 180) titleString:@"温馨提示"  messageSting:str buttonTitle:@"确定"];
    __weak typeof (self) weakSelf = self;
    _alertView.chickDissMissButton = ^{
        weakSelf.alertView = nil;
    };
    [_alertView.rightButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];



    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView.alphaView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];




    [UIView animateWithDuration:0.7 animations:^{

        self.alertView.frame = CGRectMake(15, 110, BYSScreenWidth-15*2, 180);
    }];
}



- (void)dismiss:(id)sender
{

    self.alertView.alphaView.hidden = YES;
    [self.alertView.alphaView removeFromSuperview];
    self.alertView.alphaView = nil;
    self.alertView.hidden = YES;
    [self.alertView removeFromSuperview];
    self.alertView = nil;
    NSLog(@"666666");


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
