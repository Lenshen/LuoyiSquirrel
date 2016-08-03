//
//  DateOneTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/3.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "DateOneTableViewCell.h"

@implementation DateOneTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifie
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifie];
    if (self) {
        [self configUI];
    }
    return  self;
}

- (void)configUI
{
    _liftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 21)];

    _liftLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 100, 21)];

    _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _rightButton.frame = CGRectMake(BYSScreenHeight-10-20, 10, 20, 20);






    [self.contentView addSubview:_liftLabel];
    [self.contentView addSubview:_rightButton];

}

@end
