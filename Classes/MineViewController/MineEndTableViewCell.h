//
//  MineEndTableViewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineEndTableViewCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic, strong) UILabel *firstLabel;
@property (nonatomic, strong) UILabel *lineLabel;


@property (nonatomic, strong) UILabel *endLabel;
@end
