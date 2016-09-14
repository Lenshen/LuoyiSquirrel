//
//  LoginViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/1.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "LoginViewController.h"
#import "SDCycleScrollView.h"
#import "LBTabBarController.h"
#import "LoginView.h"
#import "AppDelegate.h"
#import "BYSHttpTool.h"
#import "BYSHttpParameter.h"
#import "BYSAlertView.h"


@interface LoginViewController ()<SDCycleScrollViewDelegate,UIScrollViewDelegate,UITextFieldDelegate>
@property (strong,nonatomic)SDCycleScrollView *cycleScrollView;
@property (strong,nonatomic)NSArray *netImages;
@property (strong,nonatomic)LoginView *loginView;
@property (strong,nonatomic)UIButton *openSquirrelButton1;
@property (strong,nonatomic)UIButton *closeSquirrelButton;
@property (strong,nonatomic)UIVisualEffectView *effectview;

@property (strong,nonatomic)UITextField *tureTextField;
@property (strong,nonatomic)UITextField *codeTextField;

@property (nonatomic,strong) BYSAlertView *alertView;




@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.cycleScrollView];

    _openSquirrelButton1 = [UIButton buttonWithType:UIButtonTypeCustom];
    _openSquirrelButton1.frame = CGRectMake(self.view.center.x-75,BYSScreenHeight-130-40,170, 40);
    _openSquirrelButton1.backgroundColor = NavigationColor;
    [_openSquirrelButton1 setTitle:@"开启松鼠" forState:UIControlStateNormal];
    _openSquirrelButton1.layer.cornerRadius = 5;
    [_openSquirrelButton1 addTarget:self action:@selector(openSquirrel:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_openSquirrelButton1];


    self.loginView.alpha = 0.8;

    [self.view addSubview:self.loginView];
    self.loginView.mobileTF.keyboardType = UIKeyboardTypePhonePad;
    self.loginView.mobileTF.tag = 0;
    self.loginView.mobileTF.delegate = self;
    [self.loginView.mobileTF addTarget:self action:@selector(limitMobile:) forControlEvents:UIControlEventEditingChanged];

    self.loginView.codeTF.keyboardType = UIKeyboardTypePhonePad;
    self.loginView.codeTF.tag = 1;
    self.loginView.codeTF.delegate = self;
    [self.loginView.codeTF addTarget:self action:@selector(limitMobile:) forControlEvents:UIControlEventEditingChanged];




    

}
- (LoginView *)loginView
{
    if (!_loginView) {
        _loginView = [[LoginView alloc]initWithFrame:CGRectMake(30, -500, BYSScreenWidth-30*2, 390)];
        [_loginView.openSquirrelButton addTarget:self action:@selector(goTabbar:) forControlEvents:UIControlEventTouchUpInside];

    }
    return _loginView;
}
- (void)goTabbar:(UIButton *)sender
{
    
    LBTabBarController *tabbarVc = [[LBTabBarController alloc]init];
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.window.rootViewController = tabbarVc;

    [BYSHttpTool GET:APP_member_getToken Parameters:[BYSHttpParameter get_APP_member_getToken:_codeTextField.text] Success:^(id responseObject) {

        NSLog(@"%@",responseObject);
        [USER_DEFAULT setObject:responseObject[@"data"] forKey:@"token"];



    } Failure:^(NSError *error) {

        NSLog(@"%@",error);
        
    }];


}
- (void)openSquirrel:(UIButton *)sender
{
    sender.hidden = YES;
    _cycleScrollView.showPageControl = NO;

    UIBlurEffect *blur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    _effectview = [[UIVisualEffectView alloc]initWithEffect:blur];
    _effectview.frame = self.view.frame;
    _effectview.alpha = 0;


    [self.cycleScrollView.cell.imageView addSubview:_effectview];
    _cycleScrollView.userInteractionEnabled = NO;
    _cycleScrollView.pageHight = 100;
    _closeSquirrelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _closeSquirrelButton.frame = CGRectMake(BYSScreenWidth-10-25,20+10,20, 20);
    [_closeSquirrelButton setBackgroundImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];

    [_closeSquirrelButton addTarget:self action:@selector(closeSquirrel:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_closeSquirrelButton];


    [UIView animateWithDuration:1 animations:^{
        self.loginView.frame = CGRectMake(30, 80,BYSScreenWidth-30*2, 400);
        _effectview.alpha = 1;

     }];


}
- (void)closeSquirrel:(UIButton *)sender
{
    _openSquirrelButton1.hidden = NO;
    _cycleScrollView.showPageControl = YES;
    _cycleScrollView.userInteractionEnabled = YES;
    _closeSquirrelButton.hidden = YES;
    [self.loginView.codeTF resignFirstResponder];
    [self.loginView.mobileTF resignFirstResponder];
    [UIView animateWithDuration:1 animations:^{
        CGRect rect = self.loginView.frame;
        rect.origin.y = -500;
        self.loginView.frame = rect;
        _effectview.alpha = 0;

        
    }];



}

- (SDCycleScrollView *)cycleScrollView
{
    if (!_cycleScrollView) {
        _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BYSScreenWidth, BYSScreenHeight) delegate:self placeholderImage:nil];
        _cycleScrollView.showPageControl = YES;

        _cycleScrollView.imageURLStringsGroup = self.netImages;
//        _cycleScrollView.autoScrollTimeInterval = 2.0;
        _cycleScrollView.autoScroll = NO;
        _cycleScrollView.infiniteLoop = NO;
    

        _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;

        _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
        _cycleScrollView.currentPageDotColor = [UIColor colorWithRed:59/225.0 green:225/225.0 blue:158/255.0 alpha:1];
        _cycleScrollView.pageDotColor = [UIColor whiteColor];


    }
    return _cycleScrollView;

}
-(NSArray *)netImages{

    if (!_netImages) {
        _netImages =  @[
                        @"http://d.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40f507b2e99aa64034f78f01930.jpg",
                        @"http://b.hiphotos.baidu.com/zhidao/pic/item/4b90f603738da9770889666fb151f8198718e3d4.jpg",
                        @"http://g.hiphotos.baidu.com/zhidao/pic/item/f2deb48f8c5494ee4e84ef5d2cf5e0fe98257ed4.jpg",
                        @"http://d.hiphotos.baidu.com/zhidao/pic/item/9922720e0cf3d7ca104edf32f31fbe096b63a93e.jpg"
                        ];
    }
    return _netImages;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{

    _codeTextField.userInteractionEnabled = YES;



    if (textField.tag == 0 ) {


        [textField becomeFirstResponder];
            _tureTextField = [[UITextField alloc]init];
            _tureTextField = textField;
        _tureTextField.userInteractionEnabled = YES;


        [UIView animateWithDuration:0.3 animations:^{
            self.loginView.frame = CGRectMake(30, 80,BYSScreenWidth-30*2,400-150);
            
            
        }];

    }

    if (textField.tag == 1 ) {

        self.codeTextField = textField;
//        textField.enabled = NO;
//        [textField resignFirstResponder];

        if (_tureTextField.text.length != 0) {
            textField.userInteractionEnabled = YES;

            textField.enabled = YES;
            [textField becomeFirstResponder];
            CGRect rect = self.loginView.codeTF.frame;
            rect.size.width = self.loginView.frame.size.width/2;
            rect.origin.x = 30;
            self.loginView.codeTF.frame = rect;
            self.loginView.codeTF.placeholder = @"请输入验证码";
            self.loginView.codeTF.textColor = [UIColor grayColor];
            self.loginView.codeTF.font = [UIFont systemFontOfSize:15];
            self.loginView.codeTF.textAlignment = NSTextAlignmentCenter;

            [BYSHttpTool GET:APP_member_send Parameters:[BYSHttpParameter get_APP_member_send] Success:^(id responseObject) {

                NSLog(@"%@",responseObject);

                NSString *str = [NSString stringWithFormat:@"您的验证码是:%@", responseObject[@"data"]];

                [self setAlertUI:str];



            } Failure:^(NSError *error) {

                NSLog(@"%@",error);

            }];



            
            
            
            
        }else
        {
            


            [_codeTextField resignFirstResponder] ;
            NSLog(@"55555555");


        }

    }

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
- (void)limitMobile:(UITextField *)textField
{



    if (textField.tag == 0 && textField.text.length >= 11) {

        [self.loginView.mobileTF resignFirstResponder];



    }


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
