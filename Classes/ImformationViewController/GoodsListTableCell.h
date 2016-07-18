//
//  GoodsListTableCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GoodsListTableCell : UITableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
@property (strong, nonatomic)UIImageView *imageViewCell;
@property (strong, nonatomic)UILabel *labelCell;
@property (strong, nonatomic)UILabel *lineLabel;
@property (strong, nonatomic)UILabel *scoreLabel;
@property (strong, nonatomic)UIButton *scoreButton;



@end
