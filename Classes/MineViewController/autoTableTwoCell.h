//
//  autoTableTwoCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface autoTableTwoCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (strong, nonatomic)UIButton *imageViewButton1;
@property (strong, nonatomic)UIButton *imageViewButton2;

@property (strong, nonatomic)UILabel *labelCell;
@property (strong, nonatomic)UILabel *labelCell1;
@property (strong, nonatomic)UILabel *labelCell2;


@end
