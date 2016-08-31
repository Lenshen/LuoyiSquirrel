//
//  IntergralShoppingViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/14.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "IntergralShoppingViewController.h"
#import "IntergralShoppingCollectCell.h"
#import "BYSAlertView.h"
#import "IntergralSViewController.h"
#import "GoodsDetialViewController.h"
#import "BYSHttpParameter.h"
#import "BYSHttpTool.h"
#import "IntergralShopModel.h"
#import "UIImageView+WebCache.h"
@interface IntergralShoppingViewController()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIView *alphaView;
@property (nonatomic,strong) IntergralShopModel *model;
@property (nonatomic,strong) BYSAlertView *alertView;


@property (nonatomic, strong) NSArray *modelArray;







@end


@implementation IntergralShoppingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"积分商城";
    [self.view addSubview:self.collectionView];


     NSMutableArray *mutoArray = [NSMutableArray new];
    [BYSHttpTool POST:APP_goods_getPointGoods Parameters:[BYSHttpParameter api_goods_getPointGoods_index:@"1" size:@"10" sort:@"1"] Success:^(id responseObject) {



        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dic in array) {

            self.model = [[IntergralShopModel alloc]initWithDictionary:dic error:nil];
            NSLog(@"%@",responseObject);

            [mutoArray addObject:self.model];
        }

        self.modelArray = [mutoArray copy];
        [self.collectionView reloadData];



    } Failure:^(NSError *error) {
        
    }];

    


}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight-64) collectionViewLayout:flowlayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = TableviewColor;
        [_collectionView registerClass:[IntergralShoppingCollectCell class] forCellWithReuseIdentifier:@"collectcell"];
    }
    return _collectionView;
}
- (UIView *)alphaView
{
    if (!_alphaView) {

        _alphaView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissAlpha:)];


        [_alphaView addGestureRecognizer:tap];


    }
    return _alphaView;
}
- (BYSAlertView *)alertView
{
    if (!_alertView) {
     _alertView = [[BYSAlertView alloc]initWithFrame:CGRectMake(15, 110, BYSScreenWidth-15*2, 180) titleString:@"温馨提示"  messageSting:@"非常抱歉 , 你的当前积分不足，暂时不能兑换......." buttonTitle:@"去赚积分"];

    }
    return _alertView;
}
- (void)dissmissAlpha:(id)sender
{
    self.alphaView.hidden = YES;
    [self.alphaView removeFromSuperview];
    self.alphaView = nil;
    self.alertView.hidden = YES;
    [self.alertView removeFromSuperview];
    self.alertView = nil;
}
- (void)viewWillAppear:(BOOL)animated{

    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];

    //去除导航栏下方的横线

}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.modelArray.count;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(15, 15, 15, 15);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((BYSScreenWidth-15*2-15)/2.0,167.5);
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    IntergralShoppingCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectcell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor redColor];
    [cell.convertButton addTarget:self action:@selector(convert:) forControlEvents:UIControlEventTouchUpInside];
    cell.layer.cornerRadius = 10;
    cell.convertButton.tag = indexPath.row;
    cell.imageView.image = [UIImage imageNamed:@"intergral_shopping_goods"];

    cell.backgroundColor = [UIColor whiteColor];
    [cell.contentView addSubview:cell.imageView];
    self.model = self.modelArray[indexPath.row];

    [cell.imageView sd_setImageWithURL:[NSURL URLWithString: self.model.image] placeholderImage:nil];

    [cell.contentView addSubview:cell.label];


    [cell.contentView addSubview:cell.moneyLable];
    [cell.contentView addSubview:cell.convertButton];

    NSString *mutostring = self.model.point;
    NSMutableAttributedString *mutableAttributes = [[NSMutableAttributedString alloc]initWithString:mutostring];
    [mutableAttributes addAttributes:@{NSForegroundColorAttributeName:[UIColor redColor]} range:NSMakeRange(0, self.model.point.length)];
    NSTextAttachment *attachment = [[NSTextAttachment alloc]init];
    attachment.image = [UIImage imageNamed:@"intergral_shopping"];
    attachment.bounds = CGRectMake(0, 0, 15, 15);
    NSAttributedString *attributedString = [NSAttributedString attributedStringWithAttachment:attachment];
    [mutableAttributes insertAttributedString:attributedString atIndex:0];

    cell.label.text = self.model.name;
    cell.moneyLable.attributedText = mutableAttributes;




    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    GoodsDetialViewController *gooddetail = [[GoodsDetialViewController alloc]init];


    [self.navigationController pushViewController:gooddetail animated:YES];
}
- (void)convert:(UIButton *)sender
{
    NSLog(@"666666,%ld",sender.tag);

    IntergralSViewController *intergral = [IntergralSViewController new];
    self.model = self.modelArray[sender.tag];


    intergral.image =  self.model.image;
    intergral.count = self.model.point;
    intergral.goodsName = self.model.name;




    [self.navigationController pushViewController:intergral animated:YES];






}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
