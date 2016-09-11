//
//  SearchTwoViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/25.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "SearchTwoViewController.h"
#import "HistoryLabel.h"
#import "SearchBar.h"
#import "NoGoodsView.h"

@interface SearchTwoViewController ()<historyLableDelegeate,UITextFieldDelegate>
@property (nonatomic, strong)SearchBar *searchBarView;
@property (nonatomic, strong)UITextField *textfield;
@property (nonatomic, strong)UIView *putdownView;

@property (nonatomic, strong)UILabel *lineLabel;
@property (nonatomic, strong)UIButton *materialbutton;
@property (nonatomic, strong)UIButton *goodsButton;
@property (nonatomic, strong)UIButton *contentGoodsButton;


@property (strong, nonatomic) HistoryLabel *history;
@property (strong, nonatomic) NoGoodsView *noGoodsView;

@property (strong,nonatomic) NSMutableArray *searTXT;
@property (nonatomic,strong)UIButton *clearButton;


@property (nonatomic, strong)UITableView *tableView;







@property (nonatomic) BOOL isOpen;

@end

@implementation SearchTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];

    _isOpen = NO;

}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight-64)];

    }
    return _tableView;
}
- (NoGoodsView *)noGoodsView
{
    if (!_noGoodsView) {
        _noGoodsView = [[NoGoodsView alloc]initWithFrame:CGRectMake(0,64, BYSScreenWidth, BYSScreenHeight-64)];
    }
    return _noGoodsView;
}
- (UIView *)searchBarView
{
    if (!_searchBarView) {
        _searchBarView = [[SearchBar alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 64)]
        ;
        _searchBarView.textfield.delegate = self;



//-----------------左侧button------------

        _contentGoodsButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _contentGoodsButton.frame = CGRectMake(15, 25, 45, 32);
        _contentGoodsButton.backgroundColor = TableviewColor;
        [_contentGoodsButton setTitle:@"商品1" forState:UIControlStateNormal];
        _contentGoodsButton.tag = 1;
        [_contentGoodsButton addTarget:self action:@selector(chickTap:) forControlEvents:UIControlEventTouchUpInside];
        //        _contentGoodsLabel.textAlignment = NSTextAlignmentCenter;
        //        _contentGoodsLabel.font = [UIFont systemFontOfSize:14];



        _materialbutton =[UIButton buttonWithType:UIButtonTypeSystem];
        _materialbutton.frame = CGRectMake(15,CGRectGetMaxY(_contentGoodsButton.frame), 45, 32);
        [_materialbutton setTitle:@"原料" forState:UIControlStateNormal];
        _materialbutton.layer.borderWidth = 0.5;
        _materialbutton.layer.borderColor = TableviewColor.CGColor;
        _materialbutton.backgroundColor = RGB(254, 255, 255);
        //        _materialLabel.textAlignment = NSTextAlignmentCenter;
        //        _materialLabel.font = [UIFont systemFontOfSize:14];
        _materialbutton.alpha = 0;
        _materialbutton.tag = 2;
        [_materialbutton addTarget:self action:@selector(chickTap:) forControlEvents:UIControlEventTouchUpInside];




        _goodsButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _goodsButton.frame = CGRectMake(15,CGRectGetMaxY(_materialbutton.frame), 45, 32);
        [_goodsButton setTitle:@"商品2" forState:UIControlStateNormal];
        _goodsButton.layer.borderWidth = 0.5;
        _goodsButton.layer.borderColor = TableviewColor.CGColor;
        _goodsButton.backgroundColor = RGB(254, 255, 255);
        _goodsButton.tag = 3;
        [_goodsButton addTarget:self action:@selector(chickTap:) forControlEvents:UIControlEventTouchUpInside];
        



        //        _goodsLabel.font = [UIFont systemFontOfSize:14];
        _goodsButton.alpha = 0;
        


//-----------------左侧button------------

        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];

        cancelButton.frame = CGRectMake(BYSScreenWidth-40-10, 25, 40, 32);

        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(dissmiss:) forControlEvents:UIControlEventTouchUpInside];


        [_searchBarView addSubview:cancelButton];








    }
    return _searchBarView;
}
- (void)dissmiss:(UIButton *)sender
{
    
    [self.navigationController popViewControllerAnimated:YES];
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
    [self.view addSubview:self.searchBarView];
    [self setupHistoryView];

    [self.view addSubview:_goodsButton];
    [self.view addSubview:_contentGoodsButton];
    [self.view addSubview:_materialbutton];





}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;

}

