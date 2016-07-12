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


@interface SettingViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic)UITableView *tableView;
@property (strong,nonatomic)NSArray *labelArray;
@property (strong,nonatomic)UIView *exitView;


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

    self.tableView.scrollEnabled = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.exitView];



}
- (UIView *)exitView
{
    if (!_exitView) {
        _exitView = [[UIView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame)+10, BYSScreenWidth, rowheight+5)];
        _exitView.backgroundColor = [UIColor whiteColor];

        UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth/2-35,15, 70, 30)];
        textLabel.text = @"退出登陆";
        textLabel.textColor = [UIColor redColor];

        UIImageView *iamgeview =[[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(textLabel.frame)-10-18, 23, 15, 16)];
        iamgeview.image = [UIImage imageNamed:@"exit"];

        [_exitView addSubview:textLabel];
        [_exitView addSubview:iamgeview];




    }
    return _exitView;
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0,10, BYSScreenWidth, rowheight*self.labelArray.count) style:UITableViewStylePlain];
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


#pragma mark tabledelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.labelArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return rowheight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{



    if (indexPath.row == 3) {

        MineEndTableViewCell *cell1 =  [tableView dequeueReusableCellWithIdentifier:@"MineEndTableViewCell" forIndexPath:indexPath];
        if (!cell1) {
            cell1 = [[MineEndTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"MineEndTableViewCell"];
        }

        cell1.firstLabel.text = self.labelArray[indexPath.row];
        [self getCacheSize:cell1.endLabel];
        cell1.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell1.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell1;





    }else
    {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CustomCell" forIndexPath:indexPath];
        if (!cell) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CustomCell"];
        }

      cell.textLabel.text = self.labelArray[indexPath.row];
      cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
         return cell;

    }


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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
