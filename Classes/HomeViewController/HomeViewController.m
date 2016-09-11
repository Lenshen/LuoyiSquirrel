//
//  HomeViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/6.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "HomeViewController.h"
#import "SDCycleScrollView.h"
#import "VerticalButton.h"
#import "UIButton+Vertical.h"
#import "SignInViewController.h"
#import "homeTableviewCell.h"
#import "InviteViewController.h"
#import "IntergralViewController.h"
#import "IntergralShoppingViewController.h"
#import "HRAdView.h"
#import "PersonIFViewController.h"
#import "MyIntergralViewController.h"
#import "BYSHttpTool.h"
#import "BYSHttpParameter.h"
#import "AdvertModel.h"
#import "AdvertViewController.h"


@interface HomeViewController ()<SDCycleScrollViewDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *tableView;
@property (nonatomic, strong)UIView *tableViewHeadView;
@property (nonatomic, strong)UIView *homeIFView;

@property (strong,nonatomic)NSArray *netImages;
@property (strong,nonatomic)NSArray *urls;

@property (strong,nonatomic)NSArray *buttonImages;
@property (strong,nonatomic)NSArray *buttonTitle;
@property (strong,nonatomic)UILabel *timeLabel;
@property (strong,nonatomic)UILabel *dayLabel;
@property (strong,nonatomic)UIButton *headButton;
@property (strong,nonatomic)AdvertModel *model;
@property (strong,nonatomic) BYSHttpTool *tool;


@property (strong,nonatomic)SDCycleScrollView *cycleScrollView;

@end

@implementation HomeViewController
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;


}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    if (![USER_DEFAULT boolForKey:@"hasSubmit"]) {

        [self showAlert];
        [USER_DEFAULT setBool:YES forKey:@"hasSubmit"];


    }
    _tool  = [BYSHttpTool new];
    [_tool reachability:self];
    [_tool.alertView.rightButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];





}
- (void)dismiss:(id)sender
{

    _tool.alertView.alphaView.hidden = YES;
    [_tool.alertView.alphaView removeFromSuperview];
    _tool.alertView.alphaView = nil;
    _tool.alertView.hidden = YES;
    [_tool.alertView removeFromSuperview];
    _tool.alertView = nil;
    NSLog(@"666666");


}
- (NSString*)dictionaryToJson:(NSDictionary *)dic

{

    NSError *parseError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
- (void)showAlert
{
    NSString *title = [NSString stringWithFormat:@"温馨提示"];
    NSString *msg = @"是否立即添加健康信息？";
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:title
                                                                    message:msg
                                                             preferredStyle:UIAlertControllerStyleAlert];
    // titile字号处理
    NSMutableAttributedString *hogan = [[NSMutableAttributedString alloc] initWithString:title];
    [hogan addAttribute:NSFontAttributeName
                  value:[UIFont systemFontOfSize:20.0]
                  range:NSMakeRange(0, title.length)];
    [alert setValue:hogan forKey:@"attributedTitle"];
    //

    UIAlertAction *sureAction = [UIAlertAction actionWithTitle:@"添加" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        PersonIFViewController *date = [PersonIFViewController new];
        date.hidesBottomBarWhenPushed = YES
        ;
        [self.navigationController pushViewController:date animated:YES];
    }];
    [alert addAction:sureAction];


    alert.view.tintColor = NavigationColor;
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"跳过"
                                                           style:UIAlertActionStyleCancel
                                                         handler:nil];
    [alert addAction:cancelAction];

    [self presentViewController:alert animated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.tableView setTableHeaderView:self.tableViewHeadView];
    [self getNetCycleScrollView];
    [self getButtonUI];


  [self.tableView registerClass:[homeTableviewCell class] forCellReuseIdentifier:@"CustomCell"];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;


    NSTimer *timer = [NSTimer timerWithTimeInterval:1 target:self selector:@selector(reloop) userInfo:nil repeats:YES];
    [timer fire];
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    [self getcycleImage];


}
- (AdvertModel *)model
{
    if (!_model) {
        _model = [[AdvertModel alloc]init];
    }
    return _model;
}
- (void)getcycleImage
{
    [BYSHttpTool GET:APP_home_getAdvert Parameters:[BYSHttpParameter api_getAdvert_spaceCode:@"center"] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableArray *mutoArray = [NSMutableArray new];
        NSMutableArray *mutoUrlArray = [NSMutableArray new];

        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dic in array) {
          self.model = [self.model initWithDictionary:dic error:nil];
            [mutoArray addObject:self.model.image];
            [mutoUrlArray addObject:self.model.url];



      }
        self.netImages = [mutoArray copy];
        self.urls = [mutoUrlArray copy];
        NSLog(@"%@",self.netImages);
        

        self.cycleScrollView.imageURLStringsGroup = self.netImages;



    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
}

