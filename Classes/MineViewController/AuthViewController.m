//
//  AuthViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "AuthViewController.h"
#import "MineEndTableViewCell.h"
#import "AutoTableCell.h"
static NSString *AutoCellString = @"autoCellString";
static NSString *AutoCellimageString = @"AutoCellimageString";

@interface AuthViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)NSArray *firstLabelTitleA;
@end


@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"认证";
    self.view.backgroundColor = TableviewColor;
    [self.view addSubview:self.tableView];



}

- (NSArray *)firstLabelTitleA
{
    if (!_firstLabelTitleA) {
        _firstLabelTitleA = @[@"手机号码",@"地址",@"真实头像",@"身份证",@"其他证件"];
    }
    return _firstLabelTitleA;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10, BYSScreenWidth, BYSScreenHeight-74) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[MineEndTableViewCell class] forCellReuseIdentifier:AutoCellString];
         [_tableView registerClass:[AutoTableCell class] forCellReuseIdentifier:AutoCellimageString];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.firstLabelTitleA.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger i = indexPath.row;
    switch (i) {
        case 0:
            return  50;
        case 1:
            return  50;

        case 2:
            return  150;

        case 3:
            return  200;

        case 4:
            return  150;


          default:
            return 0;

          break;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2) {
        AutoTableCell *cell = [tableView dequeueReusableCellWithIdentifier:AutoCellimageString];
        if (!cell) {
            cell = [[AutoTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCellimageString];
        }
        cell.labelCell.text = @"真实头像";

        return cell;

    }else
    {
    MineEndTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AutoCellString];
    if (!cell) {
        cell = [[MineEndTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCellString];
    }
    cell.firstLabel.text = self.firstLabelTitleA[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    }
}


- (void)viewWillAppear:(BOOL)animated{

    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

    //去除导航栏下方的横线

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
