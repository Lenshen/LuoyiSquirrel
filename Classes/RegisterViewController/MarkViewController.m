//
//  MarkViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/15.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MarkViewController.h"
#import "MarkTableViewCell.h"
#import "HXTagsView.h"
#import "FamilyMGViewController.h"
static NSString* markReuseIdentifier = @"markReuseIdentifier";
@interface MarkViewController ()<UITableViewDelegate,UITableViewDataSource,HXTagsViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *markArray;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UIView *tableviewFootView;

@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.tableviewFootView;

    
}
- (UIView *)tableviewFootView
{
    if (!_tableviewFootView) {
        _tableviewFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 65)];
        UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        jumpButton.frame = CGRectMake(10,20, (BYSScreenWidth-10-10-40)/2, 30);
        [jumpButton setTitleColor:NavigationColor forState:UIControlStateNormal];
        [jumpButton setTitle:@"跳过" forState:UIControlStateNormal];
        jumpButton.layer.borderWidth = 1;
        [jumpButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        jumpButton.layer.borderColor = NavigationColor.CGColor;

        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.frame = CGRectMake(CGRectGetMaxX(jumpButton.frame)+40,20, (BYSScreenWidth-10-10-40)/2, 30);
        submitButton.backgroundColor = NavigationColor;
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];

//        submitButton.layer.borderWidth = 1;
//        submitButton.layer.borderColor = NavigationColor.CGColor;

        [_tableviewFootView addSubview:jumpButton];
        [_tableviewFootView addSubview:submitButton];


    }
    return _tableviewFootView;
}
- (void)submit:(UIButton *)sender
{
    [self.navigationController pushViewController:[FamilyMGViewController new] animated:YES];
    if (self.familyBlock) {
        self.familyBlock();


    }
    
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
     _titleArray = @[@"常见慢性病",@"特殊人群",@"食物过敏",@"每日活动量"];
    }
    return _titleArray;
}
- (NSArray *)markArray
{
    if (!_markArray) {
        _markArray = @[@[@"高血压",@"高血脂",@"高血糖",@"胃肠病"],@[@"孕妇",@"哺乳妇女",@"吸烟人群"],@[@"鱼海鲜过敏",@"蛋过敏",@"乳制品过敏",@"食用菌过敏",@"豆制品过敏",@"花生过敏",@"芒果过敏",@"坚果过敏",@"菠萝过敏",@"麦谷类过敏",@"花粉过敏",@"其他过敏"],@[@"轻度活动量（日常办公,上学,偶然锻炼）",@"中度锻炼（走路,考察,野外）",@"大活动量（体力劳动,运动员,军人,消防员）"]];
    }

    return _markArray;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 200;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MarkTableViewCell class] forCellReuseIdentifier:markReuseIdentifier];

    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.markArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:markReuseIdentifier forIndexPath:indexPath];
    if (!cell) {
      cell = [[MarkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:markReuseIdentifier ];
    }
    cell.markArray = self.markArray[indexPath.row];
    cell.title = self.titleArray[indexPath.row];
    [cell.tagsView setTagDelegate:self];
    CGSize size = cell.tagsView.frame.size;
    CGFloat height = size.height+30;
    self.tableView.rowHeight = height;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender {
    NSLog(@"tag:%@ index:%ld",sender.titleLabel.text,(long)sender.tag);
    //
    //    HXWebViewController *vc = [[HXWebViewController alloc] init];
    //    vc.keyWord = sender.titleLabel.text;
    //    [self.navigationController pushViewController:vc animated:NO];

        sender.selected = !sender.selected ;

   








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
