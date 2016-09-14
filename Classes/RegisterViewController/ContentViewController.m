//
//  ContentViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/26.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ContentViewController.h"
#import "DateWriteTwoViewController.h"
#import "ContentTableViewCell.h"
#import "BYSHttpParameter.h"
#import "BYSHttpTool.h"
#import "contentModel.h"
#define rowhight 44

@interface ContentViewController ()<UITableViewDelegate,UITableViewDataSource,LZFoldButtonDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *contentArrayM;
@property (nonatomic, strong) NSArray *contentArray;
@property (nonatomic, strong) contentModel *model;
@property (nonatomic, strong) NSArray *cmptArray;



@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"含量";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];

    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(jump:)];

    self.navigationItem.rightBarButtonItem = item;

     NSMutableArray *mutaArray = [NSMutableArray new];
    [BYSHttpTool POST:APP_goods_getCmptNution Parameters:[BYSHttpParameter api_goods_getCmptNution] Success:^(id responseObject) {
        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dic in array) {
            self.model  = [self.model initWithDictionary:dic error:nil];
            [mutaArray addObject:self.model];

            
        }
        self.cmptArray = [mutaArray copy];

        NSLog(@"%@",responseObject);

       
    } Failure:^(NSError *error) {
        
    }];

}
- (contentModel *)model
{
    if (!_model) {
        _model = [contentModel new];
    }
    return _model;
}
- (NSMutableArray *)contentArrayM
{
    if (!_contentArrayM) {
        _contentArrayM = [[NSMutableArray alloc]init];
    }
    return _contentArrayM;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth,BYSScreenHeight-64) style:UITableViewStylePlain];
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
        [sureButton addTarget:self action:@selector(addContent:) forControlEvents:UIControlEventTouchUpInside];
        [footView addSubview:sureButton];

        _tableView.tableFooterView = footView;


        
    }
    return _tableView;
}
- (void)LZFoldButton:(LZFoldButton *)foldButton didSelectObject:(id)obj
{

    self.tableView.rowHeight = 260;
    [self.tableView reloadData];
    [self tableView:self.tableView heightForRowAtIndexPath:0];

}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    UIView* view = [cell.contentView.subviews objectAtIndex:0];
    NSLog(@"cell.frame.size.height=%f",view.frame.size.height);
    return view.frame.size.height;
}
- (void)addContent:(UIButton *)sender
{

    [self.contentArrayM addObject:@"dd"];
    self.contentArray = [self.contentArrayM copy];
    [self.tableView reloadData];


}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.contentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ContentTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[ContentTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ContentTableViewCell"];
    }
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.lifeButton.lzDelegate = self;
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)jump:(id)sender
{
    [self.navigationController pushViewController:[DateWriteTwoViewController new] animated:YES];
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
