//
//  ImformationViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/6.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ImformationViewController.h"
#import "ResourceModel.h"
#import "ResourceCollectionViewCell.h"
#import "SearchViewController.h"
#import "GoodsViewController.h"

@interface ImformationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,OpenGoodsDelegate>
@property (nonatomic, strong)UICollectionView *collectionView;

@property (nonatomic, strong)NSArray *titileArray;
@property (nonatomic, strong)NSArray *buttonArray;
@property (nonatomic, strong)ResourceModel *model;
@property (nonatomic, strong)UIView *naviView;


@end

@implementation ImformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TableviewColor;
    self.automaticallyAdjustsScrollViewInsets = NO;

    [self.view addSubview:self.naviView];
    [self.view addSubview:self.collectionView];



}
- (UIView *)naviView
{
    if (!_naviView) {
        _naviView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth,64)];
        _naviView.backgroundColor = NavigationColor;

        UIButton *searchButton = [UIButton buttonWithType:UIButtonTypeCustom];
        searchButton.frame = CGRectMake(10, 25, BYSScreenWidth-10-10, 30);
        [searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
        [searchButton addTarget:self action:@selector(pushSearch:) forControlEvents:UIControlEventTouchUpInside];
        [_naviView addSubview:searchButton];
    }
    return _naviView;
}
- (void)pushSearch:(UIButton *)sender
{
    SearchViewController *search = [SearchViewController new];
    search.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:search animated:YES];
}
- (NSArray *)titileArray
{
    if (!_titileArray) {
        _titileArray = @[@"分类1",@"分类2",@"分类3",@"分类4"];
    }
    return _titileArray;
}
- (NSArray *)buttonArray
{
    if (!_buttonArray) {
        _buttonArray = @[@"分类1",@"打打",@"打开监督卡看见的",@"就啊的叫啊等"];
    }
    return _buttonArray;
}
- (ResourceModel *)model
{

    if (!_model) {
        _model = [[ResourceModel alloc]init];
        _model.titleArray = self.titileArray;
        _model.listButtonArray = self.buttonArray;

    }
    return _model;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        flowlayout.itemSize = CGSizeMake(BYSScreenWidth-10-10, BYSScreenHeight-64-10-10-44-5);
        flowlayout.sectionInset = UIEdgeInsetsMake(10, 0, 0, 0);
        flowlayout.minimumLineSpacing  = 10;
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight-64-44-10) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = TableviewColor;
        [_collectionView registerClass:[ResourceCollectionViewCell class] forCellWithReuseIdentifier:@"ResourceCollectionViewCell"];



    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.titileArray.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ResourceCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ResourceCollectionViewCell" forIndexPath:indexPath];
    cell.delegate = self;

    self.model.titleString = self.titileArray[indexPath.row];



    [cell setModel:self.model];

    cell.backgroundColor =[UIColor whiteColor];
    return  cell;

}
- (void)openGoodsViewController:(NSInteger )tag
{
    NSLog(@"%ld",tag);
    GoodsViewController *goods = [GoodsViewController new];
    goods.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:goods animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;
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
