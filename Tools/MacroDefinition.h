//
//  MacroDefinition.h
//  MacroDefinitionDemo
//
//  Created by 新风作浪 on 13-6-9.
//  Copyright (c) 2013年 SpinningSphere Labs. All rights reserved.
//

#ifndef MacroDefinition_h
#define MacroDefinition_h
#define TESTSERVERSAPI  @"192.168.0.103:555"

#define DESKEY @"4D53B979"

//-------------------获取设备大小-------------------------
//NavBar高度
#define NavigationBar_HEIGHT 44

//发送手机验证码（注册或登录)
#define APP_member_send @"http://"TESTSERVERSAPI"/api/member/send"

//获取token
#define APP_member_getToken @"http://"TESTSERVERSAPI"/api/member/getToken"

//获取邀请码
//获取用户默认的基本信息
//设置基本信息为默认
//删除一个基本信息，不会删除默认基本信息
//兑换邀请码
//签到
//获取签到信息
//获取积分信息
//获取用户认证信息
//兑换积分商品

#define APP_member_service   @"http://"TESTSERVERSAPI"/api/member/service"

//增加基本信息
#define APP_member_addInfo @"http://"TESTSERVERSAPI"/api/member/addinfo"

//修改基本信息
#define APP_member_changeInfo @"http://"TESTSERVERSAPI"/api/member/changeInfo"

//获取用户默认的基本信息
#define APP_member_changeInfo @"http://"TESTSERVERSAPI"/api/member/changeInfo"

//获取首页轮播广告
#define APP_home_getAdvert @"http://"TESTSERVERSAPI"/api/home/getAdvert"

//第三方登录（获取token）

#define APP_member_getTokenByOpenID @"http://"TESTSERVERSAPI"/api/member/GetTokenByOpenID"

//修改用户认证地址

#define APP_member_setAddress @"http://"TESTSERVERSAPI"/api/member/setAddress"

//用户上传认证图片

#define APP_member_certification @"http://"TESTSERVERSAPI"/api/member/certification"

//修改成员标签

#define APP_tags_updataTags @"http://"TESTSERVERSAPI"/api/tags/UpdateTags"

//获取商品分类

#define APP_goods_service @"http://"TESTSERVERSAPI"/api/goods/service"

//获取商品分页列表

#define APP_goods_GetPage  @"http://"TESTSERVERSAPI"/ api/goods/GetPage"

//获取积分商城列表

#define APP_goods_getPointGoods @"http://"TESTSERVERSAPI"/api/goods/GetPointGoods"

//为一个商品添加含量

#define APP_goods_addCMPNution  @"http://"TESTSERVERSAPI"/api/goods/AddCmptNution"

//为一个商品添加配料（原料)

#define APP_goods_addMaterial  @"http://"TESTSERVERSAPI"/api/goods/AddMaterial"



#define APP_USER_SIGOUT  @"http://"TESTSERVERSAPI"/api/user/signout"

#define APP_USER_UPDATE  @"http://"TESTSERVERSAPI"/api/user/update"

#define APP_ADDRESS_ADD  @"http://"TESTSERVERSAPI"/api/address/add"

#define APP_ADDRESS_UPDATE @"http://"TESTSERVERSAPI"/api/address/update"

#define APP_USER_GETMESSAGE  @"http://"TESTSERVERSAPI"/api/user/get_msg"

#define APP_USER_READMESSAGE  @"http://"TESTSERVERSAPI"/api/user/read_msg"


#define APP_USER_ADDINQUIRE  @"http://"TESTSERVERSAPI"/api/user/addinquire"

#define APP_CART_GETALL @"http://"TESTSERVERSAPI"/api/cart/getall"

#define APP_FAVORITE_LIST @"http://"TESTSERVERSAPI"/api/favorite/list"

#define APP_FAVORITE_REMOVE @"http://"TESTSERVERSAPI"/api/favorite/remove"

#define APP_CART_REMOVE @"http://"TESTSERVERSAPI"/api/cart/remove"

