//
//  AutoTableCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AutoTableCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (strong, nonatomic)UIButton *imageViewButton;
@property (strong, nonatomic)UILabel *labelCell;
@property (strong, nonatomic)UILabel *labelCell2;


@end
