//
//  DES.h
//  SzmEncryptTool
//
//  Created by 宋志明 on 15/9/23.
//  Copyright (c) 2015年 宋志明. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#include <CommonCrypto/CommonCryptor.h>

@interface DES : NSObject
//+(NSString*) decryptUseDES:(NSString*)cipherText key:(NSString*)key;
//+(NSString*) encryptUseDES:(NSString *)clearText key:(NSString *)key;
//+(NSString*) encryptImageUseDES:(UIImage *)image key:(NSString *)key;

+(NSString*)encryptWithContent:(NSString*)content;

+(NSString*)encryptWithContent:(NSString*)content type:(CCOperation)type key:(NSString*)aKey;



@end