#pragma  mark dingshi
- (void)reloop
{
    NSString *timeSting = [self getTimeSting];
    self.timeLabel.text = timeSting;

    NSString *daySting = [self getDaySting];
    self.dayLabel.text = daySting;



}

#pragma mark date
-(NSArray *)buttonImages{

    if (!_buttonImages) {
        _buttonImages = @[[UIImage imageNamed:@"cycleBottomBT1"],
                       [UIImage imageNamed:@"cycleBottomBT2"],
                       [UIImage imageNamed:@"cycleBottomBT3"]
                       ];
    }
    return _buttonImages;
}
-(NSArray *)netImages{

    if (!_netImages) {
        _netImages = [NSArray new];
    }
    return _netImages;
}
-(NSArray *)buttonTitle{

    if (!_buttonTitle) {
        _buttonTitle = @[@"签到",@"积分",@"邀请"];
    }
    return _buttonTitle;
}



- (NSString *)getTimeSting
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"hh : mm"];
    NSString *timeString = [dateFormatter stringFromDate:currentDate];
    return timeString;

}

- (NSString *)getDaySting
{
    NSDate *currentDate = [NSDate date];//获取当前时间，日期

    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc]init];
    [dayFormatter setDateFormat:@"dd日"];
    NSString *dayString = [dayFormatter stringFromDate:currentDate];
    return dayString;
    
}

#pragma mark UI
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}


- (void)getButtonUI
{
    for (int i = 0; i < self.buttonTitle.count; i++) {
        _headButton = [[UIButton alloc]init];
        _headButton.tag = i;
        _headButton.frame = CGRectMake(i*BYSScreenWidth/3.0,CGRectGetMaxY(self.cycleScrollView.frame),BYSScreenWidth/3.0, 100);
        [_headButton setImage:self.buttonImages[i] forState:UIControlStateNormal];
        _headButton.backgroundColor = [UIColor whiteColor];
        _headButton.titleLabel.font = [UIFont systemFontOfSize: 13.0];

        [_headButton setTitle:self.buttonTitle[i] forState:UIControlStateNormal];
        [_headButton setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_headButton verticalImageAndTitle:10];
        [_headButton addTarget:self action:@selector(homeChick:) forControlEvents:UIControlEventTouchUpInside];
        [self.tableViewHeadView addSubview:_headButton];

    }
    [self.tableViewHeadView addSubview:self.homeIFView];
}

#pragma  mark ButtonAction
- (void)homeChick:(UIButton *)sender
{
    NSUInteger i = sender.tag;
    SignInViewController *sign = [SignInViewController new];
    sign.hidesBottomBarWhenPushed = YES;
    InviteViewController *invite = [InviteViewController new];
    invite.hidesBottomBarWhenPushed = YES;

//    IntergralShoppingViewController *inter = [IntergralShoppingViewController new];
//    inter.hidesBottomBarWhenPushed = YES;

    MyIntergralViewController *myintergral = [MyIntergralViewController new];
    myintergral.hidesBottomBarWhenPushed = YES;




    switch (i) {
        case 0:

        [self.navigationController pushViewController:sign animated:YES];
            break;
        case 1:
        [self.navigationController pushViewController:myintergral animated:YES];
            break;

        case 2:
            [self.navigationController pushViewController:invite animated:YES];
            break;


        default:
            break;
    }
}