- (void) setupHistoryView
{
    if (!_history) {
        UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, 32)];
        UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(29, 12, 20, 20)];
        imageview.image = [UIImage imageNamed:@"lishi"];
        UILabel *textlabel = [[UILabel alloc]initWithFrame:CGRectMake(57, 11, 108, 21)];
        textlabel.textAlignment = NSTextAlignmentLeft;
        textlabel.text= @"历史记录";
        textlabel.textColor = [UIColor grayColor];


        [headView addSubview:imageview];
        [headView addSubview:textlabel];
        [self.view addSubview:headView];
        _history = [[HistoryLabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(headView.frame)+10, BYSScreenWidth,0)];

        _history.historyDelegate = self;


        NSArray *myArray = [USER_DEFAULT arrayForKey:@"myArray"];
        _searTXT = [myArray mutableCopy];
        NSLog(@"%@",_searTXT);

        _searTXT = @[@"日本薯条",@"意大利面",@"小松鼠蓉"];

        _history.historyBackgroundColor = [UIColor colorWithRed:239/255.0 green:238/255.0 blue:244/255.0 alpha:1];
        _history.historySignalColor = [UIColor colorWithRed:202/255.0 green:202/255.0 blue:202/255.0 alpha:1];
        [_history setArrayTagWithLabelArray:_searTXT];

        [self.view addSubview:_history];
        self.clearButton = nil;

        if (!self.clearButton) {
            self.clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
            self.clearButton.frame = CGRectMake(BYSScreenWidth/2.0 - 75 ,_history.frame.origin.y+_history.frame.size.height+40, 150, 30);
            [self.clearButton.layer setBorderWidth:0.5];

            self.clearButton.titleLabel.font = [UIFont boldSystemFontOfSize:15.0f];
            [self.clearButton addTarget:self action:@selector(clearHistory:) forControlEvents:UIControlEventTouchUpInside];
            [self.clearButton setTitle:@"清除历史纪录" forState:UIControlStateNormal];
            [self.clearButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
            [self.view addSubview:self.clearButton];

        }


    }else
    {

        NSArray *myArray = [USER_DEFAULT arrayForKey:@"myArray"];
        self.searTXT = [myArray mutableCopy];
        NSLog(@"%@",_searTXT);
        [_history setArrayTagWithLabelArray:_searTXT];
        
    }



    
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{

    
    [self.view addSubview:self.tableView];
    [self.noGoodsView removeFromSuperview];
    self.noGoodsView = nil;


}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    [self.view addSubview:self.noGoodsView];
    [self.tableView removeFromSuperview];
    self.tableView = nil;

    return YES;
}


//-----------------左侧button点击------------






- (void)chickTap:(UIButton *)sender
{
    if (sender.tag == 1) {
        if (!_isOpen) {

            [UIView animateWithDuration:0.3 animations:^{
                self.materialbutton.alpha = 1;
                self.goodsButton.alpha = 1;






            }];
            _isOpen = YES;
        }else
        {
            [UIView animateWithDuration:0.3 animations:^{
                self.materialbutton.alpha = 0;
                self.goodsButton.alpha = 0;



            }];
            _isOpen = NO;

        }

    }

    if (sender.tag == 2) {
        [self.contentGoodsButton setTitle:@"原料" forState:UIControlStateNormal];
        self.materialbutton.alpha = 0;
        self.goodsButton.alpha = 0;
        _isOpen = NO;

    }


    if (sender.tag == 3) {
        [self.contentGoodsButton setTitle:@"商品2" forState:UIControlStateNormal];
        self.materialbutton.alpha = 0;
        self.goodsButton.alpha = 0;
        _isOpen = NO;
        
    }
    
}

//-----------------左侧button点击------------


@end
