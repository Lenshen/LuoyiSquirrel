//
//  NoGoodsView.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/9/10.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "NoGoodsView.h"

@implementation NoGoodsView

- (instancetype) initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = TableviewColor;
        [self configUI];
    }
    return self;
}

- (void) configUI
{
    UILabel *textLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 40, BYSScreenWidth-10-10, 21)];
    textLabel.text = @"没有搜到您的商品";
    textLabel.font = [UIFont systemFontOfSize:15];
    textLabel.textColor = [UIColor grayColor];
    textLabel.textAlignment = NSTextAlignmentCenter;


    UILabel *textLabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(textLabel.frame)+10, BYSScreenWidth-10-10, 21)];
    textLabel1.text = @"您也可以新增商品信息,帮忙完善商品数据哦";
    textLabel1.font = [UIFont systemFontOfSize:15];
    textLabel1.textColor = [UIColor grayColor];
    textLabel1 .textAlignment = NSTextAlignmentCenter;


    UIButton *nomalPostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    nomalPostButton.tag = 0;
    nomalPostButton.frame = CGRectMake(BYSScreenWidth/2-90-30,CGRectGetMaxY(textLabel1.frame)+20,120, 30);
    nomalPostButton.backgroundColor = NavigationColor;

    NSMutableAttributedString *attriString = [[NSMutableAttributedString alloc] initWithString:@"普通会员拍照上传"];
    [attriString addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14]
                        range:NSMakeRange(0, 8)];
    [attriString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 8)];
    [nomalPostButton setAttributedTitle:attriString forState:UIControlStateNormal];
    nomalPostButton.layer.cornerRadius = 5;
    [nomalPostButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];


    UIButton *memberPostButton = [UIButton buttonWithType:UIButtonTypeCustom];
    memberPostButton.frame = CGRectMake(CGRectGetMaxY(nomalPostButton.frame)+30,CGRectGetMinY(nomalPostButton.frame),90, 30);
    memberPostButton.tag = 1;
    memberPostButton.backgroundColor = NavigationColor;

    NSMutableAttributedString *attriString1 = [[NSMutableAttributedString alloc] initWithString:@"专业会员录入"];
    [attriString1 addAttribute:NSFontAttributeName
                        value:[UIFont systemFontOfSize:14]
                        range:NSMakeRange(0, 6)];
    [attriString1 addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, 6)];
    [memberPostButton setAttributedTitle:attriString1 forState:UIControlStateNormal];
    memberPostButton.layer.cornerRadius = 5;
    [memberPostButton addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];




    [self addSubview:nomalPostButton];
    [self addSubview:memberPostButton];

    [self addSubview:textLabel];
    [self addSubview:textLabel1];

    
}

- (void)push:(UIButton *)sender
{

    if (_nomalPostBlock) {
        self.nomalPostBlock(sender.tag);
    }
}
@end
