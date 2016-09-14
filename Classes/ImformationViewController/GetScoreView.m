//
//  GetScoreView.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/9.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "GetScoreView.h"
#import "FamilyCollectionViewCell.h"
#import "BYSHttpTool.h"
#import "BYSHttpParameter.h"
#import "MessageModel.h"

@interface GetScoreView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *relationArray;
@property (nonatomic, strong) MemberIFModel *model;






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
    [self getDate];


    }
    return self;
}
- (void)getDate
{
    
    NSMutableArray *arrayM = [NSMutableArray new];

    [BYSHttpTool POST:APP_member_service Parameters:[BYSHttpParameter get_app_list] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);

        NSArray *array = responseObject[@"data"];
        for (NSDictionary *dic in array) {

            self.model = [[MemberIFModel alloc] initWithDictionary:dic error:nil];


            [arrayM addObject:self.model];


        }

        self.relationArray = [arrayM copy];
//        self.is_edit = NO;

        [self.collectionView reloadData];
        
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
    }];
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
    return self.relationArray.count+1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

//    FamilyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FamilyCollectionViewCell" forIndexPath:indexPath];
//
//    cell.familyHDView.image = [UIImage imageNamed:@"headimage"];
//    if (indexPath.row == self.nameArray.count) {
//        cell.nameLabel.text = @"添加新成员";
//        cell.familyHDView.image = [UIImage imageNamed:@"family_add"];
//
//
//
//    }else
//    {
//        cell.nameLabel.text = self.nameArray[indexPath.row];
//        cell.relationLabel.text = @"主账号";
//        cell.relationLabel.textColor = [UIColor grayColor];
//        [cell.contentView addSubview:cell.relationLabel];
//
//    }
//
//
//
//
//    cell.backgroundColor = [UIColor whiteColor];
//
//
//    [cell.contentView addSubview:cell.familyHDView];
//    [cell.contentView addSubview:cell.nameLabel];
//
//
//
//    return cell;

    FamilyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FamilyCollectionViewCell" forIndexPath:indexPath];
    cell.deleteButton.alpha = 0;


    cell.familyHDView.image = [UIImage imageNamed:@"headimage"];
    if (indexPath.row == self.relationArray.count) {

        cell.nameLabel.text = @"添加新成员";
        cell.familyHDView.image = [UIImage imageNamed:@"family_add"];
        cell.deleteButton.alpha = 0;



    }else
    {
        cell.model = self.relationArray[indexPath.row];
//        cell.deleteButton.member = indexPath.row;

        [cell.contentView addSubview:cell.relationLabel];
//        if (self.is_edit) {
//            [UIView animateWithDuration:1 animations:^{
//                cell.deleteButton.alpha = 1;
//
//            }];
//        }else
//        {
//            cell.deleteButton.alpha = 0;
//
//
//
//        }






    }




    cell.backgroundColor = [UIColor whiteColor];

//    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];


//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self
//                                                                                           action:@selector(longpress:)];
//    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里

//    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
//    tap.delegate = self;
//    [self.collectionView addGestureRecognizer:tap];
//
//    [self.collectionView addGestureRecognizer:longPress];

    [cell.contentView addSubview:cell.familyHDView];
    [cell.contentView addSubview:cell.nameLabel];
//    [cell.contentView addSubview:cell.deleteButton];

    
    
    //    [cell addGestureRecognizer:[self longpress:nil]] ;
    return cell;

}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(0, 20, 0, 20);
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    

    if ([self.chickDelegate respondsToSelector:@selector(chickCollectionViewDelegate:WithId: Array:)]) {
        [self.chickDelegate chickCollectionViewDelegate:indexPath.row WithId:100 Array:self.relationArray];

    }

}

@end
