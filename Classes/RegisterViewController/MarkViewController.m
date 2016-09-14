//
//  MarkViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/15.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MarkViewController.h"
#import "MarkTableViewCell.h"
#import "HXTagsView.h"
#import "FamilyMGViewController.h"
#import "BYSHttpTool.h"
#import "BYSHttpParameter.h"
#import "markCellModel.h"
#import "UIButton+countDown.h"
#import "FamilyMGViewController.h"
static NSString* markReuseIdentifier = @"markReuseIdentifier";
@interface MarkViewController ()<UITableViewDelegate,UITableViewDataSource,HXTagsViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) NSArray *markArray;
@property (nonatomic,strong) NSArray *tag_idArray;

@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,strong) UIView *tableviewFootView;
@property (nonatomic,strong) NSMutableArray *tagMutoArray;
@property (nonatomic,strong) markCellModel *model;

@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.



    
}
- (UIView *)tableviewFootView
{
    if (!_tableviewFootView) {
        _tableviewFootView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 65)];
        UIButton *jumpButton = [UIButton buttonWithType:UIButtonTypeCustom];
        jumpButton.frame = CGRectMake(10,20, (BYSScreenWidth-10-10-40)/2, 30);
        [jumpButton setTitleColor:NavigationColor forState:UIControlStateNormal];
        [jumpButton setTitle:@"跳过" forState:UIControlStateNormal];
        jumpButton.layer.borderWidth = 1;
        [jumpButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];
        jumpButton.layer.borderColor = NavigationColor.CGColor;

        UIButton *submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        submitButton.frame = CGRectMake(CGRectGetMaxX(jumpButton.frame)+40,20, (BYSScreenWidth-10-10-40)/2, 30);
        submitButton.backgroundColor = NavigationColor;
        [submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [submitButton addTarget:self action:@selector(submit:) forControlEvents:UIControlEventTouchUpInside];

//        submitButton.layer.borderWidth = 1;
//        submitButton.layer.borderColor = NavigationColor.CGColor;

        [_tableviewFootView addSubview:jumpButton];
        [_tableviewFootView addSubview:submitButton];


    }
    return _tableviewFootView;
}
- (void)submit:(UIButton *)sender
{
    [BYSHttpTool POST:APP_tags_updataTags Parameters:[BYSHttpParameter api_tags_updateTaglist_tagsWithTags:self.tagMutoArray] Success:^(id responseObject) {

        NSLog(@"%@",responseObject);
        
    } Failure:^(NSError *error) {
        NSLog(@"%@",error);

    }];

    for (UIViewController *controller in self.navigationController.viewControllers) {
        if ([controller isKindOfClass:[FamilyMGViewController class]]) {
            [self.navigationController popToViewController:controller animated:YES];
        }
    }

    if (self.familyBlock) {
        self.familyBlock();


    }
    
}

- (NSArray *)titleArray
{
    if (!_titleArray) {
        _titleArray = [NSArray array];
    }
    return _titleArray;
}
- (NSArray *)markArray
{
    if (!_markArray) {
        _markArray = [NSArray array];

    }

    return _markArray;
}
- (NSMutableArray *)tagMutoArray
{
    if (!_tagMutoArray) {
        _tagMutoArray = [NSMutableArray array];
    }
    return _tagMutoArray;
}
- (markCellModel *)model
{
    if (!_model) {
        _model = [[markCellModel alloc]init];
    }
    return _model;
}
- (NSArray *)tag_idArray
{
    if (!_tag_idArray) {
        _tag_idArray = [NSArray array];

    }

    return _tag_idArray;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 200;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_tableView registerClass:[MarkTableViewCell class] forCellReuseIdentifier:markReuseIdentifier];

    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:markReuseIdentifier forIndexPath:indexPath];
    if (!cell) {
      cell = [[MarkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:markReuseIdentifier ];
    }
    self.model.markArray = self.markArray[indexPath.row];
    self.model.title = self.titleArray[indexPath.row];
    self.model.tag_idArray = self.tag_idArray[indexPath.row];
    cell.model = self.model;


    [cell.tagsView setTagDelegate:self];
    CGSize size = cell.tagsView.frame.size;
    CGFloat height = size.height+30;
    self.tableView.rowHeight = height;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;


    return cell;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




- (void)tagsViewButtonAction:(HXTagsView *)tagsView button:(UIButton *)sender {
    NSLog(@"tag:%@ index:%ld",sender.titleLabel.text,(long)sender.tag);
    //
    //    HXWebViewController *vc = [[HXWebViewController alloc] init];
    //    vc.keyWord = sender.titleLabel.text;
    //    [self.navigationController pushViewController:vc animated:NO];

        sender.selected = !sender.selected ;
    NSLog(@"%@",sender.tag_id);

    if(sender.selected)
    {
        [self.tagMutoArray addObject:sender.tag_id];

    }else
    {
        [self.tagMutoArray removeObject:sender.tag_id];
    }


    NSLog(@"%@",self.tagMutoArray);





}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    NSMutableArray *tag_classArrayM = [[NSMutableArray alloc]init];
    NSMutableArray *tag_classArrayM3 = [[NSMutableArray alloc]init];
    NSMutableArray *tag_classArrayM6 = [[NSMutableArray alloc]init];




    [BYSHttpTool POST:APP_tags_getlist Parameters:[BYSHttpParameter api_tags_getlist_tags] Success:^(id responseObject) {
        NSLog(@"%@",responseObject);
        NSArray *responseArray = [NSArray array];

        NSDictionary *contentDic = [[NSDictionary alloc]init];

        NSArray *array = [NSArray array];

        NSDictionary *contentDic2 = [[NSDictionary alloc]init];


        responseArray = responseObject[@"data"];


        for (int i = 0; i < responseArray.count; i++) {
            NSMutableArray *tag_classArrayM2 = [[NSMutableArray alloc]init];
            NSMutableArray *tag_classArrayM5 = [[NSMutableArray alloc]init];


            contentDic  = (NSDictionary *)responseArray[i];
            [tag_classArrayM addObject:contentDic[@"tag_class"]];

            array = contentDic[@"tag_values"];
            NSLog(@"%@", array);
            for (int j = 0 ; j < array.count; j++) {

                contentDic2 = array[j];
                [tag_classArrayM2 addObject:contentDic2[@"tag_name"]];
                [tag_classArrayM5 addObject:contentDic2[@"tag_id"]];

            }
            [tag_classArrayM3 addObject:tag_classArrayM2];
            [tag_classArrayM6 addObject:tag_classArrayM5];





        }
        self.titleArray = [tag_classArrayM copy];
        self.markArray = [tag_classArrayM3 copy];
        self.tag_idArray = [tag_classArrayM6 copy];


        [self.tableView reloadData];


    } Failure:^(NSError *error) {
        NSLog(@"%@",error);
        
    }];

    [self.view addSubview:self.tableView];


    self.tableView.tableFooterView = self.tableviewFootView;
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
