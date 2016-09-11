//
//  ProduceViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/9/11.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ProduceViewController.h"
#import "DateThreeLTableViewCell.h"
#import "ProduceTableViewCell.h"
#import "ProduceTwoTableViewCell.h"
#import "DateWriteThreeViewController.h"

@interface ProduceViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSMutableArray *countArray;



@end

@implementation ProduceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(push:)];
    self.navigationItem.rightBarButtonItem = item;

}
- (void)push:(UIButton *)sender
{
    [self.navigationController pushViewController:[DateWriteThreeViewController new] animated:YES];

}
 - (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[DateThreeLTableViewCell class] forCellReuseIdentifier:@"DateThreeLTableViewCell"];
        [_tableView registerClass:[ProduceTableViewCell class] forCellReuseIdentifier:@"ProduceTableViewCell"];
        [_tableView registerClass:[ProduceTwoTableViewCell class] forCellReuseIdentifier:@"ProduceTwoTableViewCell"];



    }
    return _tableView;
}

- (NSMutableArray *)countArray
{
    if (!_countArray)
    {
        _countArray = [NSMutableArray new];
        [_countArray addObject:@"1"];
        [_countArray addObject:@"2"];
        [_countArray addObject:@"3"];

    }
    return _countArray;
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
        cell.nameLabel.text = @"添加一个生产商";
        self.tableView.rowHeight = 60;

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


        
    }else if (indexCount == 0) {

        ProduceTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProduceTableViewCell" forIndexPath:indexPath];
        self.tableView.rowHeight = 140;

        if (!cell) {
            cell = [[ProduceTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProduceTableViewCell"];
        }

        //        NSString *scoreString = [NSString stringWithFormat:@"%ld",self.countArray.count+1];
        //        cell.numberLabel.attributedText = [self getAttrbute:scoreString];
        //        cell.nameLabel.text = @"添加一个生产商";
        
        return cell;
    }else
    {
        ProduceTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProduceTwoTableViewCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[ProduceTwoTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ProduceTwoTableViewCell"];
        }
        self.tableView.rowHeight = 160;

        NSString *scoreString = self.countArray[indexPath.row];
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
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.countArray.count) {
        NSString *str =[NSString stringWithFormat:@"%ld",(self.countArray.count+1)];
        [self.countArray addObject:str];
        [self.tableView reloadData];
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
