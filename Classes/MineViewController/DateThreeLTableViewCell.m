//
//  DateThreeLTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/4.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "DateThreeLTableViewCell.h"

@implementation DateThreeLTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}
- (void)configUI
{
    _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 20, 35)];

    UILabel *lable = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth/2-60, 20, 120, 21)];
    lable.text = @"添加一个经销商";
    lable.textAlignment = NSTextAlignmentCenter;
    lable.font = [UIFont systemFontOfSize:15];
    lable.textColor = [UIColor grayColor];

    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(CGRectGetMinX(lable.frame)-10-20, 20, 20, 20)];
    imageview.image = [UIImage imageNamed:@"add"];

    [self.contentView addSubview:lable];
    [self.contentView addSubview:imageview];
    [self.contentView addSubview:_numberLabel];

}
@end
