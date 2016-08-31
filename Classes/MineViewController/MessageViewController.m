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
#import "BYSHttpParameter.h"
#import "BYSHttpTool.h"
#import "MessageModel.h"

typedef  NS_ENUM(NSInteger , MessageType)
{
    systemMessageType,
    externalMessageType,
};

@interface MessageViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic) MessageType messageType;
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)MessageModel *model;
@property (nonatomic, strong)NSArray *messageArray;

@property (nonatomic, strong)NSMutableArray *mutoArray;


@property (nonatomic)BOOL has_image;


@property (nonatomic, copy)NSString *urlSting;
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
    NSMutableArray *mutoArray = [[NSMutableArray alloc]init];
    [BYSHttpTool POST:APP_home_getMessage Parameters:[BYSHttpParameter get_home_getMessage  ] Success:^(id responseObject) {

        NSArray *array = responseObject[@"data"];
        NSLog(@"%@---------%@",responseObject,array);
        for (NSDictionary *dic in array) {

            self.model = [[MessageModel alloc]initWithDictionary:dic error:nil];
            [mutoArray addObject:self.model];


        }
        self.messageArray = [mutoArray copy];
        [self.tableView reloadData];




    } Failure:^(NSError *error) {
        
    }];


}
- (NSMutableArray *)mutoArray
{
    if (!_mutoArray) {
        _mutoArray = [NSMutableArray new];
    }
    return _mutoArray;
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
        _tableView.backgroundColor = TableviewColor;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MessageTableViewCell class] forCellReuseIdentifier:@"MessageTableViewCell"];

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.messageArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MessageTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MessageTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[MessageTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MessageTableViewCell"];

    }
    self.model = self.messageArray[indexPath.row];
    self.has_image = self.model.has_image;


    if (!_has_image) {
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
    cell.titleLable.text = self.model.type;
    cell.messageLabel.text = self.model.text;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = TableviewColor;
    self.urlSting = self.model.url;
    
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
