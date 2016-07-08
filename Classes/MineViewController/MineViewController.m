//
//  MineViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/6.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MineViewController.h"
#import "SettingViewController.h"
#import "MineTableviewCell.h"
#import "PersonIFViewController.h"

#define rowheight 44
static  NSString *const mineTableCellReuseIdntifier = @"MineTableviewCell";

@interface MineViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *images;
@property (nonatomic, strong)NSArray *lableArray;
@property (nonatomic, strong)UIView *tableHeadView;
@property (nonatomic, strong)UIButton *settingButton;
@property (nonatomic, strong)UIButton *headImageButton;
@property (nonatomic, strong)UIImageView *sexImageView;
@property (nonatomic, strong)UIImageView *tableHeadViewImage;



@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.tableView registerClass:[MineTableviewCell class] forCellReuseIdentifier:mineTableCellReuseIdntifier];
    self.tableView.rowHeight = 44;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeadView;
    [self setExtraCellLineHidden:self.tableView];




}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
}

- (NSArray *)lableArray
{
    if (!_lableArray) {
        _lableArray = @[@"个人信息",@"家庭管理(亲友)",@"数据录入",@"我的积分",@"我的消息",@"账户认证"];
    }
    return _lableArray;
}
- (NSArray *)images
{
    if (!_images) {
        _images = @[[UIImage imageNamed:@"mine_tablecell_IF"],[UIImage imageNamed:@"mine_tablecell_fraimy"],[UIImage imageNamed:@"mine_tablecell_date"],[UIImage imageNamed:@"mine_tablecell_integral"],[UIImage imageNamed:@"mine_tablecell_IF-message"],[UIImage imageNamed:@"mine_tablecell_click"]];
    }
    return _images;
}

- (UIView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,BYSScreenWidth, 220)];

        _tableHeadViewImage = [[UIImageView alloc]initWithFrame:_tableHeadView.frame];
        _tableHeadViewImage.image = [UIImage imageNamed:@"tableheadimage"];

        _settingButton = [[UIButton alloc]init];
        _settingButton.frame = CGRectMake(BYSScreenWidth-10-25, 40, 25, 25);

        _settingButton.contentMode = UIViewContentModeScaleAspectFit;
        [_settingButton addTarget:self action:@selector(settingChick:) forControlEvents:UIControlEventTouchUpInside];
        [_settingButton setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];


        _headImageButton = [[UIButton alloc]init];
        _headImageButton.frame = CGRectMake(BYSScreenWidth/2-40, 74, 80, 80);
        _headImageButton.layer.borderWidth = 3.0;
        _headImageButton.layer.borderColor = [UIColor colorWithRed:46/255.0 green:205/255.0 blue:143/255.0 alpha:1.0].CGColor;
        _headImageButton.layer.cornerRadius = 40;
        _headImageButton.layer.masksToBounds = YES;
        [_headImageButton addTarget:self action:@selector(personIFChick:) forControlEvents:UIControlEventTouchUpInside];
        

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



#pragma mark settingchick

- (void)settingChick:(UIButton *)sender
{
    [self.navigationController pushViewController:[SettingViewController new] animated:YES];


}
- (void)personIFChick:(id)sender
{
    PersonIFViewController *person = [PersonIFViewController new];
    person.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:person animated:YES];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return self.images.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MineTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:mineTableCellReuseIdntifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MineTableviewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mineTableCellReuseIdntifier];



    }
    cell.imageViewCell.image = self.images[indexPath.row];
    cell.imageViewCell.contentMode = UIViewContentModeScaleAspectFit;
    cell.labelCell.text = self.lableArray[indexPath.row];
    cell.labelCell.font = [UIFont systemFontOfSize:18.0];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;

}

-(void)setExtraCellLineHidden: (UITableView *)tableView
{
    UIView *view = [UIView new];
    view.backgroundColor = TableviewColor;
    [tableView setTableFooterView:view];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
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
