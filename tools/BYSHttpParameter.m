//
//  BYSHttpParameter.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/12.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "BYSHttpParameter.h"
#import "DES.h"

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
    return [DES encryptWithContent:jsonstr];


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



    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

//  5.获取用户默认基本信息
+ (NSString *)get_app_member_service_user_id:(NSString *)user_id
{
    NSDictionary *dic = @{@"method":@"get_member_info",@"user_id":user_id};
 return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

//  6.获取用户基本信息列表
+ (NSString *)get_app_list
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_member_list"};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

+ (NSString *)get_goods_gradedWithGoods_id:(NSString *)goods_id
                                 member_id:(NSString *)member_id
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"goods_id":goods_id,@"member_id":member_id};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

+ (NSString *)get_user_info
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_user_info"};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

+ (NSString *)get_home_getMessage
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"]};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

//  7.设置基本信息为默认
+ (NSString *)get_app_change_isdefault_user_id:(NSString *)user_id
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"], @"method":@"change_default",@"user_id":user_id};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

//  8.删除一个基本信息，不会删除默认基本信息
+ (NSString *)get_app_delet_info_user_id:(NSString *)user_id
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_member_info",@"user_id":user_id};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

//  9.获取邀请码
+ (NSString *)get_app_get_code
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_code"};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}


//  10.兑换邀请码
+ (NSString *)api_exchange_code:(NSString *)code
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"exchange_code",@"code":code};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
    return nil;
}

//  11.签到
+ (NSString *)api_sign_in
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"sign_in"};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}

//  12.获取签到信息
+ (NSString *)api_get_sign
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_sign"};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

//  13.获取积分信息
+ (NSString *)api_get_point
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_point"};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}

//  14.获取首页轮番广告

+ (NSDictionary *)api_getAdvert_spaceCode:(NSString *)spaceCode
{
    NSDictionary *dic = @{@"SpaceCode":@"centre"};
    return  dic;
}

+ (NSString *)api_get_certification
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_certification"};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}


+ (NSString *)api_member_certificationWithBase64Str:(NSString *)base64 type:(NSString *)type
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"image":base64,@"type":type};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}




+ (NSString *)api_home_addGoddsWithGood_id:(NSString *)goods_id
                                  bar_code:(NSString *)bar_code
                                      name:(NSString *)name
                                brand_name:(NSString *)brand_name
                            goods_class_id:(NSString *)goods_class_id
                           approval_number:(NSString *)approval_number
                                     alias:(NSString *)alias
                                     price:(NSString *)price
                               price_units:(NSString *)price_units
                               goods_image:(NSString *)goods_image
                                shelf_life:(NSString *)shelf_life
                                     saved:(NSString *)saved
                                  property:(NSString *)property
                                    flavor:(NSString *)flavor
                                   content:(NSString *)content
                                 packaging:(NSString *)packaging
                          machining_method:(NSString *)machining_method
                             edible_method:(NSString *)edible_method


{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"goods_id":goods_id,@"bar_code":bar_code,@"name":name,@"brand_name":brand_name,@"goods_class_id":goods_class_id,@"approval_number":approval_number,@"alias":alias,@"price":price,@"price_units":price_units,@"goods_image":goods_image,@"shelf_life":shelf_life,@"saved":saved,@"property":property,@"flavor":flavor,@"content":content,@"packaging":packaging,@"machining_method":machining_method,@"edible_method":edible_method};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}





+ (NSString *)api_goods_getPageWithindex:(NSNumber *)index
                                    size:(NSNumber *)size
                                 type_id:(NSNumber *)type_id
                                    sort:(NSNumber *)sort

{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"index":index,@"size":size,@"type_id":type_id,@"sort":sort};

    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}



+ (NSString *)api_class_list
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"method":@"get_class_list"};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}
















//获取成员标签

+ (NSString *)api_tags_updateTaglist_tagsWithTags:(NSArray *)tags
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"member_id":@"0",@"tags":tags};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}

+ (NSString *)api_tags_getlist_tags
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"member_id":@"0"};
    return [DES encryptWithContent:[self dictionaryToJson:dic]];
}





//25.添加商品
+ (NSString *)api_home_addGoods_goodID:(NSString *)goods_id bar_code:(NSString *)bar_code
                                  name:(NSString *)name brand_name:(NSString *)brand_name
                        goods_class_id:(NSString *)goods_class_id approval_number:(NSString *)approval_number
                                 alias:(NSString *)alias price:(NSString *)price
                           price_units:(NSString *)price_units
        
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"]};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}





//26.获取含量的下拉列表
+ (NSString *)api_goods_getCmptNution
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"]};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}



//27.为一个商品添加含量
+ (NSString *)api_goods_addCmptNution_goodID:(NSString *)goods_id cmpt_nution:(NSDictionary *)cmpt_nution
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"goods_id":goods_id,@"cmpt_nution":cmpt_nution};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}

//28.为一个商品添加配料（原料）

// material  用户输入字符串数组

+ (NSString *)api_goods_addMaterial_goodID:(NSString *)goods_id material:(NSArray *)materialArray
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"goods_id":goods_id,@"material":materialArray};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}




//
+ (NSString *)api_comment_addCommentWithGoods_id:(NSString *)goods_id content:(NSString *)content comment_images:(NSArray *)base64ImageArray
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"goods_id":goods_id,@"content":content,@"comment_images":base64ImageArray};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}



+ (NSString *)api_member_setAddressWithAddress:(NSString *)address mobile:(NSString *)mobile
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"address":address,@"mobile":mobile};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}



//29.获取积分商城列表

//sort  排序 0默认,1积分降序,2积分升序,3库存降序,4库存升序 (可为空)
+ (NSString *)api_goods_getPointGoods_index:(NSString *)index size:(NSString *)size sort:(NSString *)sort
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"index":index,@"size":size,@"sort":sort};
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}


//30.兑换积分商品
+ (NSString *)api_goods_Exchang_pgID:(NSString *)pg_id full_name:(NSString *)full_name mobile:(NSString *)mobile province:(NSString *)province city:(NSString *)city area:(NSString *)area street:(NSString *)street
{
    NSDictionary *dic = @{@"token":[USER_DEFAULT objectForKey:@"token"],@"pg_id":pg_id,@"full_name":full_name,@"mobile":mobile,@"province":province,@"city":city,@"area":area,@"street":street
                          };
    return  [DES encryptWithContent:[self dictionaryToJson:dic]];
}




// 字典转换json数据、
+ (NSString*)dictionaryToJson:(NSDictionary *)dic

{

    NSError *parseError = nil;

    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    NSLog(@"%@",[[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding]);

    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}


@end
