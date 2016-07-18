//
//  autoTableTwoCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "autoTableTwoCell.h"

@implementation autoTableTwoCell

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

    _imageViewButton1 = [[UIButton alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-80,40,80, 80)];

    _imageViewButton1.layer.cornerRadius = 10;
    _imageViewButton1.layer.masksToBounds = YES;

    _imageViewButton2 = [[UIButton alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-80,40,80, 80)];

    _imageViewButton2.layer.cornerRadius = 10;
    _imageViewButton2.layer.masksToBounds = YES;


    _labelCell = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];

    _labelCell1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];
    _labelCell2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 30)];



    //底线
    //    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.contentView.frame.size.height-1, BYSScreenWidth, 1)];
    //    lineLabel.backgroundColor = TableviewColor;
    //
    //
    //    [self.contentView addSubview:lineLabel];

    [self.contentView addSubview:_imageViewButton1];
    [self.contentView addSubview:_imageViewButton2];


    [self.contentView addSubview:_labelCell];
    
}


@end
