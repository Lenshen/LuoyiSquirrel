//
//  MessageModel.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/26.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <JSONModel/JSONModel.h>

@interface MessageModel : JSONModel

@property (nonatomic, strong)NSString *type;
@property (nonatomic, strong)NSString *image;
@property (nonatomic, strong)NSString *url;
@property (nonatomic, strong)NSString *text;
@property (assign, nonatomic) BOOL has_image;




@end
