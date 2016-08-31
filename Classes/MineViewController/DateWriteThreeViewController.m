//
//  DateWriteThreeViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/4.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "DateWriteThreeViewController.h"
#import "DateThreeFTableViewCell.h"
#import "DateThreeLTableViewCell.h"

@interface DateWriteThreeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *countArray;
@property (nonatomic, strong)UIView *tableFootView;

@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *changLabel;
@property (nonatomic, strong) UILabel *placeHold;


@end

@implementation DateWriteThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.tableFootView;
}
- (UIView *)tableFootView
{
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 200+60)];
        _tableFootView.backgroundColor = [UIColor whiteColor];
        UIView *grayView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 150)];
        grayView.backgroundColor = TableviewColor;

        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 20, BYSScreenWidth-10-10, 21)];
        titleLabel.text = @"备注 :";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = [UIFont systemFontOfSize:15];


        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(titleLabel.frame)+10, BYSScreenWidth-10-10, 70)];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:16.0];
        _textView.layer.borderColor = RGB(194, 195, 196).CGColor;
        _textView.layer.borderWidth = 0.7;

        _placeHold = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 200, 21)];
        _placeHold.text = @"添加备注";
        _placeHold.textColor = [UIColor grayColor];
        _placeHold.font = [UIFont systemFontOfSize:15];

        _changLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-100-10-5,70-21, 100, 21)];
        _changLabel.text = @"(0/35)";
        _changLabel.textAlignment = NSTextAlignmentRight;
        _changLabel.textColor = [UIColor grayColor];
        _changLabel.font = [UIFont systemFontOfSize:15];

        [_textView addSubview:_placeHold];
        [_textView addSubview:_changLabel];

//        UIButton *shipButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        shipButton.frame = CGRectMake(10,CGRectGetMaxY(grayView.frame)+60,BYSScreenWidth-10-10, 30);
//        [shipButton setTitleColor:NavigationColor forState:UIControlStateNormal];
//        [shipButton setTitle:@"跳过" forState:UIControlStateNormal];
//        shipButton.layer.borderWidth = 1;
//        shipButton.layer.cornerRadius = 5;
//        shipButton.layer.masksToBounds = YES;
//        shipButton.layer.borderColor = NavigationColor.CGColor;
//        [shipButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];

        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(10,CGRectGetMaxY(grayView.frame)+60+10,BYSScreenWidth-10-10, 30);
        sureButton.backgroundColor = NavigationColor;
        [sureButton setTitle:@"提交" forState:UIControlStateNormal];
        sureButton.layer.cornerRadius = 5;
        [sureButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];

        [grayView addSubview:_textView];
        [grayView addSubview:titleLabel];
        [_tableFootView addSubview:grayView];
        [_tableFootView addSubview:sureButton];

    }
    return _tableFootView;
}
- (NSMutableArray *)countArray
{
    if (!_countArray) {
        _countArray =(NSMutableArray *) @[@"1",@"2"];
    }
    return _countArray;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DateThreeFTableViewCell class] forCellReuseIdentifier:@"DateThreeFTableViewCell"];
        [_tableView registerClass:[DateThreeLTableViewCell class] forCellReuseIdentifier:@"DateThreeLTableViewCell"];


    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.countArray.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger index = indexPath.row%2;
    NSInteger indexCount = indexPath.row;


    if (indexCount == self.countArray.count) {
        DateThreeLTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateThreeLTableViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[DateThreeLTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DateThreeLTableViewCell"];
        }
        
        NSString *scoreString = [NSString stringWithFormat:@"%ld",self.countArray.count+1];
        cell.numberLabel.attributedText = [self getAttrbute:scoreString];
        self.tableView.rowHeight = 60;
        return cell;
        
        

    }else
    {
        DateThreeFTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateThreeFTableViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[DateThreeFTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DateThreeFTableViewCell"];
        }
        _tableView.rowHeight = 120;

        NSString *scoreString = self.countArray[index];
        cell.numberLabel.attributedText = [self getAttrbute:scoreString];

            switch (index) {
                case 0:
                    cell.backgroundColor = [UIColor whiteColor];
                    break;
                case 1:
                    cell.backgroundColor = TableviewColor;
                    break;
        
        
                default:
                    break;
            }
        return cell;


    }

}


- (NSMutableAttributedString *)getAttrbute:(NSString *)scoreString
{

    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:scoreString];



    //    NSRange range = [scoreString rangeOfString:@"分"];
    scoreString = [scoreString substringToIndex:1];
    NSInteger scoreInt = [scoreString integerValue];
    NSLog(@"%ld---------%@",scoreInt,scoreString);


    //    [abs addAttribute:NSForegroundColorAttributeName value:[self scoreColor:scoreInt] range:NSMakeRange(0, 2)];

    [abs addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Georgia-italic" size:30] range:NSMakeRange(0, 1)];
    return abs;
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