- (void)getNetCycleScrollView
{
    _cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, BYSScreenWidth, 180) delegate:self placeholderImage:nil];
    _cycleScrollView.showPageControl = YES;
    _cycleScrollView.pageHight = 10;

    _cycleScrollView.autoScrollTimeInterval = 2.0;

    _cycleScrollView.bannerImageViewContentMode = UIViewContentModeScaleToFill;

    _cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentCenter;
    _cycleScrollView.currentPageDotColor = [UIColor colorWithRed:59/225.0 green:225/225.0 blue:158/255.0 alpha:1];
    _cycleScrollView.pageDotColor = [UIColor whiteColor];
    [self.tableViewHeadView addSubview:_cycleScrollView];
    
    
}


- (UIView *)tableViewHeadView
{
    if (!_tableViewHeadView) {
        _tableViewHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth,400)];
        [_tableViewHeadView setBackgroundColor:TableviewColor];
 



    }
    return _tableViewHeadView;
}



- (UIView *)homeIFView
{
    if (!_homeIFView) {

        NSString *timeString = [self getTimeSting];
        NSString *dayString = [self getDaySting];


       

       _homeIFView = [[UIView alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(self.headButton.frame)+10, BYSScreenWidth,100)];


        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, BYSScreenWidth/4, 30)];
        titleLabel.text = @"健康今日";
        titleLabel.font = [UIFont systemFontOfSize:16.0];
        [_homeIFView addSubview:titleLabel];




        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, BYSScreenWidth, 0.7)];
        lineLabel.backgroundColor = TableviewColor;
        [_homeIFView addSubview:lineLabel];


        UILabel *verticalLineLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth/4, CGRectGetMaxY(lineLabel.frame)+10, 1, 100-40-10-10)];
        verticalLineLabel.backgroundColor = TableviewColor;

        CGSize timeLabelSize = [timeString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]}];
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(verticalLineLabel.frame)-10-timeLabelSize.width-15,CGRectGetMaxY(lineLabel.frame)+10 ,timeLabelSize.width+15, 15)];
        _timeLabel.text = timeString;
        _timeLabel.textColor =[UIColor colorWithRed:76/255.0 green:139/255.0 blue:232/255.0 alpha:1];
        _timeLabel.font = [UIFont systemFontOfSize:14.0];

        [_homeIFView addSubview:_timeLabel];

        CGSize dayLabelSize = [dayString sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]}];
       _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMidX(verticalLineLabel.frame)-10-dayLabelSize.width-15,_homeIFView.bounds.size.height-30,dayLabelSize.width+15, 20)];
        _dayLabel.text = dayString;
        _dayLabel.textColor = [UIColor  grayColor];
        _dayLabel.font = [UIFont systemFontOfSize:14.0];

        [_homeIFView addSubview:_dayLabel];


        NSArray *array = @[@"健康资讯第一条",@"健康资讯第二条",@"健康资讯第三条",@"健康资讯第四条"];

        HRAdView * view = [[HRAdView alloc]initWithTitles:array];
        view.frame = CGRectMake(CGRectGetMaxX(verticalLineLabel.frame)+10, 44, self.view.frame.size.width-CGRectGetMaxX(verticalLineLabel.frame)+10, 44);
        view.textAlignment = NSTextAlignmentLeft;//默认
        view.isHaveHeadImg = YES;
        view.isHaveTouchEvent = YES;
        view.labelFont = [UIFont boldSystemFontOfSize:14];
        view.color = [UIColor blackColor];
        view.time = 2.0f;

        view.headImg = [UIImage imageNamed:@"hotDog"];
        [_homeIFView addSubview:view];
//        self.adView = view;
        view.backgroundColor = [UIColor whiteColor];
        [view beginScroll];







        [_homeIFView addSubview:lineLabel];
        [_homeIFView addSubview:verticalLineLabel];




        [_homeIFView setBackgroundColor:[UIColor whiteColor]];

    }
    return _homeIFView;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"%ld",index);
    AdvertViewController *advert = [AdvertViewController new];
    advert.urlString = self.urls[index];
    advert.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:advert animated:YES];


}

#pragma mark tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    if (!cell) {
       cell = [[homeTableviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
    }
    cell.imageViewCell.image = [UIImage imageNamed:@"test"];
    cell.linelabel.backgroundColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
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
