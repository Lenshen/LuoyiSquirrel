//
//  MarkTableViewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/15.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HXTagsView.h"
#import "markCellModel.h"


@interface MarkTableViewCell : UITableViewCell
@property (nonatomic,strong) HXTagsView *tagsView;
//@property (nonatomic,strong) NSString *title;
//@property (nonatomic,strong) NSArray *markArray;
//@property (nonatomic,strong) NSArray *tag_idArray;
@property (nonatomic,strong) markCellModel *model;


@property (nonatomic,strong) UILabel *titleLabel;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSArray *)titleArray;

@end