#define APP_GET_VERSION @"http://"TESTSERVERSAPI"/api/config/version"

#define APP_CHANGE_GoodsCounts @"http://"TESTSERVERSAPI"/api/cart/add"

#define APP_GOODPRICE_UPDATE @"http://"TESTSERVERSAPI"/api/cart/update"













//获取屏幕 宽度、高度


#define BYSScreenWidth  [UIScreen mainScreen].bounds.size.width
#define BYSScreenHeight [UIScreen mainScreen].bounds.size.height


#define NavigationColor  [UIColor colorWithRed:70/255.0 green:190/255.0 blue:57/255.0 alpha:1]
#define TableviewColor  [UIColor colorWithRed:232/255.0 green:234/255.0 blue:235/255.0 alpha:1]

#define RANDOMCOLOR [UIColor colorWithRed:random()%255/255.0 green:random()%255/255.0 blue:random()%255/255.0 alpha:1];



#define windowColor  [UIColor colorWithRed:236 green:236 blue:236 alpha:0.2]

#define VERSION_CURRENT [[[UIDevice currentDevice] systemVersion] floatValue];

//-------------------获取设备大小-------------------------


//-------------------打印日志-------------------------
//DEBUG  模式下打印日志,当前行
#ifdef DEBUG
#   define DLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__);
#else
#   define DLog(...)
#endif


//重写NSLog,Debug模式下打印日志和当前行数
#if DEBUG
#define NSLog(FORMAT, ...) fprintf(stderr,"\nfunction:%s line:%d content:%s\n", __FUNCTION__, __LINE__, [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);
#else
#define NSLog(FORMAT, ...) nil
#endif

//DEBUG  模式下打印日志,当前行 并弹出一个警告
#ifdef DEBUG
#   define ULog(fmt, ...)  { UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%s\n [Line %d] ", __PRETTY_FUNCTION__, __LINE__] message:[NSString stringWithFormat:fmt, ##__VA_ARGS__]  delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil]; [alert show]; }
#else
#   define ULog(...)
#endif


#define ITTDEBUG
#define ITTLOGLEVEL_INFO     10
#define ITTLOGLEVEL_WARNING  3
#define ITTLOGLEVEL_ERROR    1

#ifndef ITTMAXLOGLEVEL

#ifdef DEBUG
#define ITTMAXLOGLEVEL ITTLOGLEVEL_INFO
#else
#define ITTMAXLOGLEVEL ITTLOGLEVEL_ERROR
#endif

#endif

// The general purpose logger. This ignores logging levels.
#ifdef ITTDEBUG
#define ITTDPRINT(xx, ...)  NSLog(@"%s(%d): " xx, __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define ITTDPRINT(xx, ...)  ((void)0)
#endif

// Prints the current method's name.
#define ITTDPRINTMETHODNAME() ITTDPRINT(@"%s", __PRETTY_FUNCTION__)

// Log-level based logging macros.
#if ITTLOGLEVEL_ERROR <= ITTMAXLOGLEVEL
#define ITTDERROR(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDERROR(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_WARNING <= ITTMAXLOGLEVEL
#define ITTDWARNING(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDWARNING(xx, ...)  ((void)0)
#endif

#if ITTLOGLEVEL_INFO <= ITTMAXLOGLEVEL
#define ITTDINFO(xx, ...)  ITTDPRINT(xx, ##__VA_ARGS__)
#else
#define ITTDINFO(xx, ...)  ((void)0)
#endif

#ifdef ITTDEBUG
#define ITTDCONDITIONLOG(condition, xx, ...) { if ((condition)) { \
ITTDPRINT(xx, ##__VA_ARGS__); \
} \
} ((void)0)
#else
#define ITTDCONDITIONLOG(condition, xx, ...) ((void)0)
#endif

#define ITTAssert(condition, ...)                                       \
do {                                                                      \
if (!(condition)) {                                                     \
[[NSAssertionHandler currentHandler]                                  \
handleFailureInFunction:[NSString stringWithUTF8String:__PRETTY_FUNCTION__] \
file:[NSString stringWithUTF8String:__FILE__]  \
lineNumber:__LINE__                                  \
description:__VA_ARGS__];                             \
}                                                                       \
} while(0)

