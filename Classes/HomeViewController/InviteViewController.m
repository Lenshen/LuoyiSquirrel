//
//  InviteViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "InviteViewController.h"

@interface InviteViewController()
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UITextField *inviteCodeTF;


@end

@implementation InviteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"邀请";
    [self.view addSubview:self.imageView];



    self.inviteCodeTF = [[UITextField alloc]initWithFrame:CGRectMake(10, 20+64, BYSScreenWidth-90-10-10, 40)];
    self.inviteCodeTF.placeholder = @"  请输入邀请码";
    self.inviteCodeTF.layer.borderColor = RGB(246, 198, 121).CGColor;
    self.inviteCodeTF.layer.borderWidth = 1;
    self.inviteCodeTF.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.inviteCodeTF];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMaxX(self.inviteCodeTF.frame)+10, 20+64, 80, 40);
    button.backgroundColor = NavigationColor;
    [button setTitle:@"兑换" forState:UIControlStateNormal];
    button.layer.cornerRadius = 5;
    button.layer.masksToBounds = YES;
    [self.view addSubview:button];



}

- (UIImageView *)imageView
{
    if (!_imageView) {
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,64, BYSScreenWidth, BYSScreenHeight-64)];
        _imageView.image = [UIImage imageNamed:@"invite_background"];
        _imageView.userInteractionEnabled = YES;

        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(invite:)];

        [_imageView addGestureRecognizer:tap];

        


        


    }
    return _imageView;
}


- (void)invite:(id)sender
{



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
