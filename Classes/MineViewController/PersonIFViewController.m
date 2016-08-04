//
//  PersonIFViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "PersonIFViewController.h"
#import "UIView+Extension.h"
#import "MineEndTableViewCell.h"
#import "MarkViewController.h"

static  NSString *const PersonTableCellReuseIdntifier = @"PersonableviewCell";


@interface PersonIFViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
@property (nonatomic,strong)NSArray *titleArray;
@property (nonatomic,strong)NSArray *rightTitleArray;




@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)NSArray *images;
@property (nonatomic, strong)NSArray *lableArray;
@property (nonatomic, strong)UIView *tableHeadView;
@property (nonatomic, strong)UIButton *settingButton;
@property (nonatomic, strong)UIButton *headImageButton;
@property (nonatomic, strong)UIImageView *sexImageView;
@property (nonatomic, strong)UIImageView *tableHeadViewImage;

@property (nonatomic,strong)NSString *ncik_nameString;
@property (nonatomic,strong)NSString *height_String;
@property (nonatomic,strong)NSString *weight_String;





@property (nonatomic,strong) UIPickerView *pickview;
@property (nonatomic,strong) UIView *viewp;
@property (nonatomic,strong) UIView *alphaView;

@property (nonatomic, strong) UIButton *canceButtonl;
@property (nonatomic, strong) UIButton *sureButton;
@property (strong, nonatomic)NSString *dateString;
@property (nonatomic,strong) NSString *timesp;
@property (nonatomic,strong) NSMutableArray *monthArray;
@property (nonatomic,strong) NSMutableArray *dayArray;
@property (nonatomic,strong) NSMutableArray *yearArray;
@property (weak, nonatomic) IBOutlet UILabel *dateField;
@property (nonatomic,assign) BOOL isLeapyear;//是否是闰年

@property (nonatomic,strong) NSMutableArray *heightArray;
@property (nonatomic,strong) NSMutableArray *weightArray;




@property (nonatomic,strong) UIImagePickerController *imagePickerController;








@end

@implementation PersonIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"个人信息";
    [self.tableView registerClass:[MineEndTableViewCell class] forCellReuseIdentifier:PersonTableCellReuseIdntifier];
    self.tableView.rowHeight = 44;
    [self.view addSubview:self.tableView];
    self.tableView.tableHeaderView = self.tableHeadView;
    self.tableView.tableFooterView = [UIView new];

    self.dateString = @"1975-09-15";
    self.ncik_nameString = @"鲍远申";
    self.height_String = @"173";
    self.weight_String = @"77";
    self.heightArray = [NSMutableArray array];
    self.weightArray = [NSMutableArray array];

    self.yearArray = [NSMutableArray array];
    self.monthArray = [NSMutableArray array];
    self.dayArray = [NSMutableArray array];

    UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
    sureButton.frame = CGRectMake(10,BYSScreenHeight-30-10,BYSScreenWidth-10-10, 30);
    sureButton.backgroundColor = NavigationColor;
    [sureButton setTitle:@"下一步" forState:UIControlStateNormal];
    sureButton.layer.cornerRadius = 5;
    [sureButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sureButton];





}
- (void)push:(UIButton *)sender
{
    MarkViewController *date = [MarkViewController new];
    [self.navigationController pushViewController:date animated:YES];
}
- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = @[@"姓名",@"出生年月",@"身高",@"体重"];
    }
    return _titleArray;
}



- (UIView *)tableHeadView{
    if (!_tableHeadView) {
        _tableHeadView = [[UIView alloc]initWithFrame:CGRectMake(0, 0,BYSScreenWidth, 130)];

        _headImageButton = [[UIButton alloc]init];
        _headImageButton.frame = CGRectMake(BYSScreenWidth/2-40, 24, 80, 80);
        _headImageButton.layer.borderWidth = 3.0;
        _headImageButton.layer.borderColor = [UIColor colorWithRed:46/255.0 green:205/255.0 blue:143/255.0 alpha:1.0].CGColor;
        _headImageButton.layer.cornerRadius = 40;
        _headImageButton.layer.masksToBounds = YES;
        [_headImageButton addTarget:self action:@selector(changeHeadImage:) forControlEvents:UIControlEventTouchUpInside];


        _headImageButton.contentMode = UIViewContentModeScaleAspectFit;
        [_headImageButton setBackgroundImage:[UIImage imageNamed:@"headimage"] forState:UIControlStateNormal];

        _sexImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_headImageButton.frame)-25,CGRectGetMaxY(_headImageButton.frame)-25, 25, 25)];
        _sexImageView.image = [UIImage imageNamed:@"female"];




        [_tableHeadView addSubview:_tableHeadViewImage];

        [_tableHeadView addSubview:_settingButton];
        [_tableHeadView addSubview:_headImageButton];
        [_tableHeadView addSubview:_sexImageView];
        
        
        
        
        
    }
    return _tableHeadView;
}
- (void)changeHeadImage:(id)sender
{
    [self initHeadImageAlertController];
}




- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,64, BYSScreenWidth, BYSScreenHeight-64) style:UITableViewStylePlain];
        [self.view addSubview:_tableView];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

#pragma mark tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{


    MineEndTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:PersonTableCellReuseIdntifier forIndexPath:indexPath];
    if (!cell) {
        cell = [[MineEndTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:PersonTableCellReuseIdntifier];
    }




    cell.firstLabel.text = self.titleArray[indexPath.row];
    cell.endLabel.text = self.rightTitleArray[indexPath.row];

    NSUInteger i = indexPath.row;


    switch (i) {
        case 0:
            cell.endLabel.text = [NSString stringWithFormat:@"%@",self.ncik_nameString];
            break;

        case 1:
            cell.endLabel.text = self.dateString;
            break;
        case 2:
            cell.endLabel.text = [NSString stringWithFormat:@"%@cm",self.height_String];
            break;
        case 3:
            cell.endLabel.text = [NSString stringWithFormat:@"%@kg",self.height_String];
            break;

        default:
            break;
    }
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

#pragma mark didSelectRowAtIndexPath
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger i = indexPath.row;
    switch (i) {
        case 0:

            [self initNameField];
            break;

        case 1:



            [self pickview:1];

            _sureButton.hidden = NO;
            _canceButtonl.hidden = NO;
            _viewp.hidden = NO;
            _pickview.hidden = NO;
            _alphaView.hidden = NO;
            [self getDateDataSource];



            [self.view addSubview:self.pickview];

            break;

        case 2:
            [self pickview:2];
            _sureButton.hidden = NO;
            _canceButtonl.hidden = NO;
            _viewp.hidden = NO;
            _pickview.hidden = NO;
            _alphaView.hidden = NO;


            [self getWeightDateDataSource];


            [self.view addSubview:self.pickview];


            break;
        case 3:
            [self pickview:3];
            _sureButton.hidden = NO;
            _canceButtonl.hidden = NO;
            _viewp.hidden = NO;
            _pickview.hidden = NO;
            _alphaView.hidden = NO;


            [self getHeightDateDataSource];


            [self.view addSubview:self.pickview];
            
            
            break;


        default:
            break;
    }
}
- (void)viewWillAppear:(BOOL)animated{

    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;


}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark initphotoimage
- (void)initNameField
{

    UIAlertController *alertController =[UIAlertController alertControllerWithTitle:@"修改昵称" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"请输入昵称";
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertTextFieldDidChange:) name:UITextFieldTextDidChangeNotification object:textField];


    }];

    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {

        NSLog(@"好的");









    }];



    [alertController addAction:okAction];


    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];

}

- (void)alertTextFieldDidChange:(NSNotification *)notification{
    UIAlertController *alertController = (UIAlertController *)self.presentedViewController;
    if (alertController) {
        UITextField *textField = alertController.textFields.firstObject;

        self.ncik_nameString = textField.text;
        [self.tableView reloadData];
        
    }
}
- (void)didEnterBackground:(NSNotification *)notification
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
    [self.presentedViewController dismissViewControllerAnimated:NO completion:nil];
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





















#pragma mark initpickview





- (UIPickerView *)pickview:(NSInteger)tag
{
    if (!_pickview) {

        _pickview = [[UIPickerView alloc]initWithFrame:CGRectZero];
        _pickview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
        _pickview.frame = CGRectMake(0, BYSScreenHeight-150-50,BYSScreenWidth, 150);
        _pickview.showsSelectionIndicator = YES;
        _pickview.backgroundColor = [UIColor whiteColor];
        _pickview.delegate = self;
        _pickview.dataSource = self;
        _pickview.tag = tag;


        _viewp = [[UIView alloc]initWithFrame:CGRectMake(0,_pickview.origin.y-50, BYSScreenHeight,50 )];
        _viewp.backgroundColor = TableviewColor;

        _alphaView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, BYSScreenHeight)];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.3;
        [self.view addSubview:_alphaView];



        [self.view addSubview:_viewp];
        _canceButtonl = [[UIButton alloc]initWithFrame:CGRectMake(0,_pickview.origin.y-50, 50,50 )];
        [_canceButtonl addTarget:self action:@selector(cancel) forControlEvents:UIControlEventTouchUpInside];
        [_canceButtonl setTitle:@"取消" forState:UIControlStateNormal];
        _canceButtonl.backgroundColor =[UIColor clearColor];
        [_canceButtonl setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];


        [self.view addSubview:_canceButtonl];

        _sureButton = [[UIButton alloc]initWithFrame:CGRectMake(self.view.width-50,_pickview.origin.y-50, 50,50 )];
        [_sureButton setTitle:@"确定" forState:UIControlStateNormal];
        _sureButton.backgroundColor = [UIColor clearColor];
        [_sureButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sure) forControlEvents:UIControlEventTouchUpInside];

        [self.view addSubview:_sureButton];
        _canceButtonl.hidden = NO;
        _sureButton.hidden = NO;

    }
    return _pickview;
}
-(void)cancel
{
    _canceButtonl.hidden = YES;
    _sureButton.hidden = YES;
    _pickview.hidden = YES;
    _viewp.hidden = YES;
    _alphaView.hidden = YES;

    self.pickview = nil;
    [self.pickview removeFromSuperview];

}

