//
//  MessageTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/17.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MessageTableViewCell.h"

@implementation MessageTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }

    return self;
}

- (void)configUI
{
    _timeLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 10, BYSScreenWidth, 21)];
    _timeLable.font = [UIFont systemFontOfSize:13];
    _timeLable.backgroundColor = TableviewColor;
    _timeLable.text = @"2017-6-20 19:20";
    _timeLable.textAlignment = NSTextAlignmentCenter;

    _contendView = [[UIView alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_timeLable.frame)+10, BYSScreenWidth-10-10, 80)];
    _contendView.layer.cornerRadius = 10;
    _contendView.layer.borderWidth = 0.7;
    _contendView.layer.borderColor = RGB(197, 199, 200).CGColor;
    _contendView.layer.masksToBounds = YES;
    _contendView.backgroundColor = [UIColor whiteColor];

    _leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 21, 21)];


     UIImageView *rightImage = [[UIImageView alloc]initWithFrame:CGRectMake(_contendView.frame.size.width-10-30, 10, 30, 21)];
    rightImage.contentMode = UIViewContentModeCenter;
    rightImage.image = [UIImage imageNamed:@"arrow_right"];






    _titleLable = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_leftImageView.frame)+10, 10, 200, 21)];
    _titleLable.textAlignment = NSTextAlignmentLeft;
    _titleLable.text = @"系统消息";

    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, CGRectGetMaxY(_leftImageView.frame)+10, _contendView.frame.size.width-5-5, 1)];
    lineLabel.backgroundColor = TableviewColor;

    _messageLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(lineLabel.frame)+10, 200, 21)];
    _messageLabel.textAlignment = NSTextAlignmentLeft;
    _messageLabel.text = @"你有新的健康报告";





    


    





    [self.contentView addSubview:_timeLable];
    [self.contentView addSubview:_contendView];
    [_contendView addSubview:_leftImageView];
    [_contendView addSubview:lineLabel];
    [_contendView addSubview:_messageLabel];
    [_contendView addSubview:_titleLable];
    [_contendView addSubview:rightImage];

}
@end
