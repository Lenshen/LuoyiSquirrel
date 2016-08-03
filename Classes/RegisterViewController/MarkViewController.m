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
static NSString* markReuseIdentifier = @"markReuseIdentifier";
@interface MarkViewController ()<UITableViewDelegate,UITableViewDataSource,HXTagsViewDelegate>
@property (nonatomic,strong) UITableView *tableView;
@end

@implementation MarkViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableView];

    
}
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView  = [[UITableView alloc]initWithFrame:self.view.frame];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 200;
        [_tableView registerClass:[MarkTableViewCell class] forCellReuseIdentifier:markReuseIdentifier];

    }
    return _tableView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MarkTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:markReuseIdentifier forIndexPath:indexPath];
    if (!cell) {
      cell = [[MarkTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:markReuseIdentifier ];
    }
    cell.titileArray = @[@"冒险岛",@"反恐精英ol",@"魔域",@"诛仙",@"火影ol",@"问道",@"天龙八部",@"枪神纪",@"英魂之刃",@"勇者大冒险",@"nba 2k",@"上古世纪"];
    [cell.tagsView setTagDelegate:self];
    CGSize size = cell.tagsView.frame.size;
    CGFloat height = size.height+10+30+10;
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



    if (sender.selected) {
        sender.layer.borderColor = [UIColor clearColor].CGColor;

    }else
    {
        sender.layer.borderColor = [UIColor grayColor].CGColor;
        
    }
    
    
    
    
    
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
