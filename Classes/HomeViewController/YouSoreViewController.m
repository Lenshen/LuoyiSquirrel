//
//  YouSoreViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/25.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "YouSoreViewController.h"
#import "TriangleView.h"
#import "UIButton+Vertical.h"
#import <ShareSDK/ShareSDK.h>
#import <ShareSDKUI/ShareSDK+SSUI.h>
#import "BYSHttpTool.h"
#import "BYSHttpParameter.h"
#import "ScoreModel.h"

@interface YouSoreViewController ()
@property (nonatomic,strong)TriangleView *triangleView;
@property (nonatomic,strong)UIImageView *minImageView;
@property (nonatomic,strong)UILabel *scoreLabel;

@property (nonatomic,strong)UILabel *labelTip;
@property (nonatomic,strong)UILabel *labelBaseText;


@property (nonatomic,strong)UIButton *shareButton;
@property (nonatomic, strong)ScoreModel *model;

@property (strong,nonatomic)NSArray *buttonTitle;
@property (strong,nonatomic)NSArray *buttonImages;


@end

@implementation YouSoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    _triangleView = [[TriangleView alloc]initWithFrame:CGRectMake(100, 100, 100, 100)];
//    [self.view addSubview:self.triangleView];
    self.view.backgroundColor =[UIColor whiteColor];
    [BYSHttpTool POST:APP_goods_graded Parameters:[BYSHttpParameter get_goods_gradedWithGoods_id:@"0" member_id:@"0"] Success:^(id responseObject) {
        NSDictionary *dic = responseObject[@"data"];
        self.model = [self.model initWithDictionary:dic error:nil];
        self.scoreLabel.text = self.model.user_score;
        self.labelTip.text = self.model.remark;
        self.labelBaseText.text = self.model.goods_score;

        NSLog(@"%@",responseObject);


    } Failure:^(NSError *error) {
        
    }];


    [self configUI];



}
- (ScoreModel *)model
{
    if (!_model) {
        _model = [ScoreModel new];
    }
    return _model;
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
- (void)configUI
{
    UIImageView *bigImageView = [[UIImageView alloc]initWithFrame:CGRectMake(BYSScreenWidth/2-90, 30+64, 180, 180)];
    bigImageView.layer.borderColor = RGB(188, 251, 182).CGColor;
    bigImageView.layer.borderWidth = 8.0;
    bigImageView.layer.cornerRadius = bigImageView.frame.size.width/2;
    bigImageView.layer.masksToBounds = YES;
    [self.view addSubview:bigImageView];

    _minImageView = [[UIImageView alloc]initWithFrame:CGRectMake(BYSScreenWidth/2-72+8, 30+64+8, 180-16, 180-16)];
    _minImageView.center = bigImageView.center;
    _minImageView.layer.borderColor = NavigationColor.CGColor;
    _minImageView.layer.borderWidth = 8.0;
    _minImageView.layer.cornerRadius = _minImageView.frame.size.width/2;
    _minImageView.layer.masksToBounds = YES;
    [self.view addSubview:_minImageView];


    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_minImageView.frame)+20+10, CGRectGetMinY(_minImageView.frame)+30, 110, 21)];
    label.text = @"你的个体分数";
    [self.view addSubview:label];

     _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(label.frame), CGRectGetMaxY(label.frame)+15, 110, 40)];
    _scoreLabel.text = @"60.1";
    _scoreLabel.textAlignment = NSTextAlignmentCenter;
    _scoreLabel.font = [UIFont systemFontOfSize:50];

    [self.view addSubview:_scoreLabel];

    UILabel *labelText = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_minImageView.frame)+20+10, CGRectGetMaxY(_scoreLabel.frame)+10, 110, 21)];
    labelText.text = @"分";
    labelText.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelText];

    _labelTip = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(bigImageView.frame)+10, BYSScreenWidth, 21)];
    _labelTip.text = @"建议:别老吃薯片,来点小面包吧";
    _labelTip.textColor = [UIColor grayColor];
    _labelTip.font = [UIFont systemFontOfSize:14];
    _labelTip.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_labelTip];

    UILabel *labelBase = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(bigImageView.frame)-10, CGRectGetMaxY(_labelTip.frame)+10, 180+10, 21)];
    labelBase.text = @"本商品基础分数";
    labelBase.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelBase];

    _triangleView = [[TriangleView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(labelBase.frame)+10, BYSScreenWidth, 15)];
    _triangleView.backgroundColor = [UIColor clearColor];
        [self.view addSubview:self.triangleView];

    UIView *viewGray = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_triangleView.frame), BYSScreenWidth, 60)];
    viewGray.backgroundColor = TableviewColor;
    [self.view addSubview:viewGray];


   _labelBaseText= [[UILabel alloc]initWithFrame:CGRectMake(0,10,BYSScreenWidth, 40)];
    _labelBaseText.text = @"60.1";
    _labelBaseText.textColor = [UIColor grayColor];
    _labelBaseText.textAlignment = NSTextAlignmentCenter;
    _labelBaseText.font = [UIFont systemFontOfSize:45];

    [viewGray addSubview:_labelBaseText];

    UIView *shareView = [[UIView alloc]initWithFrame:CGRectMake(10, BYSScreenHeight-64-10, BYSScreenWidth-10-10, 50)];
    shareView.backgroundColor = [UIColor redColor];

    for (int i = 0; i < self.buttonTitle.count; i++) {
        _shareButton = [[UIButton alloc]init];
        _shareButton.tag = i;
        _shareButton.frame = CGRectMake(i*shareView.frame.size.width/4.0,0,shareView.frame.size.width/4.0, 50);
        [_shareButton setImage:self.buttonImages[i] forState:UIControlStateNormal];
        _shareButton.backgroundColor = [UIColor whiteColor];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize: 13.0];

        [_shareButton setTitle:self.buttonTitle[i] forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_shareButton verticalImageAndTitle:10];
        [_shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_shareButton addTarget:self action:@selector(shareChick:) forControlEvents:UIControlEventTouchUpInside];
        [shareView addSubview:_shareButton];
        
    }

    UILabel *labelshare = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMinY(shareView.frame)-21-15, BYSScreenWidth, 21)];
    labelshare.text = @"好东西,要分享....";
    labelshare.textColor = [UIColor grayColor];
    labelshare.font = [UIFont systemFontOfSize:13];
    labelshare.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:labelshare];

    [self.view addSubview:shareView];


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
