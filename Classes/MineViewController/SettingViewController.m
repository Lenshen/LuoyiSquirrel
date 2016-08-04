//
//  SettingViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "SettingViewController.h"
#import "MineEndTableViewCell.h"
#define rowheight 50


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIPickerViewDelegate,UIImagePickerControllerDelegate>
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)NSArray *labelArray;
@property (strong,nonatomic)NSArray *labelFArray;
@property (nonatomic, strong)UIButton *headImageButton;
@property (strong,nonatomic)UIView *exitView;
@property (strong,nonatomic)UILabel *lineLabel;

@property (nonatomic,strong) UIImagePickerController *imagePickerController;




@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = TableviewColor;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"设置";
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"CustomCell"];
    [self.tableView registerClass:[MineEndTableViewCell class] forCellReuseIdentifier:@"MineEndTableViewCell"];

    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView =  self.exitView;



}
- (UIView *)exitView
{
    if (!_exitView) {
        _exitView = [[UIView alloc]initWithFrame:CGRectMake(0,0, BYSScreenWidth, 90)];
        _exitView.backgroundColor = [UIColor whiteColor];

        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,0,BYSScreenWidth-10-10,0.5)];
        lineLabel.backgroundColor = RGB(194, 195, 196);

        UILabel *lineLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0,20,BYSScreenWidth, 10)];
        lineLabel1.backgroundColor = TableviewColor;



        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth/2-35,CGRectGetMaxY(lineLabel1.frame)+15, 70, 30)];
        textLabel.text = @"退出登陆";
        textLabel.textColor = [UIColor redColor];

        UIImageView *iamgeview =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(textLabel.frame)-10-18,CGRectGetMaxY(lineLabel1.frame)+20, 15, 16)];
        iamgeview.image = [UIImage imageNamed:@"exit"];

        [_exitView addSubview:textLabel];
        [_exitView addSubview:iamgeview];
        [_exitView addSubview:lineLabel];
        [_exitView addSubview:lineLabel1];




    }
    return _exitView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, BYSScreenWidth,BYSScreenHeight-64) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSArray *)labelArray
{
    if (!_labelArray) {
        _labelArray = @[@"意见反馈",@"使用帮助",@"关于我们",@"清除缓存"];
    }
    return _labelArray;
}
- (NSArray *)labelFArray
{
    if (!_labelFArray) {
        _labelFArray = @[@"头像",@"昵称",@"等级",@"账户认证"];
    }
    return _labelFArray;
}


#pragma mark tabledelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 0;
    }
    return 10;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.labelArray.count;

    }else
    {return 4;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 0 &&indexPath.row== 0) {
        return 85;
    }
    return rowheight;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{




        MineEndTableViewCell *cell1 =  [tableView dequeueReusableCellWithIdentifier:@"MineEndTableViewCell" forIndexPath:indexPath];
        if (!cell1) {
            cell1 = [[MineEndTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineEndTableViewCell"];
        }

        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
    if (indexPath.section == 0) {
        cell1.firstLabel.text = self.labelFArray[indexPath.row];
        if (indexPath.row == 0) {
            

            cell1.firstLabel.frame = CGRectMake(10, 35,80, 21);
            [cell1.contentView addSubview:self.headImageButton];
            [cell1.contentView addSubview:self.lineLabel];


        }
        if (indexPath.row == 2) {
            cell1.endLabel.text = @"幼儿园";
            cell1.accessoryType = UITableViewCellAccessoryNone;
        }

    }else
    {
        cell1.firstLabel.text = self.labelFArray[indexPath.row];

    }
    if (indexPath.section==1 &&indexPath.row==3) {
        [self getCacheSize:cell1.endLabel];

    }






        return cell1;









}
- (UILabel *)lineLabel
{
    if(!_lineLabel)
    {
        _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 10)];
        _lineLabel.backgroundColor = TableviewColor;
    }
    return _lineLabel;
}
- (UIButton *)headImageButton
{
    if (!_headImageButton) {
        _headImageButton = [[UIButton alloc]init];
        _headImageButton.frame = CGRectMake(BYSScreenWidth-60-20-10, 15, 60, 60);
        _headImageButton.layer.borderWidth = 3.0;
        _headImageButton.layer.borderColor = [UIColor colorWithRed:46/255.0 green:205/255.0 blue:143/255.0 alpha:1.0].CGColor;
        _headImageButton.layer.cornerRadius = 30;
        _headImageButton.layer.masksToBounds = YES;
        [_headImageButton addTarget:self action:@selector(changeHeadImage:) forControlEvents:UIControlEventTouchUpInside];


        _headImageButton.contentMode = UIViewContentModeScaleAspectFit;
        [_headImageButton setBackgroundImage:[UIImage imageNamed:@"headimage"] forState:UIControlStateNormal];
    }
    return _headImageButton;
}

- (void)changeHeadImage:(id)sender
{
    [self initHeadImageAlertController];
}
-(void)getCacheSize:(UILabel *)label
{
    NSString *cache =[NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)objectAtIndex:0];
    CGFloat fileSize = [self folderSizeAtPath:cache];
    label.text = [NSString stringWithFormat:@"%.2fMB",fileSize];
}


- (CGFloat)folderSizeAtPath:(NSString *)folderPath
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) {
        return 0;
    }

    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];

    NSString *fileName = nil;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil) {
        NSString *fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}
- (long long)fileSizeAtPath:(NSString *)filePath
{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = NO;
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



//imagepickerdelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    //    [self.headImage setBackgroundImage:editingInfo[UIImagePickerControllerEditedImage] forState:UIControlStateNormal];
    NSLog(@"%@",editingInfo);
    [picker dismissViewControllerAnimated:YES completion:^{
        NSLog(@"选照片");
    }];}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{

    UIImage *image = info[UIImagePickerControllerEditedImage];
    [self.headImageButton setBackgroundImage:image forState:UIControlStateNormal];

    [picker dismissViewControllerAnimated:YES completion:nil];


    [self base64:image];


}


-(void)base64:(UIImage *)image
{
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    NSString *imageStr = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    self.imageStr = imageStr;
    
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
