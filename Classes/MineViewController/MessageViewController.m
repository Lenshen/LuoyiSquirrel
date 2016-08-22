//
//  MessageViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/17.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MessageViewController.h"
#import "MessageTableViewCell.h"
#import "MessageDetailViewController.h"

typedef  NS_ENUM(NSInteger , MessageType)
{
    systemMessageType,
    externalMessageType,
};

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) MessageType messageType;
@property (nonatomic, strong)UITableView *tableView;




@property (nonatomic, strong)UIImageView *cellImageView;

@end

@implementation MessageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"消息"  ;
    self.view.backgroundColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 120;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"MessageTableViewCell"];

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageTableViewCell"];

    }

    if (indexPath.row%2==0) {
        cell.leftImageView.image = [UIImage imageNamed:@"system_message"];
        _tableView.rowHeight = 120;

    }else
    {
        cell.leftImageView.image = [UIImage imageNamed:@"extrnal_message"];
        CGRect rect = cell.contendView.frame;
        _cellImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(cell.messageLabel.frame)+10,rect.size.width-10-10, 100)];
        _cellImageView.image = [UIImage imageNamed:@"test"];


        rect.size = CGSizeMake(BYSScreenWidth-10-10, 200);
        cell.contendView.frame = rect;
        [cell.contendView addSubview:_cellImageView];
        _tableView.rowHeight = 120+120;

    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = TableviewColor;
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.navigationController pushViewController:[MessageDetailViewController new] animated:YES];
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
