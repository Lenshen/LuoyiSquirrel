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

    UILabel *linelabel = [[UILabel alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(label.frame),BYSScreenWidth-15*4, 1)];
    linelabel.backgroundColor = NavigationColor;

    UILabel *textlabel = [[UILabel alloc]initWithFrame:CGRectMake(15,CGRectGetMaxY(linelabel.frame),BYSScreenWidth-15*4, 60)];
    textlabel.numberOfLines = 2;
    textlabel.text = self.messageSting;
    textlabel.textAlignment = NSTextAlignmentCenter;

    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(self.center.x-65-10,CGRectGetMaxY(textlabel.frame)+20,130, 40);
    _rightButton.backgroundColor = NavigationColor;
    [_rightButton setTitle:self.buttonTitle forState:UIControlStateNormal];
    [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    _rightButton.layer.cornerRadius = 5.0;
    _rightButton.layer.masksToBounds = YES;
    self.layer.cornerRadius = 10;
    self.layer.masksToBounds = YES;


    [self addSubview:label];
    [self addSubview:linelabel];
    [self addSubview:textlabel];
    [self addSubview:_rightButton];


}
- (UIView *)alphaView
{
    if (!_alphaView) {

        _alphaView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _alphaView.backgroundColor = [UIColor blackColor];
        _alphaView.alpha = 0.5;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dissmissAlpha:)];


        [_alphaView addGestureRecognizer:tap];

        
    }
    return _alphaView;
}

- (void)dissmissAlpha:(id)sender
{
    self.alphaView.hidden = YES;
    [self.alphaView removeFromSuperview];
    self.alphaView = nil;
    self.hidden = YES;
    [self removeFromSuperview];
    if (self.chickDissMissButton) {
        self.chickDissMissButton();
    }
}

@end
