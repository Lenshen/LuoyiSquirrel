//
//  ScoreHistoryTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/9/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ScoreHistoryTableViewCell.h"

@implementation ScoreHistoryTableViewCell

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
    self.leftImageView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 60, 60)];
    self.leftImageView.layer.cornerRadius = self.leftImageView.frame.size.height/2;
    self.leftImageView.layer.masksToBounds = YES;


    self.nick_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+10, 20, 0, 21)];
    self.nick_nameLabel.textAlignment = NSTextAlignmentLeft;
//    self.nick_nameLabel.font = [UIFont systemFontOfSize:15];

    self.goods_nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(self.leftImageView.frame)+10, CGRectGetMaxY(self.nick_nameLabel.frame)+5, 0, 21)];
    self.goods_nameLabel.textAlignment = NSTextAlignmentLeft;
//    self.goods_nameLabel.font = [UIFont systemFontOfSize:15];


    self.rightScoreLabel = [[UILabel alloc]initWithFrame:CGRectMake(BYSScreenWidth-200-10, 30, 200, 21)];
    self.rightScoreLabel.textAlignment = NSTextAlignmentRight;





  


    [self.contentView addSubview:self.leftImageView];
    [self.contentView addSubview:self.nick_nameLabel];
    [self.contentView addSubview:self.goods_nameLabel];
    [self.contentView addSubview:self.rightScoreLabel];


}
@end
