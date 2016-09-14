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
 #import <AudioToolbox/AudioToolbox.h>
#import "UIButton+property.h"


@interface FamilyMGViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UIGestureRecognizerDelegate>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSArray *nameArray;
@property (nonatomic, strong) NSArray *relationArray;
@property (nonatomic, strong) MemberIFModel *model;

@property (nonatomic) BOOL is_edit;




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
        flowLayout.sectionInset = UIEdgeInsetsMake(20, 20, 20, 20);
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight-64) collectionViewLayout:flowLayout];
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

    FamilyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"FamilyCollectionViewCell" forIndexPath:indexPath];
    cell.deleteButton.alpha = 0;


    cell.familyHDView.image = [UIImage imageNamed:@"headimage"];
    if (indexPath.row == self.relationArray.count) {

        cell.nameLabel.text = @"添加新成员";
        cell.deleteButton.alpha = 0;
        cell.mainHeadimageview.alpha = 0;
        cell.familyHDView.image = [UIImage imageNamed:@"family_add"];





    }else
    {
        self.model = self.relationArray[indexPath.row];

        cell.model = self.model;
        cell.deleteButton.member = indexPath.row;

        [cell.contentView addSubview:cell.relationLabel];
        if (self.is_edit) {
            [UIView animateWithDuration:1 animations:^{
                cell.deleteButton.alpha = 1;

            }];
        }else
        {
                cell.deleteButton.alpha = 0;



        }

     




    }




    cell.backgroundColor = [UIColor whiteColor];

    [cell.deleteButton addTarget:self action:@selector(delete:) forControlEvents:UIControlEventTouchUpInside];


    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc]initWithTarget:self
                                               action:@selector(longpress:)];
    longPress.minimumPressDuration = 1.0;
    //将长按手势添加到需要实现长按操作的视图里

    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)];
    tap.delegate = self;
    [self.collectionView addGestureRecognizer:tap];

   
    [cell.contentView addSubview:cell.familyHDView];
    [cell.contentView addSubview:cell.nameLabel];
    [cell.contentView addSubview:cell.deleteButton];

    [self.collectionView addGestureRecognizer:longPress];
    if ([_model.is_default  isEqual: @"1"] && indexPath.row != self.relationArray.count) {




        [cell.contentView addSubview:cell.mainHeadimageview];

        cell.mainHeadimageview.alpha = 1;



    }else
    {
        cell.mainHeadimageview.alpha = 0;
        [cell.mainHeadimageview removeFromSuperview];
        cell.mainHeadimageview = nil;
    }




//    [cell addGestureRecognizer:[self longpress:nil]] ;
    return cell;

}
- (void)tap:(id)sender
{
    self.is_edit = NO;
    [self.collectionView reloadData];

}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    // 输出点击的view的类名
    NSLog(@"%@", NSStringFromClass([touch.view class]));

    // 若为UITableViewCellContentView（即点击了tableViewCell），则不截获Touch事件
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UIView"] || [NSStringFromClass([touch.view class]) isEqualToString:@"UIButton" ]) {
        return NO;
    }
    return  YES;
}

- (void)delete:(UIButton *)sender
{
    NSLog(@"666666666");

    NSMutableArray *mutoArray = [NSMutableArray arrayWithArray:self.relationArray];
    NSString *member = [NSString stringWithFormat:@"%ld",sender.tag];

    [BYSHttpTool POST:APP_member_service Parameters:[BYSHttpParameter get_app_delete_info_member_id:member] Success:^(id responseObject) {
//        NSData *responseData = responseObject;
//        NSString *str =  [[NSString alloc]initWithData:responseData encoding:NSUTF8StringEncoding];
        NSLog(@"%@",responseObject);
        if ([responseObject[@"message"] isEqualToString:@"成功"]) {
            [mutoArray removeObjectAtIndex:sender.member];
            self.relationArray = [mutoArray copy];

            [self.collectionView reloadData];



        }











    } Failure:^(NSError *error) {
        NSLog(@"%@",error);

    }];
}
-(void)longpress:(UILongPressGestureRecognizer*)ges{
//    if(ges.state==UIGestureRecognizerStateBegan){
//        //获取目标cell
//        NSInteger row=ges.view.tag;
//        //删除操作
//        if(self.relationArray.count>1){
//            NSIndexPath *index =[NSIndexPath indexPathForRow:row inSection:0];
//            NSArray* deletearr=@[index];
//            [self.collectionView deleteItemsAtIndexPaths:deletearr];
//        }else{
//            [self.collectionView reloadData];
//
//        }
//    }
//    return ges;
    self.is_edit = YES;
    AudioServicesPlaySystemSound (kSystemSoundID_Vibrate);
    [self.collectionView reloadData];



}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.row == self.relationArray.count) {
        [self.navigationController pushViewController:[PersonIFViewController new] animated:YES];

        

}

}
//- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
//    return UIEdgeInsetsMake(0, 0, 0, 0);
//}


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

           self.model = [[MemberIFModel alloc] initWithDictionary:dic error:nil];


           [arrayM addObject:self.model];

           
       }

       self.relationArray = [arrayM copy];
       self.is_edit = NO;

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
