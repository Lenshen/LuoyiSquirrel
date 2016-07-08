//
//  ResourceViewController.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/6.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ResourceViewController.h"
#import "ZXMovieBrowser.h"
#import "homeTableviewCell.h"


@interface ResourceViewController ()<ZXMovieBrowserDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong, readwrite) ZXMovieBrowser *movieBrowser;
@property (nonatomic, strong, readwrite) UILabel *titileLabel;
@property (nonatomic, strong, readwrite) NSMutableArray *movies;
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)NSArray *netImages;





@end

@implementation ResourceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = YES;
//    self.title = @"松鼠日报";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;


    self.tableView.tableHeaderView = [self setupSubviews];
    [self.tableView registerClass:[homeTableviewCell class] forCellReuseIdentifier:@"CustomCell"];
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}
-(NSArray *)netImages{

    if (!_netImages) {
        _netImages =  @[
                        @"http://d.hiphotos.baidu.com/zhidao/pic/item/72f082025aafa40f507b2e99aa64034f78f01930.jpg",
                        @"http://b.hiphotos.baidu.com/zhidao/pic/item/4b90f603738da9770889666fb151f8198718e3d4.jpg",
                        @"http://g.hiphotos.baidu.com/zhidao/pic/item/f2deb48f8c5494ee4e84ef5d2cf5e0fe98257ed4.jpg",
                        @"http://d.hiphotos.baidu.com/zhidao/pic/item/9922720e0cf3d7ca104edf32f31fbe096b63a93e.jpg"
                        ];
    }
    return _netImages;
}
- (UIView *)setupSubviews
{
//    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"movies" ofType:@"plist"];
//    NSArray *dictArray = [NSArray arrayWithContentsOfFile:filePath];

    NSMutableArray *movies = [NSMutableArray array];
   
    for (int i = 0; i < self.netImages.count; i++) {
        ZXMovie *movie = [[ZXMovie alloc] init];
        movie.coverUrl = self.netImages[i];
        [movies addObject:movie];
    }
    self.movies = movies;

    ZXMovieBrowser *movieBrowser = [[ZXMovieBrowser alloc] initWithFrame:CGRectMake(0,0, BYSScreenWidth, kMovieBrowserHeight+10) movies:self.movies currentIndex:1];
    movieBrowser.delegate = self;
    [self.view addSubview:movieBrowser];
    self.movieBrowser = movieBrowser;

    UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,CGRectGetMaxY(movieBrowser.frame), BYSScreenWidth,10)];
    linelabel.backgroundColor = [UIColor whiteColor];
    [movieBrowser addSubview:linelabel];
    return movieBrowser;

}

#pragma mark - ZXMovieBrowserDelegate

- (void)movieBrowser:(ZXMovieBrowser *)movieBrowser didSelectItemAtIndex:(NSInteger)index
{
    NSLog(@"跳转详情页---%@", ((ZXMovie *)self.movies[index]).name);

    UIViewController *movieDetailVc = [[UIViewController alloc] init];
    movieDetailVc.view.backgroundColor = [UIColor whiteColor];
    movieDetailVc.title = ((ZXMovie *)self.movies[index]).name;
    [self.navigationController pushViewController:movieDetailVc animated:YES];
}

- (void)movieBrowser:(ZXMovieBrowser *)movieBrowser didChangeItemAtIndex:(NSInteger)index
{
    NSLog(@"index: %ld", index);

    self.titileLabel.text = ((ZXMovie *)self.movies[index]).name;
}

static NSInteger _lastIndex = -1;
- (void)movieBrowser:(ZXMovieBrowser *)movieBrowser didEndScrollingAtIndex:(NSInteger)index
{
    if (_lastIndex != index) {
        NSLog(@"刷新---%@", ((ZXMovie *)self.movies[index]).name);
    }
    _lastIndex = index;
}


#pragma mark tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    homeTableviewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[homeTableviewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
    }
    cell.imageViewCell.image = [UIImage imageNamed:@"test"];
    cell.linelabel.backgroundColor = [UIColor whiteColor];
    return cell;
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
