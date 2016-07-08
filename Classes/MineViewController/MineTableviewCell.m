//
//  MineTableviewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MineTableviewCell.h"

@implementation MineTableviewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{

    _imageViewCell = [[UIImageView alloc]initWithFrame:CGRectMake(10,10,25, 25)];
    _labelCell = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageViewCell.frame)+20, CGRectGetMinY(_imageViewCell.frame), 200, 30)];
    
    [self.contentView addSubview:_imageViewCell];

    [self.contentView addSubview:_labelCell];

}
@end
