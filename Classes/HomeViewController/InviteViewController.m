//
//  InviteViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "InviteViewController.h"
#import "UIButton+Vertical.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>

@interface InviteViewController()
@property (nonatomic,strong) UIImageView *imageView;

@property (nonatomic,strong) UITextField *inviteCodeTF;

@property (nonatomic,strong)UIButton *shareButton;


@property (strong,nonatomic)NSArray *buttonTitle;
@property (strong,nonatomic)NSArray *buttonImages;

@property (strong,nonatomic)UILabel *myInviteCode;


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




    for (int i = 0; i < self.buttonTitle.count; i++) {
        _shareButton = [[UIButton alloc]init];
        _shareButton.tag = i;
        _shareButton.frame = CGRectMake(i*BYSScreenWidth/4.0,BYSScreenHeight-64,BYSScreenWidth/4.0, 50);
        [_shareButton setImage:self.buttonImages[i] forState:UIControlStateNormal];
        _shareButton.backgroundColor = [UIColor clearColor];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize: 13.0];

        [_shareButton setTitle:self.buttonTitle[i] forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_shareButton verticalImageAndTitle:10];
        [_shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareChick:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:_shareButton];


    }

    _myInviteCode = [[UILabel alloc]initWithFrame:CGRectMake(0,BYSScreenHeight/2+110, BYSScreenWidth, 21)];

    NSString *str = @"我的邀请码: 5GJADKFA";
    NSMutableAttributedString *mutaAttributedString = [[NSMutableAttributedString alloc]initWithString:str];
    [mutaAttributedString addAttribute:NSForegroundColorAttributeName value:RGB(107, 104, 94) range:NSMakeRange(0, 6)];
     [mutaAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:16] range:NSMakeRange(0, 6)];
    [mutaAttributedString addAttribute:NSForegroundColorAttributeName value:RGB(63, 198, 228) range:NSMakeRange(7,8)];
    [mutaAttributedString addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:30 weight:18] range:NSMakeRange(7,8)];
    _myInviteCode.attributedText = mutaAttributedString;
    _myInviteCode.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_myInviteCode];

    




}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_inviteCodeTF resignFirstResponder];
}
- (void)shareChick:(UIButton *)sender
{
    //1、创建分享参数
    NSArray* imageArray = @[[UIImage imageNamed:@"p_y_q"]];
    //    （注意：图片必须要在Xcode左边目录里面，名称必须要传正确，如果要分享网络图片，可以这样传iamge参数 images:@[@"http://mob.com/Assets/images/logo.png?v=20150320"]）
    if (imageArray) {

        NSMutableDictionary *shareParams = [NSMutableDictionary dictionary];
        [shareParams SSDKSetupShareParamsByText:@"分享内容"
                                         images:imageArray
                                            url:[NSURL URLWithString:@"http://mob.com"]
                                          title:@"分享标题"
                                           type:SSDKContentTypeAuto];
        if (sender.tag == 0) {
            //            [ShareSDK share:SSDKPlatformTypeWechat
            //                 parameters:shareParams
            //             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {
            //
            //
            //                 switch (state) {
            //                     case SSDKResponseStateSuccess:
            //                     {
            //                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
            //                                                                             message:nil
            //                                                                            delegate:nil
            //                                                                   cancelButtonTitle:@"确定"
            //                                                                   otherButtonTitles:nil];
            //                         [alertView show];
            //                         break;
            //                     }
            //                     case SSDKResponseStateFail:
            //                     {
            //                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
            //                                                                             message:[NSString stringWithFormat:@"%@", error]
            //                                                                            delegate:nil
            //                                                                   cancelButtonTitle:@"确定"
            //                                                                   otherButtonTitles:nil];
            //                         [alertView show];
            //                         break;
            //                     }
            //                     case SSDKResponseStateCancel:
            //                     {
            //                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
            //                                                                             message:nil
            //                                                                            delegate:nil
            //                                                                   cancelButtonTitle:@"确定"
            //                                                                   otherButtonTitles:nil];
            //                         [alertView show];
            //                         break;
            //                     }
            //                     default:
            //                         break;
            //                 }
            //
            //
            //
            //             }];


            [ShareSDK getUserInfo:SSDKPlatformTypeQQ onStateChanged:^(SSDKResponseState state, SSDKUser *user, NSError *error) {
                NSLog(@"%@",user);

            }];

        }
        if (sender.tag == 1) {
            [ShareSDK share:SSDKPlatformSubTypeWechatTimeline
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {


                 switch (state) {
                     case SSDKResponseStateSuccess:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateFail:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:[NSString stringWithFormat:@"%@", error]
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateCancel:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     default:
                         break;
                 }



             }];

        }


        if (sender.tag == 2) {
            [ShareSDK share:SSDKPlatformTypeQQ
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {


                 switch (state) {
                     case SSDKResponseStateSuccess:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateFail:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:[NSString stringWithFormat:@"%@", error]
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateCancel:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     default:
                         break;
                 }



             }];

        }
        if (sender.tag == 3) {

            [ShareSDK share:SSDKPlatformTypeSinaWeibo
                 parameters:shareParams
             onStateChanged:^(SSDKResponseState state, NSDictionary *userData, SSDKContentEntity *contentEntity, NSError *error) {


                 switch (state) {
                     case SSDKResponseStateSuccess:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享成功"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateFail:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享失败"
                                                                             message:[NSString stringWithFormat:@"%@", error]
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     case SSDKResponseStateCancel:
                     {
                         UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"分享已取消"
                                                                             message:nil
                                                                            delegate:nil
                                                                   cancelButtonTitle:@"确定"
                                                                   otherButtonTitles:nil];
                         [alertView show];
                         break;
                     }
                     default:
                         break;
                 }
                 
                 
                 
             }];
        }
        
        
        
    }
}
-(NSArray *)buttonImages{

    if (!_buttonImages) {
        _buttonImages = @[[UIImage imageNamed:@"wei_xin"],
                          [UIImage imageNamed:@"p_y_q"],
                          [UIImage imageNamed:@"qq"],
                          [UIImage imageNamed:@"wei_bo"]


                          ];
    }
    return _buttonImages;
}
-(NSArray *)buttonTitle{

    if (!_buttonTitle) {
        _buttonTitle = @[@"微信好友",@"微信朋友圈",@"QQ",@"微博"];
    }
    return _buttonTitle;
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
