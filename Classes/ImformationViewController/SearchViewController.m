//
//  SearchViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/12.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//
#import "SearchViewController.h"
@interface SearchViewController()<UITableViewDelegate,UITableViewDataSource,UISearchControllerDelegate,UISearchResultsUpdating,UIScrollViewDelegate>

//tableView
@property (strong, nonatomic)  UITableView *tableView;

//searchController
@property (strong, nonatomic)  UISearchController *searchController;

//数据源
@property (strong,nonatomic) NSMutableArray  *dataList;

@property (strong,nonatomic) NSMutableArray  *searchList;

@property (strong,nonatomic) UIView *headView;

@property (strong,nonatomic) UIButton *headButton;



@end

@implementation SearchViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    self.navigationController.navigationBarHidden = YES;

}
- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    self.navigationController.navigationBarHidden = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.tableView.scrollEnabled = YES;



    [self getData];
    

    self.tableView.tableHeaderView = self.headView;
//    [self.headView addSubview:self.searchController.searchBar];

    [self setSearchBar];
//    [self.view addSubview:self.headView];

    [self.view addSubview:self.tableView];

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    self.headView.hidden = YES;
}
- (void)getData
{
    _dataList = [NSMutableArray array];
    _searchList = [NSMutableArray array];

    self.dataList=[NSMutableArray arrayWithCapacity:100];

    for (NSInteger i=0; i<100; i++) {
        [self.dataList addObject:[NSString stringWithFormat:@"%ld%@",(long)i,[self shuffledAlphabet]]];
    }


}
- (UIView *)headView
{
    if (!_headView) {
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 64)];
        _headView.backgroundColor = NavigationColor;
        _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _headButton.frame = CGRectMake(10, 19+4, BYSScreenWidth-10-10, 30);
        _headButton.backgroundColor = [UIColor redColor];
        [_headButton addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside];
        [_headButton setImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];

        [_headView addSubview:_headButton];


    }

    return _headView;
}


- (UISearchController *)searchController
{
    if (!_searchController) {

        //创建UISearchController
        _searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
        //设置
        _searchController.delegate = self;
        _searchController.searchResultsUpdater= self;

        //设置UISearchController的显示属性，以下3个属性默认为YES
        //搜索时，背景变暗色
        _searchController.dimsBackgroundDuringPresentation = NO;
        //搜索时，背景变模糊
        _searchController.obscuresBackgroundDuringPresentation = YES;
        //隐藏导航栏
        _searchController.hidesNavigationBarDuringPresentation = YES;

        _searchController.searchBar.frame = CGRectMake(0,0, self.searchController.searchBar.frame.size.width, 44.0);
//        _searchController.searchBar =
//         _searchController.searchBar.placeholder = @"搜索";


        
        // 添加 searchbar 到 headerview


    }
    return _searchController;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, BYSScreenHeight-20) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;


        _tableView.separatorStyle = UITableViewCellSelectionStyleNone;

    }
    return _tableView;
}
- (void)test:(id)sender
{
    self.headView.frame = CGRectMake(0, 0, BYSScreenWidth, 60);
    _headView.backgroundColor = NavigationColor;

    self.headButton.hidden = YES;
    self.tableView.tableHeaderView = self.searchController.searchBar;
    [self.searchController setActive:YES];


}
- (NSString *)shuffledAlphabet {

    NSMutableArray * shuffledAlphabet = [NSMutableArray arrayWithArray:@[@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"]];

    NSString *strTest = [[NSString alloc]init];
    for (int i=0; i<3; i++) {
        int x = arc4random() % 25;
        strTest = [NSString stringWithFormat:@"%@%@",strTest,shuffledAlphabet[x]];
    }

    return strTest;

}


//设置区域的行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searchController.active) {
        return [self.searchList count];
    }else{
        return [self.dataList count];
    }
}

//返回单元格内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *flag=@"cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:flag];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:flag];
    }
    if (self.searchController.active) {
        [cell.textLabel setText:self.searchList[indexPath.row]];
    }
    else{
        [cell.textLabel setText:self.dataList[indexPath.row]];
    }
    return cell;
}

#pragma mark - UISearchControllerDelegate代理

//测试UISearchController的执行过程

- (void)willPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"willPresentSearchController");
    self.tableView.tableHeaderView = self.headView;

}

- (void)didPresentSearchController:(UISearchController *)searchController
{
    NSLog(@"didPresentSearchController");

}

- (void)willDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"willDismissSearchController");

    self.headView.frame = CGRectMake(0, 0, BYSScreenWidth, 64);
    self.headView.backgroundColor = NavigationColor;
    self.headButton.hidden = NO ;
    [self.navigationController popToRootViewControllerAnimated:YES];







}
- (void)didDismissSearchController:(UISearchController *)searchController
{
    NSLog(@"didDismissSearchController");
}

- (void)presentSearchController:(UISearchController *)searchController
{
    NSLog(@"presentSearchController");
}


-(void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    NSLog(@"updateSearchResultsForSearchController");
    NSString *searchString = [self.searchController.searchBar text];
    NSPredicate *preicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchString];
    if (self.searchList!= nil) {
        [self.searchList removeAllObjects];
    }
    //过滤数据
    self.searchList= [NSMutableArray arrayWithArray:[_dataList filteredArrayUsingPredicate:preicate]];
    //刷新表格
    [self.tableView reloadData];
}


- (void)setSearchBar
{

    _searchController.searchBar.backgroundColor = NavigationColor;
    [[[[ _searchController.searchBar.subviews objectAtIndex:0]subviews] objectAtIndex : 0 ] removeFromSuperview ];
    //2.
    for (UIView *subview in _searchController.searchBar.subviews)
    {
        if ([subview isKindOfClass:NSClassFromString(@"UISearchBarBackground")])
        {
            [subview removeFromSuperview];
            break;
        }
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}





@end
