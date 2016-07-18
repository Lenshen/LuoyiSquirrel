//
//  SignInViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "SignInViewController.h"
@interface SignInViewController()
@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UIButton *convertButton;
@property (nonatomic,strong) NSString *signSting;
@property (nonatomic,strong) UILabel *signLabel;
@property (nonatomic,assign) NSInteger signInteger;





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
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, BYSScreenWidth, BYSScreenHeight-64)];
        _imageView.image = [UIImage imageNamed:@"sign_background"];
        _imageView.userInteractionEnabled = YES;

        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.center.x-50, 50, 100, 100)];
        imageview.image = [UIImage imageNamed:@"sign_imageButton"];

        _convertButton = [UIButton buttonWithType:UIButtonTypeCustom];
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

    self.signInteger ++;
    NSString *str = [NSString stringWithFormat:@"你已连续签到 %ld 天",self.signInteger];


    NSMutableAttributedString *mutaAttribute = [[NSMutableAttributedString alloc]initWithString:str];
    [mutaAttribute addAttributes:@{NSForegroundColorAttributeName:NavigationColor} range:NSMakeRange(7, self.signSting.length)];

    [mutaAttribute addAttributes:@{NSUnderlineStyleAttributeName:@"1"} range:NSMakeRange(7, self.signSting.length)];
    _signLabel.textColor = [UIColor grayColor];


    _signLabel.attributedText = mutaAttribute;


}
- (void)viewWillAppear:(BOOL)animated{

    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];

    //去除导航栏下方的横线
 
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
