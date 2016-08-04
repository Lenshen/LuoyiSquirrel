//
//  DateThreeFTableViewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/4.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DateThreeFTableViewCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


@property (nonatomic, strong)UILabel *numberLabel;
@property (nonatomic, strong)UITextField *dealersTF;
@property (nonatomic, strong)UITextField *dealersAdrressTF;
@end