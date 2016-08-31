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

    _endLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, BYSScreenWidth-30, 50)];
    _endLabel.textAlignment = NSTextAlignmentRight;

    _textfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_firstLabel.frame), 15,200, 30)];
    _textfield.textAlignment = NSTextAlignmentCenter;

    [self.contentView addSubview:_endLabel];
    [self.contentView addSubview:_textfield];
    [self.contentView addSubview:_firstLabel];


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_textfield resignFirstResponder];
}


@end
