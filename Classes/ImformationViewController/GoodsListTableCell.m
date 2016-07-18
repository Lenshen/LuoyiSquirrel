//
//  GoodsListTableCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "GoodsListTableCell.h"

@implementation GoodsListTableCell
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

    _imageViewCell = [[UIImageView alloc]initWithFrame:CGRectMake(10,10,100, 70)];
    _imageViewCell.backgroundColor = NavigationColor;
    _imageViewCell.layer.cornerRadius = 5;
    _imageViewCell.layer.masksToBounds = YES;

    _labelCell = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageViewCell.frame)+10, 10, 100, 30)];
    _scoreLabel= [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_imageViewCell.frame)+10, CGRectGetMaxY(_labelCell.frame)+20, 100, 30)];

    _scoreButton = [[UIButton alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-100,CGRectGetMaxY(_imageViewCell.frame)-10-30, 100, 30)];
    _scoreButton.backgroundColor = NavigationColor;
    [_scoreButton setTitle:@"为我打分" forState:UIControlStateNormal];
    _scoreButton.layer.cornerRadius = 5;
    _scoreButton.layer.masksToBounds = YES;


    
//    _lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.contentView.frame.size.height-1, BYSScreenWidth, 1)];
//    _lineLabel.backgroundColor = TableviewColor;


//    [self.contentView addSubview:_lineLabel];

    [self.contentView addSubview:_imageViewCell];
    [self.contentView addSubview:_scoreButton];

    [self.contentView addSubview:_labelCell];
    [self.contentView addSubview:_scoreLabel];
    
}

@end