//---------------------打印日志--------------------------


//----------------------系统----------------------------

//获取系统版本
#define IOS_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]
#define CurrentSystemVersion [[UIDevice currentDevice] systemVersion]

//获取当前语言
#define CurrentLanguage ([[NSLocale preferredLanguages] objectAtIndex:0])

//判断是否 Retina屏、设备是否%fhone 5、是否是iPad
#define isRetina ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define isPad (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)


//判断是真机还是模拟器
#if TARGET_OS_IPHONE
//iPhone Device
#endif

#if TARGET_IPHONE_SIMULATOR
//iPhone Simulator
#endif

//检查系统版本
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


//----------------------系统----------------------------


//----------------------内存----------------------------

//使用ARC和不使用ARC
#if __has_feature(objc_arc)
//compiling with ARC
#else
// compiling without ARC
#endif

#pragma mark - common functions
#define RELEASE_SAFELY(__POINTER) { [__POINTER release]; __POINTER = nil; }

//释放一个对象
#define SAFE_DELETE(P) if(P) { [P release], P = nil; }

#define SAFE_RELEASE(x) [x release];x=nil



//----------------------内存----------------------------


//----------------------图片----------------------------

//读取本地图片
#define LOADIMAGE(file,ext) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle]pathForResource:file ofType:ext]]

//定义UIImage对象
#define IMAGE(A) [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:A ofType:nil]]

//定义UIImage对象
#define ImageNamed(_pointer) [UIImage imageNamed:[UIUtil imageName:_pointer]]

//建议使用前两种宏定义,性能高于后者
//----------------------图片----------------------------



//----------------------颜色类---------------------------
// rgb颜色转换（16进制->10进制）
#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//带有RGBA的颜色设置
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

// 获取RGB颜色
#define RGBA(r,g,b,a) [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
#define RGB(r,g,b) RGBA(r,g,b,1.0f)

//背景色
#define BACKGROUND_COLOR [UIColor colorWithRed:242.0/255.0 green:236.0/255.0 blue:231.0/255.0 alpha:1.0]

//清除背景色
#define CLEARCOLOR [UIColor clearColor]

#pragma mark - color functions
#define RGBCOLOR(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define RGBACOLOR(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:(a)]

//----------------------颜色类--------------------------



//----------------------其他----------------------------

//方正黑体简体字体定义
#define FONT(F) [UIFont fontWithName:@"FZHTJW--GB1-0" size:F]


//定义一个API
#define APIURL                @"http://xxxxx/"
//登陆API
#define APILogin              [APIURL stringByAppendingString:@"Login"]

//设置View的tag属性
#define VIEWWITHTAG(_OBJECT, _TAG)    [_OBJECT viewWithTag : _TAG]
//程序的本地化,引用国际化的文件
#define MyLocal(x, ...) NSLocalizedString(x, nil)

//G－C－D
#define BACK(block) dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), block)
#define MAIN(block) dispatch_async(dispatch_get_main_queue(),block)

//NSUserDefaults 实例化
#define USER_DEFAULT [NSUserDefaults standardUserDefaults]


//由角度获取弧度 有弧度获取角度
#define degreesToRadian(x) (M_PI * (x) / 180.0)
#define radianToDegrees(radian) (radian*180.0)/(M_PI)



//单例化一个类
#define SYNTHESIZE_SINGLETON_FOR_CLASS(classname) \
\
static classname *shared##classname = nil; \
\
+ (classname *)shared##classname \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [[self alloc] init]; \
} \
} \
\
return shared##classname; \
} \
\
+ (id)allocWithZone:(NSZone *)zone \
{ \
@synchronized(self) \
{ \
if (shared##classname == nil) \
{ \
shared##classname = [super allocWithZone:zone]; \
return shared##classname; \
} \
} \
\
return nil; \
} \
\
- (id)copyWithZone:(NSZone *)zone \
{ \
return self; \
}



#endif
