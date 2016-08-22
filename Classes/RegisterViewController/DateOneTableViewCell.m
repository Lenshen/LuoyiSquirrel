//
//  DateOneTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/3.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "DateOneTableViewCell.h"

@implementation DateOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifie];
    if (self) {
        [self configUI];
    }
    return  self;
}

- (void)configUI
{
    _liftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 21)];

    _minTF = [[UITextField alloc]initWithFrame:CGRectMake(BYSScreenWidth/2-75, 10,150, 21)];
    _minTF.textAlignment = NSTextAlignmentCenter;
//    _minTF.backgroundColor = [UIColor redColor];
    _minTF.placeholder = @"选填";
    _minTF.font = [UIFont systemFontOfSize:13];

    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(BYSScreenWidth-10-20, 10, 20, 20);



    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, self.contentView.frame.size.height-0.5, BYSScreenWidth-10-10, 0.5)];
    lineLabel.backgroundColor = RGB(194, 195, 196);



    [self.contentView addSubview:_liftLabel];
    [self.contentView addSubview:_rightButton];
    [self.contentView addSubview:_minTF];
    [self.contentView addSubview:lineLabel];

}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [_minTF resignFirstResponder];
}

@end
