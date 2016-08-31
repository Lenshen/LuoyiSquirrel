//
//  BYSHttpTool.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "BYSHttpTool.h"
#import "AFNetworking.h"
//#import "NSString+MD5.h"

@implementation BYSHttpTool

+ (void)reachability:(UIViewController *)viewcontroller
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
//    NSString *via = @"网络未连接,请检查你的网络";

    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
//                [via alert:via viewcontroller:viewcontroller];

                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN: // 手机自带网络
                NSLog(@"手机自带网络");

                break;
            case AFNetworkReachabilityStatusReachableViaWiFi: // WIFI
                NSLog(@"WIFI");
                break;
        }
    }];
    // 3.开始监控
    [mgr startMonitoring];
}


+(void)GET:(NSString *)URLString Parameters:(id)parameters Success:(void (^)(id))success Failure:(void (^)(NSError *))failure
{
     dispatch_async(dispatch_get_global_queue(0, 0), ^{
         AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
         mgr.requestSerializer.timeoutInterval = 30;
         mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css", nil];
         [mgr GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
             if (success) {
        dispatch_async(dispatch_get_main_queue(), ^{
             success(responseObject);

        });
                
             }
         } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
             if (failure) {
            dispatch_async(dispatch_get_main_queue(), ^{
                     failure(error);
                 });

             }
         }];
     });
   
}

+(void)POST:(NSString *)URLString Parameters:(id)parameters Success:(void (^)(id))success Failure:(void (^)(NSError *))failure
{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        AFHTTPSessionManager *mgr = [AFHTTPSessionManager manager];
        mgr.requestSerializer.timeoutInterval = 30;
        mgr.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/css",@"text/plain",nil];
        [mgr POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
            
            if (success) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(responseObject);


                });
            }
        } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            if (failure) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failure(error);

                });
            }
            
        }];

    });
   }

@end
