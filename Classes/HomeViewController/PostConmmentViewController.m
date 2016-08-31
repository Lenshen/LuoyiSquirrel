//
//  PostConmmentViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/21.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "PostConmmentViewController.h"
#import "PhotoCollectionViewCell.h"
#import "BYSHttpTool.h"
#import "BYSHttpParameter.h"
#import "SVProgressHUD.h"
#import "BYSAlertView.h"


@interface PostConmmentViewController ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *changLabel;
@property (nonatomic, strong) UILabel *placeHold;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic,strong) UIImagePickerController *imagePickerController;
@property (nonatomic,strong) BYSAlertView *alertView;

@property (nonatomic,copy) NSString *alertViewMessage;







@property (nonatomic, strong)NSMutableArray *photoArrayM;
@property (nonatomic, strong)NSMutableArray *baseArrayM;


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
    [sureButton addTarget:self action:@selector(postcomment:) forControlEvents:UIControlEventTouchUpInside];

    UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0, BYSScreenHeight-10-40-10-20, BYSScreenWidth, 20)];
    linelabel.backgroundColor = TableviewColor;

    [self.view addSubview:sureButton];
    [self.view addSubview:linelabel];





}
- (void)postcomment:(UIButton *)sender
{
    [SVProgressHUD show];

    [BYSHttpTool POST:APP_comment_addComment Parameters:[BYSHttpParameter api_comment_addCommentWithGoods_id:@"0" content:self.textView.text comment_images:self.baseArrayM] Success:^(id responseObject) {

        [SVProgressHUD dismiss];
        self.alertViewMessage = responseObject[@"message"];

        [self setAlertUI:self.alertViewMessage];

        NSLog(@"%@",responseObject);


    } Failure:^(NSError *error) {
        [SVProgressHUD dismiss];

    }];
}
- (NSMutableArray *)photoArrayM{
    if (!_photoArrayM) {
        _photoArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _photoArrayM;
}
- (NSMutableArray *)baseArrayM{
    if (!_baseArrayM) {
        _baseArrayM = [NSMutableArray arrayWithCapacity:0];
    }
    return _baseArrayM;
}
- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        //创建一种布局
        UICollectionViewFlowLayout *flowL = [[UICollectionViewFlowLayout alloc]init];
        //设置每一个item的大小
        flowL.itemSize = CGSizeMake(BYSScreenWidth/4-10-5,80);
        flowL.sectionInset = UIEdgeInsetsMake(10, 10, 10,10);
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
    
    if (self.photoArrayM.count == 0) {
        return 0+1;
    }
    else{
        return self.photoArrayM.count+1;
    }
}

//返回每一个cell
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    PhotoCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PhotoCollectionViewCell" forIndexPath:indexPath];

    if (indexPath.row == self.photoArrayM.count) {
        cell.photoV.image = [UIImage imageNamed:@"post_photo"];

    }else
    {
        cell.photoV.image = self.photoArrayM[indexPath.row];
    }
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.photoArrayM.count) {

        [self initHeadImageAlertController];

    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    UIImage *image=[info objectForKey:UIImagePickerControllerEditedImage];
    //    [self.btn setImage:image forState:UIControlStateNormal];
    [self.photoArrayM addObject:image];
    [self.baseArrayM addObject:[self base64:image]];
    //选取完图片之后关闭视图
    [self dismissViewControllerAnimated:YES completion:nil];
    [self.collectionView reloadData];
}

-(NSString *)base64:(UIImage *)image
{
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    NSString *imageStr = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    self.imageStr = imageStr;
    return imageStr;

}

-(void)initHeadImageAlertController
{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"相册或照相获取图片" message:nil preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"相机" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)
                                   {

                                       [self openCamera];

                                   }];

    UIAlertAction *deleteAction = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action)

                                   {

                                       [self openPhotoLibrary];

                                   }];

    UIAlertAction *archiveAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];


    [alertController addAction:cancelAction];
    [alertController addAction:deleteAction];
    [alertController addAction:archiveAction];

    [self presentViewController:alertController animated:YES completion:nil];



}

- (void) openCamera
{

    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *impick = [[UIImagePickerController alloc]init];
        impick.delegate = self;
        impick.allowsEditing = YES;
        impick.sourceType = UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:impick animated:YES completion:nil];
    }


}

-(void)openPhotoLibrary
{


    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {

        _imagePickerController = [[UIImagePickerController alloc] init];

        _imagePickerController.delegate = self;

        _imagePickerController.allowsEditing = YES;

        _imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;


        [self presentViewController:_imagePickerController animated:YES completion:^{

            NSLog(@"cccc");

        }];





    }else

    {

        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"你摄像头没开启呢！" message:nil preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:nil];
        [alertController addAction:action];
        [self presentViewController:alertController animated:YES completion:nil];
        
        
        
        
    }
    
    
    
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
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    if (self.photoArrayM.count >3) {

    _collectionView.frame = CGRectMake(0, CGRectGetMaxY(_textView.frame), BYSScreenWidth, 100+80+10);
        

    }
    if (self.photoArrayM.count >= 7) {
        _collectionView.userInteractionEnabled = NO;
    }
}



- (void)setAlertUI:(NSString *)message
{


    _alertView = [[BYSAlertView alloc]initWithFrame:CGRectMake(15,-110, BYSScreenWidth-15*2, 180) titleString:@"温馨提示"  messageSting:message buttonTitle:@"确定"];
    __weak typeof (self) weakSelf = self;
    _alertView.chickDissMissButton = ^{
        weakSelf.alertView = nil;
    };

    [_alertView.rightButton addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];

    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView.alphaView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];



    [UIView animateWithDuration:0.7 animations:^{

        self.alertView.frame = CGRectMake(15, 110, BYSScreenWidth-15*2, 180);
    }];
}

- (void)dismiss:(id)sender
{

    self.alertView.alphaView.hidden = YES;
    [self.alertView.alphaView removeFromSuperview];
    self.alertView.alphaView = nil;
    self.alertView.hidden = YES;
    [self.alertView removeFromSuperview];
    self.alertView = nil;
    [self.navigationController popViewControllerAnimated:YES];
    NSLog(@"666666");
    
    
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
