//
//  AuthViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "AuthViewController.h"
#import "MineEndTableViewCell.h"
#import "AutoTableCell.h"

typedef  NS_ENUM(NSInteger,getOphoto)
{

     imageViewButton,
    imageViewButton2,

};
static NSString *AutoCellString = @"autoCellString";
static NSString *AutoCellimageString = @"AutoCellimageString";

@interface AuthViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)NSArray *firstLabelTitleA;
@property (strong,nonatomic)UIView *footview;

@property (nonatomic)getOphoto getOphoto;
@property (strong, nonatomic)UIButton *imageViewButton;
@property (strong, nonatomic)UIButton *imageViewButton2;

@property (nonatomic,strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) AutoTableCell *cell;

@end


@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"认证";
    self.view.backgroundColor = TableviewColor;
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.footview;


}
- (UIView *)footview
{
    if (!_footview) {
        _footview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 40)];
        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, BYSScreenWidth, 0.5)];
        lineLabel.backgroundColor = RGB(188, 186, 193);
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, BYSScreenWidth-20, 40)];
        label.text = @"Tip : 为了保护隐私及信息安全， 您的认证信息不会被泄漏给任何第三方；";
        label.numberOfLines = 2;
        label.textAlignment = NSTextAlignmentCenter;
        label.textColor = [UIColor grayColor];
        label.font = [UIFont systemFontOfSize:12];
        [_footview addSubview:label];
        [_footview addSubview:lineLabel];
    }
    return _footview;
}


- (NSArray *)firstLabelTitleA
{
    if (!_firstLabelTitleA) {
        _firstLabelTitleA = @[@"手机号码",@"地址",@"真实头像",@"身份证"];
    }
    return _firstLabelTitleA;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 10+64, BYSScreenWidth, BYSScreenHeight-74) style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        [_tableView registerClass:[MineEndTableViewCell class] forCellReuseIdentifier:AutoCellString];
         [_tableView registerClass:[AutoTableCell class] forCellReuseIdentifier:AutoCellimageString];
//        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    }
    return _tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.firstLabelTitleA.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger i = indexPath.row;
    switch (i) {
        case 0:
            return  50;
        case 1:
            return  50;

        case 2:
            return  150;

        case 3:
            return  150;

          default:
            return 0;

          break;
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 2 || indexPath.row == 3) {
        _cell = [tableView dequeueReusableCellWithIdentifier:AutoCellimageString];
        if (!_cell) {
            _cell = [[AutoTableCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCellimageString];
        }
        if (indexPath.row == 2) {
            _cell.labelCell.text = @"真实头像";
            _cell.labelCell2.text = @"(请上传手持身份证正面的半身照)";
            _cell.labelCell2.font = [UIFont systemFontOfSize:12];
            _cell.labelCell2.textColor = [UIColor grayColor];

            _imageViewButton = [[UIButton alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-120,30,120, 75)];
            _imageViewButton.layer.borderWidth = 0.5;
            _imageViewButton.layer.borderColor = NavigationColor.CGColor;
            _imageViewButton.layer.cornerRadius = 15;
            _imageViewButton.layer.masksToBounds = YES;
            _imageViewButton.tag = 0;

            [_cell.contentView addSubview:_imageViewButton];
            [_imageViewButton addTarget:self action:@selector(getOphoto:) forControlEvents:UIControlEventTouchUpInside];



        }else
        {
            _cell.labelCell.text = @"专业证书证件";
            _cell.labelCell2.text = @"(如 营养师证 ..... )";
            _cell.labelCell2.font = [UIFont systemFontOfSize:12];
            _cell.labelCell2.textColor = [UIColor grayColor];

            _imageViewButton2 = [[UIButton alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-120,30,120, 75)];
            _imageViewButton2.layer.borderWidth = 0.5;
            _imageViewButton2.layer.borderColor = NavigationColor.CGColor;
            _imageViewButton2.layer.cornerRadius = 15;
            _imageViewButton2.layer.masksToBounds = YES;
            _imageViewButton2.tag = 1;
            [_cell.contentView addSubview:_imageViewButton2];


            [_imageViewButton2 addTarget:self action:@selector(getOphoto:) forControlEvents:UIControlEventTouchUpInside];


        }


        return _cell;

    }else
    {
    MineEndTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AutoCellString];
    if (!cell) {
        cell = [[MineEndTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCellString];
    }
    cell.firstLabel.text = self.firstLabelTitleA[indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
    }
}


- (void)viewWillAppear:(BOOL)animated{

    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;

    //去除导航栏下方的横线

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getOphoto:(UIButton *)sender
{
    [self initHeadImageAlertController:sender.tag];
    self.getOphoto = sender.tag;

}

-(void)initHeadImageAlertController:(NSInteger )tag
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



//imagepickerdelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    //    [self.headImage setBackgroundImage:editingInfo[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    NSLog(@"%@",editingInfo);
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选照片");
    }];}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image = info[UIImagePickerControllerEditedImage];
    if (self.getOphoto == 0) {

        [_imageViewButton setBackgroundImage:image forState:UIControlStateNormal];

   }else
   {
       [_imageViewButton2 setBackgroundImage:image forState:UIControlStateNormal];
   }


    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    [self base64:image];
    
    
}


-(void)base64:(UIImage *)image
{
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    NSString *imageStr = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    self.imageStr = imageStr;
    
}

@end
