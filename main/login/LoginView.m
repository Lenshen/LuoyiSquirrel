//
//  LoginView.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/2.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "LoginView.h"
#import "UIButton+Vertical.h"

@interface LoginView()
@property (strong,nonatomic)NSArray *buttonTitle;
@property (strong,nonatomic)NSArray *buttonImages;
@property (assign,nonatomic)CGFloat viewWidth;


@end

@implementation LoginView
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.cornerRadius = 10;
        self.layer.masksToBounds = YES;
        self.backgroundColor = [UIColor whiteColor];
        self.viewWidth = frame.size.width;
        [self configUI];


        }
    return self;
}

- (void)configUI
{




    _mobileTF = [[UITextField alloc]initWithFrame:CGRectMake(0, 40,_viewWidth, 30)];
    _mobileTF.placeholder = @"请输入您的手机号码";
    _mobileTF.textAlignment = NSTextAlignmentCenter;

    UILabel *lineLable1 = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_mobileTF.frame)+5, _viewWidth-10-10, 0.7)];
    lineLable1.backgroundColor = RGB(194, 195, 196);


    _codeTF = [[UITextField alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(lineLable1.frame)+20,_viewWidth, 30)];
    NSAttributedString *attributePlace = [[NSAttributedString alloc]initWithString:@"点击获取验证码" attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];
    _codeTF.attributedPlaceholder = attributePlace;
    _codeTF.textAlignment = NSTextAlignmentCenter;
    
    UILabel *lineLable2 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_codeTF.frame)+5, _viewWidth-10-10, 0.7)];
    lineLable2.backgroundColor = RGB(194, 195, 196);


    UIImageView *protocalImageView = [[UIImageView alloc]initWithFrame:CGRectMake(25, CGRectGetMaxY(lineLable2.frame)+30, 20, 20)];
    protocalImageView.image = [UIImage imageNamed:@"protocal_yes"];

    UILabel *protoLabel = [[UILabel alloc]initWithFrame:CGRectMake(40+15,CGRectGetMaxY(lineLable2.frame)+30, _viewWidth, 20)];
    protoLabel.text  = @"我已阅读并同意《松鼠用户协议》";
    protoLabel.textAlignment = NSTextAlignmentLeft;
    protoLabel.font = [UIFont systemFontOfSize:13];
    protoLabel.textColor = RGB(194, 195, 196);



    _openSquirrelButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _openSquirrelButton.frame = CGRectMake(_viewWidth/2-75,CGRectGetMaxY(protoLabel.frame)+20,170, 40);
    _openSquirrelButton.backgroundColor = NavigationColor;
    [_openSquirrelButton setTitle:@"开启松鼠" forState:UIControlStateNormal];
    _openSquirrelButton.layer.cornerRadius = 5;

    UILabel *lineLable3 = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_openSquirrelButton.frame)+20+15, _viewWidth-10-10, 0.7)];
    lineLable3.backgroundColor = RGB(194, 195, 196);


    NSString *str =  @" 其他方式登录  ";
    CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    UILabel *otherLogin = [[UILabel alloc]initWithFrame:CGRectMake(_viewWidth/2-size.width/2, CGRectGetMaxY(_openSquirrelButton.frame)+20, size.width, 30)];
    otherLogin.text  =str;
    otherLogin.textAlignment = NSTextAlignmentCenter;
    otherLogin.textColor = RGB(194, 195, 196);
    otherLogin.font = [UIFont systemFontOfSize:14];
    otherLogin.backgroundColor = [UIColor whiteColor];




    for (int i = 0; i < self.buttonTitle.count; i++) {
        _shareButton = [[UIButton alloc]init];
        _shareButton.tag = i;
        _shareButton.frame = CGRectMake(i*self.frame.size.width/self.buttonTitle.count,CGRectGetMaxY(otherLogin.frame)+20,self.frame.size.width/self.buttonTitle.count, 50);
        [_shareButton setImage:self.buttonImages[i] forState:UIControlStateNormal];
        _shareButton.backgroundColor = [UIColor whiteColor];
        _shareButton.titleLabel.font = [UIFont systemFontOfSize: 13.0];

        [_shareButton setTitle:self.buttonTitle[i] forState:UIControlStateNormal];
        [_shareButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_shareButton verticalImageAndTitle:10];
        [_shareButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];

        [self addSubview:_shareButton];

    }




    [self addSubview:lineLable1];
    [self addSubview:lineLable2];
    [self addSubview:lineLable3];
    [self addSubview:_mobileTF];
    [self addSubview:_codeTF];
    [self addSubview:_openSquirrelButton];
    [self addSubview:protocalImageView];

    [self addSubview:otherLogin];
    [self addSubview:protoLabel];
//    [self addSubview:lineLable1];
//    [self addSubview:lineLable1];










    

}

-(NSArray *)buttonTitle{

    if (!_buttonTitle) {
        _buttonTitle = @[@"微信登录",@"QQ登录",@"微博登录"];
    }
    return _buttonTitle;
}
-(NSArray *)buttonImages{

    if (!_buttonImages) {
        _buttonImages = @[[UIImage imageNamed:@"wei_xin"],
                          [UIImage imageNamed:@"qq"],
                          [UIImage imageNamed:@"wei_bo"]


                          ];
    }
    return _buttonImages;
}

@end
