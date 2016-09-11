//
//  DateWriteTwoViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/3.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "DateWriteTwoViewController.h"
#import "HistoryLabel.h"
#import "DateWriteThreeViewController.h"
#import "ProduceViewController.h"
#define DateOnebigFont [UIFont systemFontOfSize:15]

#define DateOneFont [UIFont systemFontOfSize:13]

@interface DateWriteTwoViewController ()<UITextViewDelegate>
@property (nonatomic, strong)HistoryLabel *dosingNameView;
@property (nonatomic, strong)UITextField *dodinTF;
@property (nonatomic, strong)UIButton *addButton;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *changLabel;
@property (nonatomic, strong) UILabel *placeHold;


@end

@implementation DateWriteTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"配料";

    [self configUI];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(push:)];
    self.navigationItem.rightBarButtonItem = item;

    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(10,BYSScreenHeight-30-10,BYSScreenWidth-10-10, 30);
    sureButton.backgroundColor = NavigationColor;
    [sureButton setTitle:@"下一步" forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 5;
    [sureButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];


    

    
}
- (void)push:(UIButton *)sender
{
    [self.navigationController pushViewController:[ProduceViewController new] animated:YES];

}
- (void)configUI
{
    self.dosingNameView = [[HistoryLabel alloc]initWithFrame:CGRectMake(0, 30, BYSScreenWidth, 0)];
    [self.dosingNameView setArrayTagWithLabelArray:@[@"ssss",@"ssssddd"]];
    [self.view addSubview:self.dosingNameView];

    _dodinTF = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.dosingNameView.frame)+10, 140, 30)];
    _dodinTF.textAlignment = NSTextAlignmentCenter;
    _dodinTF.placeholder = @"请输入配料名称";
    _dodinTF.backgroundColor = TableviewColor;
    _dodinTF.layer.cornerRadius = 5;
    _dodinTF.layer.masksToBounds = YES;

    _addButton  = [UIButton buttonWithType:UIButtonTypeCustom];
    _addButton.frame = CGRectMake(CGRectGetMaxX(_dodinTF.frame)+10, CGRectGetMaxY(self.dosingNameView.frame)+10, 30, 30) ;
    _addButton.backgroundColor = TableviewColor;
    _addButton.layer.cornerRadius = 5;
    _addButton.layer.masksToBounds = YES;
    [_addButton setImage:[UIImage imageNamed:@"add"] forState:UIControlStateNormal];

    UILabel *lineLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(_addButton.frame)+20, BYSScreenWidth-10-10, 1)];
    lineLable.backgroundColor = TableviewColor;


    UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineLable.frame)+20, BYSScreenWidth-10-10, 21)];
    titleLabel.text = @"致敏提示";
    titleLabel.textAlignment = NSTextAlignmentLeft;


    _textView = [[UITextView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(titleLabel.frame)+10, BYSScreenWidth-10-10, 70)];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:16.0];
    _textView.layer.borderColor = RGB(194, 195, 196).CGColor;
    _textView.layer.borderWidth = 0.7;

    _placeHold = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 200, 21)];
    _placeHold.text = @"请输入提示....";
    _placeHold.textColor = [UIColor grayColor];
    _placeHold.font = DateOneFont;

    _changLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-100-10-5,70-21, 100, 21)];
    _changLabel.text = @"(0/35)";
    _changLabel.textAlignment = NSTextAlignmentRight;
    _changLabel.textColor = [UIColor grayColor];
    _changLabel.font = DateOneFont;

    [_textView addSubview:_placeHold];
    [_textView addSubview:_changLabel];


    [self.view addSubview:_dodinTF];
    [self.view addSubview:_addButton];
    [self.view addSubview:lineLable];
    [self.view addSubview:titleLabel];
    [self.view addSubview:_textView];

    

}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
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
