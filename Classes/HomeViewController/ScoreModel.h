//
//  ScoreModel.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/26.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface ScoreModel : JSONModel

@property (nonatomic, strong) NSString *remark;
@property (nonatomic, strong) NSString *user_score;
@property (nonatomic, strong) NSString *goods_score;


@end
