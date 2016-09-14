//
//  FamilyCollectionViewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/20.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MemberIFModel.h"

@interface FamilyCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *familyHDView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *relationLabel;
@property (nonatomic, strong)UIButton *deleteButton;

@property (nonatomic, copy) NSString *member_id;
@property (nonatomic, strong) UIImageView *mainHeadimageview;



@property (nonatomic, strong) MemberIFModel *model;
@property (nonatomic, assign) NSInteger tag;

@end
