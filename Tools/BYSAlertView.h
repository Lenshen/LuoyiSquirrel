//
//  BYSAlertView.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/14.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BYSAlertView : UIView
- (instancetype)initWithFrame:(CGRect)frame;
- (instancetype)initWithCoder:(NSCoder *)aDecoder;
- (instancetype)initWithFrame:(CGRect)frame titleString:(NSString *)titleString messageSting:(NSString *)messageSting buttonTitle:(NSString *)buttonTitle;



@property (nonatomic, strong) NSString *titleSting;
@property (nonatomic, strong) NSString *messageSting;
@property (nonatomic, strong) NSString *buttonTitle;





@end
