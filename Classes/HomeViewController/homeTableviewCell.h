//
//  homeTableviewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/7.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface homeTableviewCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong)UIImageView *imageViewCell;
@property (nonatomic, strong)UILabel *linelabel;

@end
