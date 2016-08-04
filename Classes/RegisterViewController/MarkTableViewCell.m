//
//  MarkTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/15.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MarkTableViewCell.h"
#import "HXTagsView.h"

@implementation MarkTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSArray *)titleArray
//{
//    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//    if (self) {
//        
//        self.titileArray = titleArray;
//        NSLog(@"%@",titleArray);
//        [self configUI];
//
//
//    }
//    return self;
//}

- (void)setMarkArray:(NSArray *)titileArray
{
    [self configUI:titileArray];
}

- (void)setTitle:(NSString *)title
{
    _titleLabel.text = title;
}
- (void)configUI:(NSArray *)array

{
//    NSArray  *tagAry = @[@"冒险岛",@"反恐精英ol",@"魔域",@"诛仙",@"火影ol",@"问道",@"天龙八部",@"枪神纪",@"英魂之刃",@"勇者大冒险",@"nba 2k",@"上古世纪",@"跑跑卡丁车",@"传奇世界",@"劲舞团",@"激战2"];
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    _titleLabel.text = self.title;
    [self.contentView addSubview:_titleLabel];

    //单行不需要设置高度,内部根据初始化参数自动计算高度
    _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.origin.y+_titleLabel.frame.size.height, BYSScreenWidth-10, 0)];
    _tagsView.type = 0;
    _tagsView.highlightedBackgroundImage = [UIImage imageNamed:@"勾勾"];
    _tagsView.tag = 1000;
    [_tagsView setTagAry:array delegate:self];
    [self.contentView addSubview:_tagsView];
    

}


@end
