//
//  DateOneTableViewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/3.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateOneTableViewCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic, strong)UILabel *liftLabel;
@property (nonatomic, strong)UILabel *minLabel;
@property (nonatomic, strong)UIButton *rightButton;
@end
