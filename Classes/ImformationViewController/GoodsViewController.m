//
//  GoodsViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.

#import "GoodsViewController.h"
#import "GoodsListTableCell.h"
#import "GetScoreView.h"

static  NSString *const goodsTableCellReuseIdntifier = @"goodsTableCellReuseIdntifier";
#define rowhight 100



@interface GoodsViewController()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong) GetScoreView *scoreVIiew;
@property (nonatomic, strong) UIView *aplaView;




@end

@implementation GoodsViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.title = @"商品列表";
    [self.view addSubview:self.tableView];
    
    [self getScore];



}
- (void)getScore
{
    self.aplaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, BYSScreenHeight)];
    self.aplaView.backgroundColor = [UIColor blackColor];
    self.aplaView.alpha = 0.4;
    [self.view addSubview:self.aplaView];
    self.aplaView.hidden = YES;

    UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmiss:)];
    [self.aplaView addGestureRecognizer:tap];

    _scoreVIiew = [[GetScoreView alloc]initWithFrame:CGRectMake(0, BYSScreenHeight/2.5, BYSScreenWidth, BYSScreenHeight)];
    [self.view addSubview:_scoreVIiew];
    _scoreVIiew.backgroundColor = [UIColor whiteColor];
    _scoreVIiew.hidden = YES;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight-64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[GoodsListTableCell class] forCellReuseIdentifier:goodsTableCellReuseIdntifier];
        _tableView.rowHeight = rowhight;
    }
    return _tableView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section

{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsListTableCell *cell = [tableView dequeueReusableCellWithIdentifier:goodsTableCellReuseIdntifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[GoodsListTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:goodsTableCellReuseIdntifier];



    }
    NSInteger score = random()%100;

    NSString *scoreString = [NSString stringWithFormat:@"%ld 分",score];
    NSMutableAttributedString *abs = [[NSMutableAttributedString alloc]initWithString:scoreString];



//    NSRange range = [scoreString rangeOfString:@"分"];
    scoreString = [scoreString substringToIndex:3];
    NSInteger scoreInt = [scoreString integerValue];
    NSLog(@"%ld---------%@",scoreInt,scoreString);


    [abs addAttribute:NSForegroundColorAttributeName value:[self scoreColor:scoreInt] range:NSMakeRange(0, 2)];

    [abs addAttribute:NSFontAttributeName value:[UIFont fontWithName:@"Georgia-italic" size:30] range:NSMakeRange(0, 2)];



    cell.imageViewCell.image =[UIImage imageNamed:@"test"];
    cell.labelCell.text = @"王老吉";
    cell.scoreLabel.attributedText = abs;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell.scoreButton addTarget:self action:@selector(getScore:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
    
}

- (void)getScore:(UIButton *)sender
{
    self.aplaView.hidden = NO;
    self.scoreVIiew.hidden = NO;
}
- (void)dissmiss:(UIButton *)sender
{
    self.aplaView.hidden = YES;
    self.scoreVIiew.hidden = YES;
}

- (UIColor *)scoreColor:(NSInteger)score
{
    NSLog(@"%ld",score);

    if (score>60) {

        return [UIColor greenColor];
    }else if (score<60)
    {
        return [UIColor redColor];
    }else
    {
        return [UIColor whiteColor];
    }
}



@end
