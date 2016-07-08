//
//  MineTableviewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/8.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MineTableviewCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (strong, nonatomic)UIImageView *imageViewCell;
@property (strong, nonatomic)UILabel *labelCell;
@end
