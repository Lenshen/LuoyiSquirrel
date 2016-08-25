//
//  MemberIFModel.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/23.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MemberIFModel : JSONModel

@property (nonatomic, strong)NSString *nick_name;
@property (nonatomic, strong)NSString *height;
@property (nonatomic, strong)NSString *head_image;
@property (nonatomic, strong)NSString *weight;
@property (nonatomic, strong)NSString *is_default;
@property (nonatomic, strong)NSString *birthday;
@property (nonatomic, strong)NSString *user_id;
@property (nonatomic, strong)NSString *sex;



@end
