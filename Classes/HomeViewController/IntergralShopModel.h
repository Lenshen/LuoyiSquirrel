//
//  IntergralShopModel.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/28.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface IntergralShopModel : JSONModel

@property (nonatomic, copy) NSString *image;
@property (nonatomic, copy) NSString *stock;
@property (nonatomic, copy) NSString *pg_id;
@property (nonatomic, copy) NSString *point;
@property (nonatomic, copy) NSString *name;
@end
