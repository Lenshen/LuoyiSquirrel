//
//  DateWriteOneViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/3.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "DateWriteOneViewController.h"
#import "DateOneTableViewCell.h"
#import "DateWriteTwoViewController.h"
#import "SubLBXScanViewController.h"
//#import "MyQRViewController.h"
#import "LBXScanView.h"
#import <objc/message.h>
#import "SearchViewController.h"
#import "LBXScanResult.h"
#import "LBXScanWrapper.h"
#import "GoodsViewController.h"
#import "MarkViewController.h"

#import "ContentViewController.h"
#import "DateWriteThreeViewController.h"


#define DateOnebigFont [UIFont systemFontOfSize:15]

#define DateOneFont [UIFont systemFontOfSize:13]

@interface DateWriteOneViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate,UITextFieldDelegate,UINavigationControllerDelegate,UIImagePickerControllerDelegate>

@property (nonatomic, strong)UITableView *tableView;
@property (nonatomic, strong)UIView *tableFootView;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) UILabel *changLabel;
@property (nonatomic, strong) UILabel *placeHold;
@property (nonatomic, strong) UITextField *priceTF;

@property (nonatomic, strong) NSArray *liftTitleArray;
@property (nonatomic, strong) NSArray *rightButtonArray;

@property (nonatomic, strong) UIButton *yuanButton;
@property (nonatomic, strong) UIButton *kgButton;

@property (nonatomic, strong) DateOneTableViewCell *cell;

@property (nonatomic,strong) UIImagePickerController *imagePickerController;
@property (nonatomic,strong) NSMutableArray *photoImageMArray;
@property (nonatomic,strong) UILabel *titleLabelTwo;
@property (nonatomic,strong) UIImageView *photoImageView;





@end

@implementation DateWriteOneViewController

