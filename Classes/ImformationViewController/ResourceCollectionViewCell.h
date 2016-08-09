//
//  ResourceCollectionViewCell.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/5.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ResourceModel.h"
@protocol OpenGoodsDelegate<NSObject>

- (void)openGoodsViewController:(NSInteger )tag;

@end


@interface ResourceCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong)UILabel *titileLabel;
@property (nonatomic, strong)UIButton *listButton;
@property (nonatomic, assign)CGSize buttonSize;
@property (nonatomic, strong)ResourceModel *model;
@property (nonatomic, weak)id <OpenGoodsDelegate> delegate;


@end
