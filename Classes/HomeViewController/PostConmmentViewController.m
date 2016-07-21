//
//  PostConmmentViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/21.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "PostConmmentViewController.h"
#import "PhotoCollectionViewCell.h"


@interface PostConmmentViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *changLabel;
@property (nonatomic, strong) UILabel *placeHold;
@property (nonatomic, strong) UICollectionView *collectionView;




@property (nonatomic, strong)NSMutableArray *photoArrayM;

@end

@implementation PostConmmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.navigationController.navigationBar.barTintColor = NavigationColor;
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.textView];
    [self.view addSubview:self.collectionView];


    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(10,BYSScreenHeight-10-40,BYSScreenWidth-10-10, 40);
    sureButton.backgroundColor = NavigationColor;
    [sureButton setTitle:@"发表评论" forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 5;

    [self.view addSubview:sureButton];





}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        //创建一种布局
        UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc]init];
        //设置每一个item的大小
        flowL.itemSize = CGSizeMake(80,80);
        flowL.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        //列
        flowL.minimumInteritemSpacing = 10;
        //行
        flowL.minimumLineSpacing = 10;

        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_textView.frame), BYSScreenWidth, 100) collectionViewLayout:flowL];
        _collectionView.backgroundColor = TableviewColor;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        [_collectionView registerClass:[PhotoCollectionViewCell class] forCellWithReuseIdentifier:@"PhotoCollectionViewCell"];
    }
    return _collectionView;
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [_textView resignFirstResponder];
}
- (UITextView *)textView
{
    if (!_textView) {
        _textView = [[UITextView alloc]initWithFrame:CGRectMake(0,64, BYSScreenWidth, 150)];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:16.0];

        _placeHold = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 200, 21)];
        _placeHold.text = @"请输入评论内容";
        _placeHold.textColor = [UIColor grayColor];

        _changLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-100,150-21-10, 100, 21)];
        _changLabel.text = @"(0/140)";
        _changLabel.textAlignment = NSTextAlignmentRight;
        _changLabel.textColor = [UIColor grayColor];

        [_textView addSubview:_placeHold];
        [_textView addSubview:_changLabel];









    }
    return _textView;
}













- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (_photoArrayM.count == 0) {
        return 0+1;
    }
    else{
        return _photoArrayM.count+1;
    }
}

//返回每一个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];

    cell.photoV.image = [UIImage imageNamed:@"post_photo"];
    return cell;
}



- (void)textViewDidChangeSelection:(UITextView *)textView
{
    if (textView.text.length >0) {
        self.placeHold.hidden = YES;
    }else
    {
        self.placeHold.hidden = NO;
    }
    NSUInteger length = textView.text.length;
    self.changLabel.text = [NSString stringWithFormat:@"(%ld/140)",length];
    BOOL reluts;
    reluts = textView.text.length>=140? NO:YES;
    self.textView.editable = reluts;


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
