//
//  homeTableviewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/7.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "homeTableviewCell.h"

@implementation homeTableviewCell
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
   _imageViewCell = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth, 180-10)];

    _linelabel = [[UILabel alloc]initWithFrame:CGRectMake(0,180-10, BYSScreenWidth, 10)];

    [self.contentView addSubview:_imageViewCell];
    [self.contentView addSubview:_linelabel];


}

@end
