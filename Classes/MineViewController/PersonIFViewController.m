//
//  PersonIFViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "PersonIFViewController.h"
static  NSString *const PersonTableCellReuseIdntifier = @"PersonableviewCell";


@interface PersonIFViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *images;
@property (nonatomic, strong)NSArray *lableArray;
@property (nonatomic, strong)UIView *tableHeadView;
@property (nonatomic, strong)UIButton *settingButton;
@property (nonatomic, strong)UIButton *headImageButton;
@property (nonatomic, strong)UIImageView *sexImageView;
@property (nonatomic, strong)UIImageView *tableHeadViewImage;
@end

@implementation PersonIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"个人信息";
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:PersonTableCellReuseIdntifier];
    self.tableView.rowHeight = 44;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeadView;
//    [self setExtraCellLineHidden:self.tableView];



}

- (UIView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,BYSScreenWidth, 220)];






        _headImageButton = [[UIButton alloc]init];
        _headImageButton.frame = CGRectMake(BYSScreenWidth/2-40, 74, 80, 80);
        _headImageButton.layer.borderWidth = 3.0;
        _headImageButton.layer.borderColor = [UIColor colorWithRed:46/255.0 green:205/255.0 blue:143/255.0 alpha:1.0].CGColor;
        _headImageButton.layer.cornerRadius = 40;
        _headImageButton.layer.masksToBounds = YES;


        _headImageButton.contentMode = UIViewContentModeScaleAspectFit;
        [_headImageButton setBackgroundImage:[UIImage imageNamed:@"headimage"] forState:UIControlStateNormal];

        _sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageButton.frame)-25,CGRectGetMaxY(_headImageButton.frame)-25, 25, 25)];
        _sexImageView.image = [UIImage imageNamed:@"female"];




        [_tableHeadView addSubview:_tableHeadViewImage];

        [_tableHeadView addSubview:_settingButton];
        [_tableHeadView addSubview:_headImageButton];
        [_tableHeadView addSubview:_sexImageView];
        
        
        
        
        
    }
    return _tableHeadView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:PersonTableCellReuseIdntifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonTableCellReuseIdntifier];
    }
    cell.textLabel.text = @"ssss";
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}
- (void)viewWillAppear:(BOOL)animated{

    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];

    //去除导航栏下方的横线

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