-(void)sure
{

    if (self.pickview.tag == 1) {
        _canceButtonl.hidden = YES;
        _sureButton.hidden = YES;
        _pickview.hidden = YES;
        _viewp.hidden = YES;
        _alphaView.hidden = YES;


        [self.pickview removeFromSuperview];


        NSString *yearString = [self.yearArray objectAtIndex:[self.pickview selectedRowInComponent:0]];
        NSString *monthString = [self.monthArray objectAtIndex:[self.pickview selectedRowInComponent:1]];
        NSString *dayString = [self.dayArray objectAtIndex:[self.pickview selectedRowInComponent:2]];
        self.dateString = [NSString stringWithFormat:@"%@-%@-%@",yearString,monthString,dayString];

        NSString* timeStr = self.dateString;
        self.dateField.text = self.dateString;

        _timesp = [self transTotimeSp:timeStr];
        [self.tableView reloadData];


        self.pickview = nil;


        NSLog(@"%@  %@",timeStr,_timesp);
    }else if (self.pickview.tag == 2)
    {
        _canceButtonl.hidden = YES;
        _sureButton.hidden = YES;
        _pickview.hidden = YES;
        _viewp.hidden = YES;
        _alphaView.hidden = YES;

        [self.pickview removeFromSuperview];


        self.weight_String = [self.weightArray objectAtIndex:[self.pickview selectedRowInComponent:0]];
        NSLog(@"%@",self.weight_String);
        [self.tableView reloadData];

        self.pickview = nil;



    }else if (self.pickview.tag == 3)
    {
        _canceButtonl.hidden = YES;
        _sureButton.hidden = YES;
        _pickview.hidden = YES;
        _viewp.hidden = YES;
        _alphaView.hidden = YES;

        [self.pickview removeFromSuperview];
        self.pickview = nil;


        self.height_String = [self.heightArray objectAtIndex:[self.pickview selectedRowInComponent:0]];
        NSLog(@"%@",self.height_String);
        [self.tableView reloadData];

        self.pickview = nil;



    }


}
-(NSString *)transTotimeSp:(NSString *)time{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]]; //设置本地时区
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSDate *date = [dateFormatter dateFromString:time];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];//时间戳
    return timeSp;
}


- (void)getDateDataSource{
    for (int i = 1970; i <= 9999; i++) {
        [self.yearArray addObject:[NSString stringWithFormat:@"%d",i]];
    }
    for (int i = 1; i<13; i++) {

        [self.monthArray addObject:[NSString stringWithFormat:@"%.2d",i]];
    }
    for (int i = 1; i<32; i++) {
        [self.dayArray addObject:[NSString stringWithFormat:@"%.2d",i]];
    }
    [self.pickview reloadAllComponents];

}

- (void)getHeightDateDataSource{
    for (int i = 40; i <= 150; i++) {
        [self.heightArray addObject:[NSString stringWithFormat:@"%d",i]];
    }


    [self.pickview reloadAllComponents];
}

- (void)getWeightDateDataSource{
    for (int i = 150; i <= 300; i++) {
        [self.weightArray addObject:[NSString stringWithFormat:@"%d",i]];
    }


    [self.pickview reloadAllComponents];
}
-( NSInteger )numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    if (self.pickview.tag == 1) {

        return 3;

    }else
    {
        return 1;
    }

}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if (self.pickview.tag == 1) {
        if (component == 0)

            return self.yearArray.count;

        else if (component ==1)

            return self.monthArray.count;

        else
            return self.dayArray.count;

    }else if(self.pickview.tag == 2)
    {
        return self.weightArray.count;
    }
    else if(self.pickview.tag == 3)
    {
        return self.heightArray.count;
    }
    else
        return 0;

}


- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {

    if (self.pickview.tag == 1) {
        if (component == 0) {
            if ((row+1970)%4==0) {
                self.isLeapyear = YES;
            }

            return [self.yearArray objectAtIndex:row];

        }
        else if (component == 1){
            if (self.isLeapyear) {
                if (row == 2) {

                }
            }

            return [self.monthArray objectAtIndex:row];
        }
        else if (component == 2)
            return [self.dayArray objectAtIndex:row];
        
        else
            return nil;

    }else if(self.pickview.tag == 2)
    {

        if(component == 0)
        {
            return [self.weightArray objectAtIndex:row];

        }
        else
            return nil;
        
    }
    else if(self.pickview.tag == 3)
    {

        if(component == 0)
        {
            return [self.heightArray objectAtIndex:row];

        }
        else
            return nil;

    }else
        return nil;

}

@end
