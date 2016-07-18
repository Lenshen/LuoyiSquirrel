//
//  MineEndTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MineEndTableViewCell.h"

@implementation MineEndTableViewCell\

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
    _firstLabel = [[UILabel alloc]initWithFrame:CGRectMake(15, 15, 80, 30)];

    _endLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.contentView.bounds.size.width-30-100, 0, 100, 50)];
    _endLabel.textAlignment = NSTextAlignmentRight;


//    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.contentView.frame.size.height-1, BYSScreenWidth, 1)];
//    _lineLabel.backgroundColor = TableviewColor;
//
//
//    [self.contentView addSubview:_lineLabel];
    [self.contentView addSubview:_endLabel];
    [self.contentView addSubview:_firstLabel];


}



@end
