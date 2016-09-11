//
//  NoGoodsView.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/9/10.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^NomalPost)(NSInteger tag);

@interface NoGoodsView : UIView

@property (nonatomic, copy)NomalPost nomalPostBlock;



@end
