//
//  ScoreHistoryViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/9/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ScoreHistoryViewController.h"
#import "ScoreHistoryTableViewCell.h"
#define RowHeghit 84

@interface ScoreHistoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;

@end

@implementation ScoreHistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"历史记录";

    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.tableView];
    self.view.backgroundColor = [UIColor blueColor];


}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = RowHeghit;
        [_tableView registerClass:[ScoreHistoryTableViewCell class] forCellReuseIdentifier:@"ScoreHistoryTableViewCell"];
    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ScoreHistoryTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ScoreHistoryTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ScoreHistoryTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ScoreHistoryTableViewCell"];
    }
    cell.leftImageView.image = [UIImage imageNamed:@"test"];
    cell.nick_nameLabel.text = @"dddddd";
    cell.goods_nameLabel.text = @"王老吉";
    cell.rightScoreLabel.text = @"75fen";

    [cell.nick_nameLabel sizeToFit];
    [cell.goods_nameLabel sizeToFit];
    return cell;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

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