- (NSArray *)liftTitleArray
{
    if (!_liftTitleArray) {
        _liftTitleArray  = @[@"条码",@"名称",@"品牌",@"产品类型",@"食物分类",@"保质期",@"储存条件",@"物性",@"口味",@"接触包装材料",@"执行标准号",@"净含量",@"加工方法",@"食用方法"];
    }
    return _liftTitleArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"数据录入";

    [self.view addSubview:self.tableView];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = self.tableFootView;

    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;


}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, BYSScreenWidth, BYSScreenHeight) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[DateOneTableViewCell class] forCellReuseIdentifier:@"DateOneTableViewCell"];
    }
    return _tableView;
}
- (UIView *)tableFootView
{
    if (!_tableFootView) {
        _tableFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 280+40+64)];
        UILabel *titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, BYSScreenWidth-10-10, 21)];
        titleLabel.text = @"安全警告";
        titleLabel.textAlignment = NSTextAlignmentLeft;
        titleLabel.font = DateOnebigFont;


        _textView = [[UITextView alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(titleLabel.frame)+10, BYSScreenWidth-10-10, 70)];
        _textView.delegate = self;
        _textView.font = [UIFont systemFontOfSize:16.0];
        _textView.layer.borderColor = RGB(194, 195, 196).CGColor;
        _textView.layer.borderWidth = 0.7;

        _placeHold = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 200, 21)];
        _placeHold.text = @"选填";
        _placeHold.textColor = [UIColor grayColor];
        _placeHold.font = DateOneFont;

        _changLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-100-10-5,70-21, 100, 21)];
        _changLabel.text = @"(0/35)";
        _changLabel.textAlignment = NSTextAlignmentRight;
        _changLabel.textColor = [UIColor grayColor];
        _changLabel.font = DateOneFont;

        [_textView addSubview:_placeHold];
        [_textView addSubview:_changLabel];



        _titleLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_textView.frame)+20, 100, 21)];
        _titleLabelTwo.text = @"上传照片";
        _titleLabelTwo.textAlignment = NSTextAlignmentLeft;
        _titleLabelTwo.font = DateOnebigFont;




        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(BYSScreenWidth-10-50, CGRectGetMaxY(_textView.frame)+10, 50, 50);
        [photoButton setBackgroundImage:[UIImage imageNamed:@"post_photo"] forState:UIControlStateNormal];
        [photoButton addTarget:self action:@selector(takePhoto:) forControlEvents:UIControlEventTouchUpInside];

        UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(photoButton.frame)+10, BYSScreenWidth-10-10, 0.7)];
        lineLabel.backgroundColor = RGB(194, 195, 196);




        UILabel *titleLabelThree = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(lineLabel.frame)+10, 100, 21)];
        titleLabelThree.text = @"参考价格";
        titleLabelThree.textAlignment = NSTextAlignmentLeft;
        titleLabelThree.font = DateOnebigFont;


        _priceTF = [[UITextField alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(titleLabelThree.frame)+10, 100, 21)];
        NSString *str = @"选填";
        NSAttributedString *attribute = [[NSAttributedString alloc]initWithString:str attributes:@{NSFontAttributeName: DateOneFont}];
        _priceTF.attributedPlaceholder = attribute;
        _priceTF.layer.borderColor = RGB(194, 195, 196).CGColor;
        _priceTF.layer.borderWidth = 0.5;


        _yuanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _yuanButton.frame = CGRectMake(CGRectGetMaxX(_priceTF.frame)+10, CGRectGetMaxY(titleLabelThree.frame)+10, 40, 21);
        NSString *yuanstr = @"元";
        NSAttributedString *yuanAttribute = [[NSAttributedString alloc]initWithString:yuanstr attributes:@{NSFontAttributeName: DateOneFont,NSForegroundColorAttributeName:[UIColor blackColor]}];
        [_yuanButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_yuanButton setAttributedTitle:yuanAttribute forState:UIControlStateNormal];
        _yuanButton.layer.borderColor = RGB(194, 195, 196).CGColor;
        _yuanButton.layer.borderWidth = 0.5;
        [_yuanButton addTarget:self action:@selector(yuan:) forControlEvents:UIControlEventTouchUpInside];

        [_yuanButton setBackgroundImage:[UIImage imageNamed:@"勾勾"] forState:UIControlStateSelected];



        _kgButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _kgButton.frame = CGRectMake(CGRectGetMaxX(_yuanButton.frame)+10, CGRectGetMaxY(titleLabelThree.frame)+10, 50, 21);
        NSString *kgstr = @"元/kg";
        _kgButton.tag = 0;
        NSAttributedString *kgAttribute = [[NSAttributedString alloc]initWithString:kgstr attributes:@{NSFontAttributeName: DateOneFont,NSForegroundColorAttributeName:[UIColor blackColor]}];
        [_kgButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_kgButton setAttributedTitle:kgAttribute forState:UIControlStateNormal];
        _kgButton.layer.borderColor = RGB(194, 195, 196).CGColor;
        _kgButton.layer.borderWidth = 0.5;
        [_kgButton setBackgroundImage:[UIImage imageNamed:@"勾勾"] forState:UIControlStateSelected];

          [_kgButton addTarget:self action:@selector(kg:) forControlEvents:UIControlEventTouchUpInside];


        UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"跳过" style:UIBarButtonItemStylePlain target:self action:@selector(push:)];
        self.navigationItem.rightBarButtonItem = item;


        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(10,CGRectGetMaxY(_kgButton.frame)+30,BYSScreenWidth-10-10, 30);
        sureButton.backgroundColor = NavigationColor;
        [sureButton setTitle:@"下一步" forState:UIControlStateNormal];
        sureButton.layer.cornerRadius = 5;
        [sureButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];


        [_tableFootView addSubview:titleLabel];
        [_tableFootView addSubview:_textView];
        [_tableFootView addSubview:_titleLabelTwo];
        [_tableFootView addSubview:photoButton];
        [_tableFootView addSubview:lineLabel];
        [_tableFootView addSubview:titleLabelThree];
        [_tableFootView addSubview:_priceTF];
        [_tableFootView addSubview:_yuanButton];
        [_tableFootView addSubview:_kgButton];
        [_tableFootView addSubview:sureButton];





    }
    return _tableFootView;
}
- (void)push:(UIButton *)sender
{
//    [self.navigationController pushViewController:[ContentViewController new] animated:YES];
     [self.navigationController pushViewController:[ContentViewController new] animated:YES];
}
- (void)yuan:(UIButton *)sender
{

    sender.selected = YES;
    self.kgButton.selected = NO;
    self.kgButton.layer.borderColor =  RGB(194, 195, 196).CGColor;
    sender.layer.borderColor = [UIColor clearColor].CGColor;
}

