//
//  MessageTableViewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/17.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageTableViewCell : UITableViewCell

@property (nonatomic, strong)UILabel *timeLable;
@property (nonatomic, strong)UIView *contendView;
@property (nonatomic, strong)UIImageView *leftImageView;
@property (nonatomic, strong)UILabel *titleLable;
@property (nonatomic, strong)UILabel *messageLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;

@end
