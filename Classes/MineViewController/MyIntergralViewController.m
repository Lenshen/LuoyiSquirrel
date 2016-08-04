//
//  MyIntergralViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/19.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MyIntergralViewController.h"
#define rowheight 50


@interface MyIntergralViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong)UITableView *tableView;
@property (strong,nonatomic)NSArray *labelArray;
@property (nonatomic, strong)UIView *tableHeadView;
@property (nonatomic, strong)UIButton *settingButton;
@property (nonatomic, strong)UIButton *headImageButton;
@property (nonatomic, strong)UIButton *blackButton;
@property (nonatomic, strong)UIImageView *sexImageView;
@property (nonatomic, strong)UIImageView *tableHeadViewImage;
@property (nonatomic, strong)UILabel *scoreLabel;
@property (nonatomic, strong)UILabel *scoreMinLabel;
@property (nonatomic, strong)UILabel *todayLabel;
@property (nonatomic, strong)UILabel *todayMinLabel;
@property (nonatomic, strong)UILabel *titleLabel;







@end

@implementation MyIntergralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"设置";
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeadView;
    self.tableView.tableFooterView = [UIView new];


}

- (UIView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,BYSScreenWidth, 280)];

        _tableHeadViewImage = [[UIImageView alloc]initWithFrame:_tableHeadView.frame];
                _tableHeadViewImage.image = [UIImage imageNamed:@"myIntergral_headView"];

        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth/2-50, 40, 100, 20)];
        _titleLabel.text = @"我的积分";
        _titleLabel.font = [UIFont fontWithName:@"Helvetica-Bold" size:20];
;
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.backgroundColor =[UIColor clearColor];

        _blackButton = [[UIButton alloc]init];
        _blackButton.frame = CGRectMake(10, 40, 15, 25);

        _blackButton.contentMode = UIViewContentModeScaleAspectFit;
        [_blackButton addTarget:self action:@selector(black:) forControlEvents:UIControlEventTouchUpInside];
        [_blackButton setBackgroundImage:[UIImage imageNamed:@"black_writer"] forState:UIControlStateNormal];
        





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


        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth/2-0.5,CGRectGetMaxY(_headImageButton.frame)+20, 1, 50)];
        lineLabel.backgroundColor = [UIColor whiteColor];

        NSString *str = @"510";

        CGSize size = [str sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:40]}];

        _scoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(lineLabel.frame)-size.width-40,CGRectGetMinY(lineLabel.frame)-10,size.width, size.height)];
        _scoreLabel.text = str;
        _scoreLabel.font = [UIFont systemFontOfSize:40];
        _scoreLabel.textAlignment = NSTextAlignmentLeft;
        _scoreLabel.textColor = [UIColor whiteColor];
        _scoreLabel.backgroundColor =[UIColor clearColor];

        NSString *str1 =@"总分数";

         CGSize size1 = [str1 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]}];
        _scoreMinLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_scoreLabel.frame)-size1.width-5,CGRectGetMaxY(_scoreLabel.frame)+1, size1.width, 20)];
        _scoreMinLabel.text = str1;
        _scoreMinLabel.font = [UIFont systemFontOfSize:13];
        _scoreMinLabel.textAlignment = NSTextAlignmentLeft;
        _scoreMinLabel.textColor = [UIColor whiteColor];
        _scoreMinLabel.backgroundColor =[UIColor clearColor];




        NSString *str3 = @"12";

        CGSize size3 = [str3 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:40]}];

        _todayLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(lineLabel.frame)+40,CGRectGetMinY(lineLabel.frame)-10,size3.width, size3.height)];
        _todayLabel.text = str3;
        _todayLabel.font = [UIFont systemFontOfSize:40];
        _todayLabel.textAlignment = NSTextAlignmentLeft;
        _todayLabel.textColor = [UIColor whiteColor];
        _todayLabel.backgroundColor =[UIColor clearColor];

        NSString *str4 =@"今天获得";

        CGSize size4 = [str4 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11]}];
        _todayMinLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_todayLabel.frame)-size4.width,CGRectGetMaxY(_todayLabel.frame)+1, size4.width, 20)];
        _todayMinLabel.text = str4;
        _todayMinLabel.font = [UIFont systemFontOfSize:11];
        _todayMinLabel.textAlignment = NSTextAlignmentLeft;
        _todayMinLabel.textColor = [UIColor whiteColor];
        _todayMinLabel.backgroundColor =[UIColor clearColor];



        NSString *str5 =@"去签到";

         CGSize size5 = [str4 sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
        UILabel *signLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth/2-size4.width/2,CGRectGetMaxY(_tableHeadView.frame)-30, size5.width, size5.height)];
        signLabel.text = str5;
        signLabel.font = [UIFont systemFontOfSize:15];
        signLabel.textAlignment = NSTextAlignmentLeft;
        signLabel.textColor = [UIColor whiteColor];
        signLabel.backgroundColor =[UIColor clearColor];


        UIButton *signButton = [[UIButton alloc]init];
        signButton.frame = CGRectMake(BYSScreenWidth/2-80, CGRectGetMaxY(signLabel.frame)-35, 160, 50);

        signButton.contentMode = UIViewContentModeScaleAspectFit;
        [signButton addTarget:self action:@selector(signButtonChick:) forControlEvents:UIControlEventTouchUpInside];
        signButton.backgroundColor = [UIColor clearColor];

        UIButton *ruleButton = [[UIButton alloc]init];
        ruleButton.frame = CGRectMake(BYSScreenWidth-10-80, CGRectGetMinY(_titleLabel.frame), 80, 20);

        ruleButton.contentMode = UIViewContentModeScaleAspectFit;
        [ruleButton addTarget:self action:@selector(signButtonChick:) forControlEvents:UIControlEventTouchUpInside];
        ruleButton.backgroundColor = [UIColor clearColor];
        ruleButton.layer.cornerRadius = 10;
        ruleButton.layer.masksToBounds = YES;
        ruleButton.layer.borderColor = [UIColor whiteColor].CGColor;
        ruleButton.layer.borderWidth = 0.8;
        [ruleButton setTitle:@" 积分规则 ？" forState:UIControlStateNormal];
        [ruleButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        ruleButton.titleLabel.font = [UIFont systemFontOfSize:13];





        [_tableHeadView addSubview:_tableHeadViewImage];

        [_tableHeadView addSubview:_settingButton];
        [_tableHeadView addSubview:_headImageButton];
        [_tableHeadView addSubview:_sexImageView];
        [_tableHeadView addSubview:lineLabel];
        [_tableHeadView addSubview:_titleLabel];
        [_tableHeadView addSubview:_blackButton];
        [_tableHeadView addSubview:_scoreLabel];
        [_tableHeadView addSubview:_scoreMinLabel];
        [_tableHeadView addSubview:_todayLabel];
        [_tableHeadView addSubview:_todayMinLabel];
        [_tableHeadView addSubview:signLabel];
        [_tableHeadView addSubview:signButton];
        [_tableHeadView addSubview:ruleButton];











        
    }
    return _tableHeadView;
}
- (void)signButtonChick:(id)sender
{
    NSLog(@"77777");
}
- (void)black:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = @[@"积分兑换",@"分享赚积分",@"上传商品数据",@"设置新成员身体健康指数"];
    }
    return _labelArray;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,0, BYSScreenWidth, BYSScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CustomCell"];
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.labelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowheight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{



        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
        }

        cell.textLabel.text = self.labelArray[indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
        

    
    
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
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
