//
//  ContentTableViewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/26.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LZFoldButton.h"

@interface ContentTableViewCell : UITableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (nonatomic, strong)LZFoldButton *lifeButton;
@property (nonatomic, strong)UITextField *rightTF;
@end
