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
#import "BYSHttpTool.h"
#import "BYSHttpParameter.h"
#import "MemberIFModel.h"

@interface FamilyMGViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *relationArray;
@property (nonatomic, strong) MemberIFModel *model;





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
- (MemberIFModel *)model
{
    if (!_model) {
        _model = [MemberIFModel new];
    }
    return _model;
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
    return self.relationArray.count+1;
}


- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{

    FamilyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FamilyCollectionViewCell" forIndexPath:indexPath];

    cell.familyHDView.image = [UIImage imageNamed:@"headimage"];
    if (indexPath.row == self.relationArray.count) {
        cell.nameLabel.text = @"添加新成员";
        cell.familyHDView.image = [UIImage imageNamed:@"family_add"];



    }else
    {
        cell.model = self.relationArray[indexPath.row];
//        cell.relationLabel.text = @"主账号";
        cell.relationLabel.textColor = [UIColor grayColor];
        [cell.contentView addSubview:cell.relationLabel];

    }




    cell.backgroundColor = [UIColor whiteColor];


    [cell.contentView addSubview:cell.familyHDView];
    [cell.contentView addSubview:cell.nameLabel];

//    [cell addGestureRecognizer:[self longpress:nil]] ;
    return cell;

}
-(UILongPressGestureRecognizer *)longpress:(UILongPressGestureRecognizer*)ges{
    if(ges.state==UIGestureRecognizerStateBegan){
        //获取目标cell
        NSInteger row=ges.view.tag;
        //删除操作
        if(self.relationArray.count>1){
            NSIndexPath *index =[NSIndexPath indexPathForRow:row inSection:0];
            NSArray* deletearr=@[index];
            [self.collectionView deleteItemsAtIndexPaths:deletearr];
        }else{
            [self.collectionView reloadData];

        }
    }
    return ges;

}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.relationArray.count) {
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


    NSMutableArray *arrayM = [NSMutableArray new];
   [BYSHttpTool POST:APP_member_service Parameters:[BYSHttpParameter get_app_list] Success:^(id responseObject) {
       NSLog(@"%@",responseObject);

       NSArray *array = responseObject[@"data"];
       for (NSDictionary *dic in array) {
           self.model = [_model initWithDictionary:dic error:nil];


           [arrayM addObject:self.model];

           
       }
       self.relationArray = [arrayM copy];
       [self.collectionView reloadData];

   } Failure:^(NSError *error) {
       NSLog(@"%@",error);
   }];
        

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
