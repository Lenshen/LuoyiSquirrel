//
//  FamilyMGViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/20.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "FamilyMGViewController.h"
#import "FamilyCollectionViewCell.h"
#import "PersonIFViewController.h"
#import "MarkViewController.h"

@interface FamilyMGViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *relationArray;



@end

@implementation FamilyMGViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"家庭管理";
    [self.view addSubview:self.collectionView];

}
- (NSArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = @[@"鲍远申",@"鲍林",@"鲍远芝",@"鲍我也不知道了"];
    }
    return _nameArray;
}



- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.minimumLineSpacing = 0;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.itemSize = CGSizeMake((BYSScreenWidth-20-20)/3, 150);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(20, 20+64, BYSScreenWidth-20-20, BYSScreenHeight-64-20) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:[FamilyCollectionViewCell class] forCellWithReuseIdentifier:@"FamilyCollectionViewCell"];


    }
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.nameArray.count+1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    FamilyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FamilyCollectionViewCell" forIndexPath:indexPath];

    cell.familyHDView.image = [UIImage imageNamed:@"headimage"];
    if (indexPath.row == self.nameArray.count) {
        cell.nameLabel.text = @"添加新成员";
        cell.familyHDView.image = [UIImage imageNamed:@"family_add"];



    }else
    {
        cell.nameLabel.text = self.nameArray[indexPath.row];
        cell.relationLabel.text = @"主账号";
        cell.relationLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:cell.relationLabel];

    }




    cell.backgroundColor = [UIColor whiteColor];


    [cell.contentView addSubview:cell.familyHDView];
    [cell.contentView addSubview:cell.nameLabel];


    
    return cell;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.nameArray.count) {
        [self.navigationController pushViewController:[PersonIFViewController new] animated:YES];
}

}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 0, 0, 0);
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;


        

    self.nameArray =  @[@"鲍远申",@"鲍林",@"鲍远芝",@"鲍我也不知道了",@"baoyuan"];

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
