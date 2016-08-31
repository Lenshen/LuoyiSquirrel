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
#import "BYSHttpParameter.h"
#import "BYSHttpTool.h"
#import "AutoModel.h"
#import "UIButton+WebCache.h"
#import "MineEndTableViewCell.h"
#import "BYSAlertView.h"

typedef  NS_ENUM(NSInteger,getOphoto)
{

     imageViewButton,
    imageViewButton2,

};
static NSString *AutoCellString = @"autoCellString";
static NSString *AutoCellimageString = @"AutoCellimageString";

@interface AuthViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate,UITextFieldDelegate>

@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)NSArray *firstLabelTitleA;


@property (strong,nonatomic)NSArray *endLabelTitle;

@property (strong,nonatomic)UIView *footview;

@property (nonatomic)getOphoto getOphoto;
@property (strong, nonatomic)UIButton *imageViewButton;
@property (strong, nonatomic)UIButton *imageViewButton2;

@property (strong, nonatomic)UIButton *postDateButton;


@property (nonatomic,strong) UIImagePickerController *imagePickerController;
@property (nonatomic, strong) AutoTableCell *cell;
@property (nonatomic, strong) MineEndTableViewCell *cell2;
@property (nonatomic, strong) AutoModel *model;


@property (nonatomic, copy) NSString *base64One;
@property (nonatomic, copy) NSString *base64Two;

@property (nonatomic, copy) NSString *mobileStr;
@property (nonatomic, copy) NSString *addressStr;


@property (nonatomic) BOOL isHave;
@property (nonatomic,strong) BYSAlertView *alertView;


@end


@implementation AuthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor =[UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"认证";
    self.view.backgroundColor = TableviewColor;





}

- (void)viewWillAppear:(BOOL)animated{

    // Called when the view is about to made visible. Default does nothing
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = NO;



    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = self.footview;

    _postDateButton = [[UIButton alloc]initWithFrame:CGRectMake(10,BYSScreenHeight-10-30,BYSScreenWidth-10-10, 30)];
    _postDateButton.backgroundColor = NavigationColor;
    [_postDateButton setTitle:@"提交" forState:UIControlStateNormal];
    _postDateButton.layer.cornerRadius = 5;
    [_postDateButton addTarget:self action:@selector(postData:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_postDateButton];
    NSMutableArray *mutoArray = [NSMutableArray new];

    [BYSHttpTool POST:APP_member_service Parameters:[BYSHttpParameter api_get_certification] Success:^(id responseObject) {

        NSDictionary *dic = responseObject[@"data"];
        self.model = [self.model initWithDictionary:dic error:nil];
        NSLog(@"%@------%@-------%@",self.model,responseObject,dic);
        [USER_DEFAULT setObject:self.model.id_card forKey:@"id_care_image"];
        [USER_DEFAULT setObject:self.model.certification
                         forKey:@"certification"];

        [mutoArray addObject:self.model.mobile];
        [mutoArray addObject:self.model.address];
        [mutoArray addObject:@""];
        [mutoArray addObject:@""];


        self.addressStr = self.model.address;
        self.mobileStr = self.model.mobile;


        self.endLabelTitle = [mutoArray copy];
        [self.tableView reloadData];




    } Failure:^(NSError *error) {
        
    }];
    
    
    //去除导航栏下方的横线
    
}



- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:YES];

    
}

#pragma mark 初始化空间

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
//


        [_footview addSubview:label];
        [_footview addSubview:lineLabel];
    }
    return _footview;
}



- (AutoModel *)model
{

    if (!_model) {
        _model = [AutoModel new];
    }
    return _model;
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




#pragma mark tableviewDelegate

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
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;

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


            if ([USER_DEFAULT objectForKey:@"id_care_image"]) {
                [_imageViewButton sd_setImageWithURL:[NSURL URLWithString:[USER_DEFAULT objectForKey:@"id_care_image"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"test"]];
                NSLog(@"%@",[USER_DEFAULT objectForKey:@"id_care_image"]);
                
            }else
            {
            [_imageViewButton setBackgroundImage:[UIImage imageNamed:@"id_card"] forState:UIControlStateNormal];
            }



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
            
            if ([USER_DEFAULT objectForKey:@"id_care_image"]) {
                [_imageViewButton2 sd_setImageWithURL:[NSURL URLWithString:[USER_DEFAULT objectForKey:@"certification"]] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"test"]];

            }else
            {
                [_imageViewButton2 setBackgroundImage:[UIImage imageNamed:@"other_id_card"] forState:UIControlStateNormal];
            }



        }


        return _cell;

    }else
    {
   _cell2 = [tableView dequeueReusableCellWithIdentifier:AutoCellString];
    if (!_cell2) {
        _cell2 = [[MineEndTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AutoCellString];
    }

    _cell2.firstLabel.text = self.firstLabelTitleA[indexPath.row];
    _cell2.textfield.tag = indexPath.row;
    _cell2.textfield.text = self.endLabelTitle[indexPath.row];
    _cell2.textfield.delegate = self;
    _cell2.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    _cell2.selectionStyle = UITableViewCellSelectionStyleNone;

    return _cell2;
    }

    
}


#pragma mark  textFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%ld",textField.tag);

    if (textField.tag == 0) {
        self.mobileStr = textField.text;
    }else
    {
        self.addressStr = textField.text;
    }

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{

    [textField resignFirstResponder];
    return YES;
}


#pragma mark 图片
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
        self.base64One =  [self base64:image];
        [BYSHttpTool POST:APP_member_certification Parameters:[BYSHttpParameter api_member_certificationWithBase64Str:self.base64One type:@"1"] Success:^(id responseObject) {


            NSLog(@"%@",responseObject);




        } Failure:^(NSError *error) {
            
        }];


   }else
   {
       [_imageViewButton2 setBackgroundImage:image forState:UIControlStateNormal];
       self.base64Two =  [self base64:image];
       [BYSHttpTool POST:APP_member_certification Parameters:[BYSHttpParameter api_member_certificationWithBase64Str:self.base64Two type:@"0"] Success:^(id responseObject) {


           NSLog(@"%@",responseObject);


       } Failure:^(NSError *error) {
           
       }];

   }


    [picker dismissViewControllerAnimated:YES completion:nil];
    
    

    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    [_cell2.textfield resignFirstResponder];
}

-(NSString *)base64:(UIImage *)image
{
    NSData *imagedata = UIImageJPEGRepresentation(image, 1.0);
    NSString *imageStr = [imagedata base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    //    self.imageStr = imageStr;
    return imageStr;
    
}


#pragma mark 提交数据

- (void)postData:(UIButton *)sender
{


    [BYSHttpTool POST:APP_member_setAddress Parameters:[BYSHttpParameter api_member_setAddressWithAddress:self.addressStr mobile:self.mobileStr] Success:^(id responseObject) {

        NSLog(@"%@",responseObject);

        [self setAlertUI:@"上传成功"];



    } Failure:^(NSError *error) {

        NSLog(@"%@",error);
        
    }];
}



#pragma mark 提示框

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
