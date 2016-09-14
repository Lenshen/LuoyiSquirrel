//
//  GetScoreView.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/9.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol chickCollectionViewDelegate<NSObject>
- (void)chickCollectionViewDelegate:(NSInteger )tag
                     WithId:(NSInteger )preson_id
                        Array:(NSArray *)array;

@end

@interface GetScoreView : UIView
@property (nonatomic)id <chickCollectionViewDelegate> chickDelegate;
@end