- (void)kg:(UIButton *)sender
{
    sender.selected = YES;
    self.yuanButton.selected = NO;
    self.yuanButton.layer.borderColor =  RGB(194, 195, 196).CGColor;

    sender.layer.borderColor = [UIColor clearColor].CGColor;

}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.liftTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger index = indexPath.row;

     _cell = [tableView dequeueReusableCellWithIdentifier:@"DateOneTableViewCell" forIndexPath:indexPath];
    if (!_cell) {
        _cell = [[DateOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DateOneTableViewCell"];
    }
    _cell.liftLabel.text = self.liftTitleArray[indexPath.row];
    _cell.liftLabel.font = DateOnebigFont;

    NSString *str = @"必填";
    NSAttributedString  *attribute =[[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];

    _cell.minTF.delegate = self;


    switch (index) {
        case 0:
              _cell.minTF.userInteractionEnabled = NO;
              [_cell.rightButton setImage:[UIImage imageNamed:@"sao_yi_sao"] forState:UIControlStateNormal];
            _cell.rightButton.userInteractionEnabled = NO;
            break;
        case 1:
            _cell.minTF.attributedPlaceholder = attribute;
            break;

        case 3:
            _cell.minTF.userInteractionEnabled = NO;

            [_cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            _cell.minTF.attributedPlaceholder = attribute;

            break;
        case 4:
            [_cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            _cell.minTF.userInteractionEnabled = NO;

            break;
        case 7:
            _cell.minTF.userInteractionEnabled = NO;

            [_cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            break;
        case 9:
            _cell.minTF.userInteractionEnabled = NO;

            [_cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            _cell.minTF.attributedPlaceholder = attribute;

            break;
        case 13:
            [_cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            break;
//        case 0:
//            [cell.rightButton setImage:[UIImage imageNamed:@"sao_yi_sao"] forState:UIControlStateNormal];
//            break;


        default:
            break;
    }
    _cell.selectionStyle = UITableViewCellSelectionStyleNone;


    return _cell;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{




    [textField resignFirstResponder];


    return YES;
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
    self.changLabel.text = [NSString stringWithFormat:@"(%ld/35)",length];
    BOOL reluts;
    reluts = textView.text.length>=35? NO:YES;
    self.textView.editable = reluts;

    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger index = indexPath.row;
    [_textView resignFirstResponder];

    switch (index) {
        case 0:
            [self openScanner];

            break;

        default:
            break;
    }

    
}

- (void)openScanner
{


    //创建参数对象
    LBXScanViewStyle *style = [[LBXScanViewStyle alloc]init];

    //矩形区域中心上移，默认中心点为屏幕中心点
    style.centerUpOffset = 44;

    //扫码框周围4个角的类型,设置为外挂式
    style.photoframeAngleStyle = LBXScanViewPhotoframeAngleStyle_Outer;

    //扫码框周围4个角绘制的线条宽度
    style.photoframeLineW = 6;

    //扫码框周围4个角的宽度
    style.photoframeAngleW = 24;

    //扫码框周围4个角的高度
    style.photoframeAngleH = 24;

    //扫码框内 动画类型 --线条上下移动
    style.anmiationStyle = LBXScanViewAnimationStyle_LineMove;

    //线条上下移动图片
    style.animationImage = [UIImage imageNamed:@"CodeScan.bundle/qrcode_scan_light_green"];

    //SubLBXScanViewController继承自LBXScanViewController
    //添加一些扫码或相册结果处理
    SubLBXScanViewController *vc = [SubLBXScanViewController new];
    vc.style = style;

    vc.isQQSimulator = YES;
    vc.isVideoZoom = YES;

    //    [self.navigationController pushViewController:vc animated:YES];
    [self presentViewController:vc animated:YES completion:nil];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark viewWillAppear
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;



}

- (void)takePhoto:(UIButton *)sender
{
    [self initHeadImageAlertController];
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
//    if (self.getOphoto == 0) {
//
//        [_imageViewButton setBackgroundImage:image forState:UIControlStateNormal];
//
//    }else
//    {
//        [_imageViewButton2 setBackgroundImage:image forState:UIControlStateNormal];
//    }
    [self.photoImageMArray addObject:image];

    if (_photoImageMArray.count != 0) {
        for (int i = 0; i < _photoImageMArray.count; i++) {
            _photoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.titleLabelTwo.frame)+10+i*60,CGRectGetMaxY(_textView.frame)+10, 50,50)];
            _photoImageView.image = _photoImageMArray[i];
            [self.tableFootView addSubview:_photoImageView];

        }
    }
    
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    
    [self base64:image];
    
    
}
- (NSMutableArray *)photoImageMArray
{
    if (!_photoImageMArray) {
        _photoImageMArray = [NSMutableArray arrayWithCapacity:4];

    }
    return _photoImageMArray;
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
