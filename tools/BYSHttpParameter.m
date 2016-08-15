//
//  BYSHttpParameter.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/12.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "BYSHttpParameter.h"

@implementation BYSHttpParameter

//   1.发送手机验证码（注册或登录)
+ (NSDictionary *)get_APP_member_send
{
    NSDictionary *dic = @{@"mobile":@"15961237169",@"type":@"0"};
    return dic;
}

//   2.获取token
+ (NSDictionary *)get_APP_member_getToken:(NSString *)code
{
    NSDictionary *dic = @{@"vCode":code};
    return dic;

}

//   3.增加基本信息
+ (NSString *)get_APP_member_addInfo_jsonStr:(NSString *)is_default nick_name:(NSString *)nick_name birthday:(NSString *)brithday sex:(NSString *)sex height:(NSString *)height weight:(NSString *)weight 
{
    NSDictionary *dic = @{@"is_default":is_default,@"nick_name":nick_name,@"birthday":brithday,@"sex":sex,@"height":height,@"weight":weight,@"token":[USER_DEFAULT objectForKey:@"token"]};
    NSString *jsonstr = [self dictionaryToJson:dic];
    return jsonstr;


}




//  4.修改基本信息
+ (NSString *)get_app_member_changeinfo_user_id:(NSString *)user_id
                                      nick_name:(NSString *)nick_name
                                       birthday:(NSString *)birthday
                                            sex:(NSString *)sex
                                         height:(NSString *)height
                                         weight:(NSString *)weight
                                          token:(NSString *)token
                                     head_image:(NSString *)head_image
{

    NSDictionary *dic = @{@"user_id":user_id,@"nick_name":nick_name,@"birthday":birthday,@"sex":sex,@"height":height,@"weight":weight,@"token":[USER_DEFAULT objectForKey:@"token"],@"head_image":head_image};



    return [self dictionaryToJson:dic];
}

//  5.获取用户默认基本信息
+ (NSString *)get_app_member_service_user_id:(NSString *)user_id
{
    NSDictionary *dic = @{@"method":@"get_member_info",@"user_id":user_id};
 return [self dictionaryToJson:dic];
}

//  6.获取用户基本信息列表
+ (NSString *)get_app_list
{
    NSDictionary *dic = @{@"method":@"get_member_list"};
    return [self dictionaryToJson:dic];
}

//  7.设置基本信息为默认
+ (NSString *)get_app_change_isdefault_user_id:(NSString *)user_id
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"], @"method":@"change_default",@"user_id":user_id};
    return [self dictionaryToJson:dic];}

//  8.删除一个基本信息，不会删除默认基本信息
+ (NSString *)get_app_delet_info_user_id:(NSString *)user_id
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_member_info",@"user_id":user_id};
    return [self dictionaryToJson:dic];
}

//  9.获取邀请码
+ (NSString *)get_app_get_code
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_code"};
    return  [self dictionaryToJson:dic];
}


//  10.兑换邀请码
+ (NSString *)api_exchange_code:(NSString *)code
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"exchange_code",@"code":code};
    return  [self dictionaryToJson:dic];
    return nil;
}

//  11.签到
+ (NSString *)api_sign_in
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"sign_in"};
    return  [self dictionaryToJson:dic];
}

//  12.获取签到信息
+ (NSString *)api_get_sign
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_sign"};
    return  [self dictionaryToJson:dic];
}

//  13.获取积分信息
+ (NSString *)api_get_point
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_point"};
    return  [self dictionaryToJson:dic];
}

//  14.获取首页轮番广告

+ (NSDictionary *)api_getAdvert_spaceCode:(NSString *)spaceCode
{
    NSDictionary *dic = @{@"SpaceCode":@"centre"};
    return  dic;
}
















































+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{

    NSError *parseError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}

@end
