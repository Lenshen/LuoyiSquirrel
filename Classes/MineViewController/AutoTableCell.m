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

   


    _labelCell = [[UILabel alloc]initWithFrame:CGRectMake(10, 40, 200, 20)];
    _labelCell2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 60, 200, 20)];



    //底线
//    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(0,self.contentView.frame.size.height-1, BYSScreenWidth, 1)];
//    lineLabel.backgroundColor = TableviewColor;
//
//
//    [self.contentView addSubview:lineLabel];

    [self.contentView addSubview:_imageViewButton];
    [self.contentView addSubview:_imageViewButton2];
    [self.contentView addSubview:_labelCell];
    [self.contentView addSubview:_labelCell2];


}

@end
