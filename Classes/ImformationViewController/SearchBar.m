//
//  SearchBar.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/9/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "SearchBar.h"
@interface SearchBar()

@property (nonatomic, strong)UILabel *lineLabel;
@property (nonatomic, strong)UIButton *materialbutton;
@property (nonatomic, strong)UIButton *goodsButton;
@property (nonatomic, strong)UIButton *contentGoodsButton;
@property (nonatomic, strong)UIView *putdownView;

@end


@implementation SearchBar

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {

        self.backgroundColor = NavigationColor;





        _putdownView = [[UIView alloc]initWithFrame:CGRectMake(15, 25, 45, 32)];
        //        _putdownView.backgroundColor = [UIColor redColor];

     


        //
        //       _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 32*2, CGRectGetWidth(self.putdownView.frame), 0.7)];
        //        _lineLabel.backgroundColor = TableviewColor;
        //        _lineLabel.alpha = 0;
        //        [self.putdownView addSubview:_lineLabel];




        _materialbutton =[UIButton buttonWithType:UIButtonTypeSystem];
        _materialbutton.frame = CGRectMake(15,CGRectGetMaxY(_contentGoodsButton.frame), 45, 32);
        [_materialbutton setTitle:@"原料" forState:UIControlStateNormal];
        _materialbutton.layer.borderWidth = 0.5;
        _materialbutton.layer.borderColor = TableviewColor.CGColor;
        _materialbutton.backgroundColor = RGB(254, 255, 255);
        //        _materialLabel.textAlignment = NSTextAlignmentCenter;
        //        _materialLabel.font = [UIFont systemFontOfSize:14];
        _materialbutton.alpha = 0;
        _materialbutton.tag = 2;
        [_materialbutton addTarget:self action:@selector(chickTap:) forControlEvents:UIControlEventTouchUpInside];




        _goodsButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _goodsButton.frame = CGRectMake(15,CGRectGetMaxY(_materialbutton.frame), 45, 32);
        [_goodsButton setTitle:@"商品2" forState:UIControlStateNormal];
        _goodsButton.layer.borderWidth = 0.5;
        _goodsButton.layer.borderColor = TableviewColor.CGColor;
        _goodsButton.backgroundColor = RGB(254, 255, 255);
        _goodsButton.tag = 3;
        [_goodsButton addTarget:self action:@selector(chickTap:) forControlEvents:UIControlEventTouchUpInside];



        //        _goodsLabel.font = [UIFont systemFontOfSize:14];
        _goodsButton.alpha = 0;



        UIButton *cancelButton = [UIButton buttonWithType:UIButtonTypeSystem];

        cancelButton.frame = CGRectMake(BYSScreenWidth-40-10, 25, 40, 32);

        [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
        [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [cancelButton addTarget:self action:@selector(dissmiss:) forControlEvents:UIControlEventTouchUpInside];

        _textfield = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_putdownView.frame), 25, BYSScreenWidth-cancelButton.frame.size.width-10-20-60, CGRectGetHeight(_putdownView.frame))];
        _textfield.backgroundColor = [UIColor whiteColor];
        
        
        
        
        [self addSubview:_textfield];
        [self addSubview:_putdownView];

    }
    return self;
}

@end
