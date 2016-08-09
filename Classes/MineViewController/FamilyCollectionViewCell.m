//
//  FamilyCollectionViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/20.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "FamilyCollectionViewCell.h"

@implementation FamilyCollectionViewCell
- (UIImageView *)familyHDView
{
    if (!_familyHDView) {
        _familyHDView = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 70, 70)];
        _familyHDView.layer.cornerRadius = _familyHDView.frame.size.height/2;
        _familyHDView.layer.masksToBounds = YES;
        _familyHDView.layer.borderColor = RGB(197, 199, 200).CGColor;
        _familyHDView.layer.borderWidth = 0.8;
    }
    return _familyHDView;
}
- (UILabel *)nameLabel
{
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_familyHDView.frame), CGRectGetMaxY(_familyHDView.frame)+10, _familyHDView.frame.size.width+20, 21)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.font =[UIFont systemFontOfSize:15];
    }
    return _nameLabel;
}
- (UILabel *)relationLabel
{
    if (!_relationLabel) {
        _relationLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMinX(_familyHDView.frame), CGRectGetMaxY(_nameLabel.frame)+5, _familyHDView.frame.size.width+20, 21)];;
        _relationLabel.textAlignment = NSTextAlignmentCenter;
        _relationLabel.font =[UIFont systemFontOfSize:15];


    }
    return _relationLabel;
}
@end
