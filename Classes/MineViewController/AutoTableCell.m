//
//  AutoTableCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "AutoTableCell.h"

@implementation AutoTableCell
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

    _imageViewButton = [[UIButton alloc]initWithFrame:CGRectMake(BYSScreenWidth-10-80,40,80, 80)];
    _imageViewButton.layer.borderWidth = 3.0;
    _imageViewButton.layer.borderColor = [UIColor colorWithRed:46/255.0 green:205/255.0 blue:143/255.0 alpha:1.0].CGColor;
    _imageViewButton.layer.cornerRadius = 40;
    _imageViewButton.layer.masksToBounds = YES;


    _labelCell = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 200, 30)];

    //底线
//    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.contentView.frame.size.height-1, BYSScreenWidth, 1)];
//    lineLabel.backgroundColor = TableviewColor;
//
//
//    [self.contentView addSubview:lineLabel];

    [self.contentView addSubview:_imageViewButton];

    [self.contentView addSubview:_labelCell];
    
}

@end
