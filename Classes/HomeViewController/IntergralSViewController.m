//
//  IntergralSViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/19.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "IntergralSViewController.h"
#import "UIImageView+WebCache.h"

@interface IntergralSViewController ()
@property (nonatomic, strong)UIView *headView;
@property (nonatomic, strong)UIView *goodsView;
@property (nonatomic, strong)UIImageView *goodsImageView;
@property (nonatomic, strong)UILabel *goodsNameLabel;
@property (nonatomic, strong)UILabel *goods_saleLabel;
@property (nonatomic, strong)UIView *endView;
@property (nonatomic, strong)UITextField *nameTF;
@property (nonatomic, strong)UITextField *addressTF;
@property (nonatomic, strong)UITextField *mobileTF;




@end

@implementation IntergralSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];

    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"积分兑换";
    [self.view addSubview:self.headView];

    [self.view addSubview:self.goodsView];

    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(10,BYSScreenHeight-10-40,BYSScreenWidth-10-10, 40);
    sureButton.backgroundColor = NavigationColor;
    [sureButton setTitle:@"确认发货" forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 5;

    [self.view addSubview:sureButton];

    [self.view addSubview:self.endView];


}


- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0,64, BYSScreenWidth,BYSScreenHeight/3-40)];
        _headView.backgroundColor = [UIColor whiteColor];

        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 20,BYSScreenWidth-10-10, _headView.frame.size.height-20-0.8-20)];
        imageview.backgroundColor = [UIColor clearColor];
//        imageview.contentMode = UIViewContentModeBottom;

        imageview.image = [UIImage imageNamed:@"intergral_successHead"];
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_headView.frame)-0.8, BYSScreenWidth-10-10, 0.8)];
        lineLabel.backgroundColor = RGB(200, 201, 202);



        [_headView addSubview:imageview];
        [_headView addSubview:lineLabel];


    }
    return _headView;
}

- (UIView *)goodsView
{
    if (!_goodsView) {
        _goodsView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(_headView.frame), BYSScreenWidth,15+70+10+10)];
        _goodsView.backgroundColor = [UIColor whiteColor];

        _goodsImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10,100, 70)];
        _goodsImageView.backgroundColor = [UIColor blueColor];
        _goodsImageView.layer.cornerRadius = 15;
        _goodsImageView.layer.masksToBounds = YES;
        //        imageview.contentMode = UIViewContentModeBottom;

        [_goodsImageView sd_setImageWithURL:[NSURL URLWithString:self.image]];


        _goodsNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+20, CGRectGetMinY(_goodsImageView.frame)+10, 100, 10)];
        _goodsNameLabel.text = @"王lao吉";


        NSString *str =  @"消费金额";
        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:16]}];
        UILabel *coutLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_goodsImageView.frame)+20, CGRectGetMaxY(_goodsNameLabel.frame)+30,size.width, 10)];
        coutLabel.font = [UIFont systemFontOfSize:16];
        coutLabel.text = str;


//        NSString *mutostring =  @" 20000";
        NSMutableAttributedString *mutableAttributes = [[NSMutableAttributedString alloc]initWithString:self.count];
        [mutableAttributes addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, self.count.length)];
        NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
        attachment.image = [UIImage imageNamed:@"intergral_shopping"];
        attachment.bounds = CGRectMake(0, 0, 15, 15);
        NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachment];
        [mutableAttributes insertAttributedString:attributedString atIndex:0];


       _goods_saleLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(coutLabel.frame)+20, CGRectGetMinY(coutLabel.frame)-5, 100,size.height)];
        _goods_saleLabel.attributedText = mutableAttributes;


        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_goodsImageView.frame)+10, BYSScreenWidth, 15)];

        lineLabel.backgroundColor = TableviewColor;

        [_goodsView addSubview:_goodsImageView];
        [_goodsView addSubview:_goodsNameLabel];
        [_goodsView addSubview:_goods_saleLabel];
        [_goodsView addSubview:coutLabel];

        [_goodsView addSubview:lineLabel];
        
        
    }
    return _goodsView;
}

- (UIView *)endView
{
    if (!_endView) {
        _endView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.goodsView.frame), BYSScreenWidth, 300)];

        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
        titleLabel.text = @"收货信息";


        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabel.frame)-0.8, BYSScreenWidth-10-10, 0.8)];
        lineLabel.backgroundColor = RGB(200, 201, 202);

        _nameTF = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineLabel.frame)+10, BYSScreenWidth-10-10, 25)];
        _nameTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString: @"请输入收件人姓名" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _nameTF.textAlignment = NSTextAlignmentLeft;

        _nameTF.backgroundColor = TableviewColor;

        _addressTF = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_nameTF.frame)+10, BYSScreenWidth-10-10, 25)];
        _addressTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString: @"请输入详细地址" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _addressTF.backgroundColor = TableviewColor;

        _mobileTF = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_addressTF.frame)+10, BYSScreenWidth-10-10, 25)];
        _mobileTF.placeholder = @"请输入手机号";
        _mobileTF.attributedPlaceholder = [[NSAttributedString alloc]initWithString: @"请输入手机号" attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        _mobileTF.backgroundColor = TableviewColor;

        UILabel *tipLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_mobileTF.frame)+10, BYSScreenWidth-10-10, 20)];
        tipLabel.text = @"tip: 兑换过的积分将不再恢复";
        tipLabel.font = [UIFont systemFontOfSize:12];
        tipLabel.textColor = [UIColor grayColor];


        [_endView addSubview:titleLabel];
        [_endView addSubview:lineLabel];

        [_endView addSubview:_nameTF];
        [_endView addSubview:_mobileTF];
        [_endView addSubview:_addressTF];
        [_endView addSubview:tipLabel];




    }
    return _endView;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];

    _goodsNameLabel.text = self.goodsName;



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
