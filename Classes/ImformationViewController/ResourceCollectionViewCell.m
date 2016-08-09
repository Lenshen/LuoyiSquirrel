//
//  ResourceCollectionViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/5.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ResourceCollectionViewCell.h"
#import "UIButton+Vertical.h"
@implementation ResourceCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {


        _titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10,BYSScreenWidth-10-10-10-10, 21)];
        _titileLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_titileLabel];


    }
    return self;
}


- (void)setModel:(ResourceModel *)model
{


    _model = model;

    _titileLabel.text = model.titleString;




    for (int i=0; i < 12; i++) {


        CGFloat maxWedith = i*self.contentView.frame.size.width/3;

        _listButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _listButton.tag = i;

        if (maxWedith>=self.contentView.frame.size.width) {
               int current = i%3;
               int hegiht = i/3;
              _listButton.frame = CGRectMake(current*self.contentView.frame.size.width/3,31+hegiht*self.buttonSize.height, self.contentView.frame.size.width/3,(self.contentView.frame.size.height-31)/4);
            _listButton.backgroundColor = RANDOMCOLOR;
            
            [self.contentView addSubview:_listButton];
            [_listButton setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];



        }else
        {

            _listButton.frame = CGRectMake(i*self.contentView.frame.size.width/3,31, self.contentView.frame.size.width/3, (self.contentView.frame.size.height-31)/4);
            [self.contentView addSubview:_listButton];
            _listButton.backgroundColor = RANDOMCOLOR;

            [_listButton setTitle:[NSString stringWithFormat:@"%d",i] forState:UIControlStateNormal];

            self.buttonSize = _listButton.frame.size;






        }
        [_listButton verticalImageAndTitle:20];
        [_listButton addTarget:self action:@selector(shopping:) forControlEvents:UIControlEventTouchUpInside];

    }





}
- (void)shopping:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(openGoodsViewController:)])
    {
        [self.delegate openGoodsViewController:sender.tag];
    }
}
@end
