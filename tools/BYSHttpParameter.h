//
//  BYSHttpParameter.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/12.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BYSHttpParameter : NSObject

//   1.发送手机验证码（注册或登录)
+ (NSDictionary *)get_APP_member_send;

//   2.获取token
+ (NSDictionary *)get_APP_member_getToken:(NSString *)code;

//   3.增加基本信息
+ (NSString *)get_APP_member_addInfo_jsonStr:(NSString *)is_default nick_name:(NSString *)nick_name birthday:(NSString *)brithday sex:(NSString *)sex height:(NSString *)height weight:(NSString *)weight;

//  4.修改基本信息
+ (NSString *)get_app_member_changeinfo_user_id:(NSString *)user_id
                                      nick_name:(NSString *)nick_name
                                       birthday:(NSString *)birthday
                                            sex:(NSString *)sex
                                         height:(NSString *)height
                                         weight:(NSString *)weight
                                          token:(NSString *)token
                                     head_image:(NSString *)head_image;

//  5.获取用户默认基本信息
+ (NSString *)get_app_member_service_user_id:(NSString *)user_id;

//  6.获取用户基本信息列表
+ (NSString *)get_app_list;

//  7.设置基本信息为默认
+ (NSString *)get_app_change_isdefault_user_id:(NSString *)user_id;

//  8.删除一个基本信息，不会删除默认基本信息
+ (NSString *)get_app_delet_info_user_id:(NSString *)user_id;

//  9.获取邀请码
+ (NSString *)get_app_get_code;

//  10.兑换邀请码
+ (NSString *)api_exchange_code:(NSString *)code;

//  11.签到
+ (NSString *)api_sign_in;

//  12.获取签到信息
+ (NSString *)api_get_sign;

//  13.获取积分信息
+ (NSString *)api_get_point;

//  14.获取首页轮番广告

+ (NSDictionary *)api_getAdvert_spaceCode:(NSString *)spaceCode;


+ (NSString *)api_tags_getlist_tags;

+ (NSString *)api_comment_addCommentWithGoods_id:(NSString *)goods_id content:(NSString *)content comment_images:(NSArray *)base64ImageArray;

+ (NSString *)api_tags_updateTaglist_tagsWithTags:(NSArray *)tags;

+ (NSString *)get_user_info;

+ (NSString *)api_get_certification;

+ (NSString *)api_member_certificationWithBase64Str:(NSString *)base64 type:(NSString *)type;

+ (NSString *)api_goods_getCmptNution;




@end
