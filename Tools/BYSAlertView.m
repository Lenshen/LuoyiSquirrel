//
//  BYSAlertView.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/14.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "BYSAlertView.h"

@implementation BYSAlertView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame 
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configUI];
        self.backgroundColor = [UIColor whiteColor];


    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame titleString:(NSString *)titleString messageSting:(NSString *)messageSting buttonTitle:(NSString *)buttonTitle
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.titleSting = titleString;
        self.messageSting = messageSting;
        self.buttonTitle = buttonTitle;
        [self configUI];


}

    return self;
}
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self configUI];
        self.backgroundColor = [UIColor whiteColor];


    }
    return self;
}

- (void)configUI
{





    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(self.center.x-50, 10, 100, 40)];
    label.text = self.titleSting;
    label.font = [UIFont systemFontOfSize:18];

    UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(label.frame)+20,BYSScreenWidth-15*4, 1)];
    linelabel.backgroundColor = NavigationColor;

    UILabel *textlabel = [[UILabel alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(linelabel.frame)+20,BYSScreenWidth-15*4, 60)];
    textlabel.numberOfLines = 2;
    textlabel.text = self.messageSting;
    textlabel.textAlignment = NSTextAlignmentCenter;

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(CGRectGetMinX(label.frame)-40,CGRectGetMaxY(textlabel.frame)+20,160, 50);
    button.backgroundColor = NavigationColor;
    [button setTitle:self.buttonTitle forState:UIControlStateNormal];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 5.0;
    button.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;


    [self addSubview:label];
    [self addSubview:linelabel];
    [self addSubview:textlabel];
    [self addSubview:button];


}

@end
