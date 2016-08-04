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
#define DateOnebigFont [UIFont systemFontOfSize:15]

#define DateOneFont [UIFont systemFontOfSize:13]

@interface DateWriteOneViewController ()<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

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



        UILabel *titleLabelTwo = [[UILabel alloc]initWithFrame:CGRectMake(10,CGRectGetMaxY(_textView.frame)+20, 100, 21)];
        titleLabelTwo.text = @"上传照片";
        titleLabelTwo.textAlignment = NSTextAlignmentLeft;
        titleLabelTwo.font = DateOnebigFont;




        UIButton *photoButton = [UIButton buttonWithType:UIButtonTypeCustom];
        photoButton.frame = CGRectMake(BYSScreenWidth-10-50, CGRectGetMaxY(_textView.frame)+10, 50, 50);
        [photoButton setBackgroundImage:[UIImage imageNamed:@"post_photo"] forState:UIControlStateNormal];

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





        UIButton *sureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        sureButton.frame = CGRectMake(10,CGRectGetMaxY(_kgButton.frame)+30,BYSScreenWidth-10-10, 30);
        sureButton.backgroundColor = NavigationColor;
        [sureButton setTitle:@"下一步" forState:UIControlStateNormal];
        sureButton.layer.cornerRadius = 5;
        [sureButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];


        [_tableFootView addSubview:titleLabel];
        [_tableFootView addSubview:_textView];
        [_tableFootView addSubview:titleLabelTwo];
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
    [self.navigationController pushViewController:[DateWriteTwoViewController new] animated:YES];
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
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textView resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.liftTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSInteger index = indexPath.row;

    DateOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"DateOneTableViewCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[DateOneTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DateOneTableViewCell"];
    }
    cell.liftLabel.text = self.liftTitleArray[indexPath.row];
    cell.liftLabel.font = DateOnebigFont;

    NSString *str = @"必填";
    NSAttributedString  *attribute =[[NSAttributedString alloc]initWithString:str attributes:@{NSForegroundColorAttributeName:[UIColor redColor]}];




    switch (index) {
        case 0:
              [cell.rightButton setImage:[UIImage imageNamed:@"sao_yi_sao"] forState:UIControlStateNormal];
            break;
        case 1:
            cell.minTF.attributedPlaceholder = attribute;
            break;

        case 3:
            [cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            cell.minTF.attributedPlaceholder = attribute;

            break;
        case 4:
            [cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            break;
        case 7:
            [cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            break;
        case 9:
            [cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            cell.minTF.attributedPlaceholder = attribute;

            break;
        case 13:
            [cell.rightButton setImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
            break;
//        case 0:
//            [cell.rightButton setImage:[UIImage imageNamed:@"sao_yi_sao"] forState:UIControlStateNormal];
//            break;


        default:
            break;
    }



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
    self.changLabel.text = [NSString stringWithFormat:@"(%ld/35)",length];
    BOOL reluts;
    reluts = textView.text.length>=35? NO:YES;
    self.textView.editable = reluts;

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [_textView resignFirstResponder];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = NO;
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
