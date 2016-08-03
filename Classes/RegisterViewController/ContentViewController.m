//
//  ContentViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/26.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ContentViewController.h"
#import "ContentTableViewCell.h"
#define rowhight 50

@interface ContentViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"含量";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];

}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth,rowhight*5+60) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = rowhight;
        [_tableView registerClass:[ContentTableViewCell class] forCellReuseIdentifier:@"ContentTableViewCell"];

        UIView *footView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 60)];

        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(10,10,BYSScreenWidth-10-10, 40);
        sureButton.backgroundColor = NavigationColor;
        [sureButton setTitle:@"添加一个含量" forState:UIControlStateNormal];
        sureButton.layer.cornerRadius = 5;
        [footView addSubview:sureButton];

        _tableView.tableFooterView = footView;


        
    }
    return _tableView;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentTableViewCell"];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
