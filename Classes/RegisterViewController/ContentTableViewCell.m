//
//  ContentTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/26.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ContentTableViewCell.h"

@implementation ContentTableViewCell

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

  
    _lifeButton = [[LZFoldButton alloc]initWithFrame:CGRectMake(10, 10, 170, 30) dataArray:@[@"酒精度(%)",@"能量(kJ)",@"蛋白质(g)",@"碳水化合物(g)"]];

    _lifeButton.lzFontSize = 12;
//    _lifeButton.lzHeight = 200;
    _lifeButton.layer.borderWidth = 0.7;
    _lifeButton.layer.borderColor = RGB(193, 193, 193).CGColor;
   

    _lifeButton.lzButtonType = LZFoldButtonTypeRight;

    [_lifeButton LZSetTitle:@"请选择" forState:UIControlStateNormal];
    [_lifeButton LZSetTitleColor:RGB(187, 186, 194) forState:UIControlStateNormal];
    [_lifeButton LZSetImage:[UIImage imageNamed:@"address_select"] forState:UIControlStateNormal];
    [_lifeButton LZSetImage:[UIImage imageNamed:@"arrow_right"] forState:UIControlStateSelected];
    [self.contentView addSubview:_lifeButton];


    _rightTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_lifeButton.frame)+10, 10,self.contentView.frame.size.width-10-10-10-170, 30)];
    _rightTF.layer.borderWidth = 0.7;
    _rightTF.layer.borderColor = RGB(193, 193, 193).CGColor;
    _rightTF.placeholder = @"请输入含量";
    [self.contentView addSubview:_rightTF];

    




}



@end
