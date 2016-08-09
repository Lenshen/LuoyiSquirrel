//
//  GetScoreView.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/9.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "GetScoreView.h"
#import "FamilyCollectionViewCell.h"

@interface GetScoreView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *relationArray;






@end



@implementation GetScoreView


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

       

        [self configUI];
    }
    return self;
}


- (void)configUI
{

    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, BYSScreenWidth, 21)];
    label.text = @"为我打分";
    label.font = [UIFont systemFontOfSize:14];
    label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:label];
    [self addSubview:self.collectionView];
}









- (NSArray *)nameArray
{
    if (!_nameArray) {
        _nameArray = @[@"鲍远申",@"鲍林",@"鲍远芝",@"鲍我也不知道了",@"baood",@"basdjk"];
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

    


        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 50, BYSScreenWidth, self.frame.size.height-200-20-40) collectionViewLayout:flowLayout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.showsVerticalScrollIndicator = NO;
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
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    if ([self.chickDelegate respondsToSelector:@selector(chickCollectionViewDelegate:WithId:)]) {
        [self.chickDelegate chickCollectionViewDelegate:indexPath.row WithId:100];

    }

}

@end
