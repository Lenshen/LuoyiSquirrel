//
//  BYSHttpTool.m
//  LouYiHangZhou
//
//  Created by 远深 on 16/4/8.
//  Copyright © 2016年 Luo Yi TECHNOLOGY. All rights reserved.
//

#import "BYSHttpTool.h"
#import "AFNetworking.h"
@interface BYSHttpTool()


@end;
@implementation BYSHttpTool

- (void)reachability:(UIViewController *)viewcontroller
{
    // 1.获得网络监控的管理者
    AFNetworkReachabilityManager *mgr = [AFNetworkReachabilityManager sharedManager];
    // 2.设置网络状态改变后的处理
    NSString *via = @"网络未连接,请检查你的网络";

    [mgr setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变了, 就会调用这个block
        switch (status) {
            case AFNetworkReachabilityStatusUnknown: // 未知网络
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable: // 没有网络(断网)
                NSLog(@"没有网络(断网)");
                [self setAlertUI:via];

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


- (void)setAlertUI:(NSString *)str
{

    _alertView = [[BYSAlertView alloc]initWithFrame:CGRectMake(15,-110, BYSScreenWidth-15*2, 180) titleString:@"温馨提示"  messageSting:str buttonTitle:@"确定"];
    __weak typeof (self) weakSelf = self;
    _alertView.chickDissMissButton = ^{
        weakSelf.alertView = nil;
    };



    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView.alphaView];
    [[UIApplication sharedApplication].keyWindow addSubview:self.alertView];




    [UIView animateWithDuration:0.7 animations:^{

        self.alertView.frame = CGRectMake(15, 110, BYSScreenWidth-15*2, 180);
    }];
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
