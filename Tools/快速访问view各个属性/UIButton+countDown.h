//
//  UIButton+countDown.h
//  countdown
//
//  Created by WooY on 16/1/12.
//  Copyright © 2016年 WooY. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (countDown)
@property (nonatomic, copy) NSString *tag_id;

- (void)startWithTime:(NSInteger)timeLine title:(NSString *)title countDownTitle:(NSString *)subTitle mainColor:(UIColor *)mColor countColor:(UIColor *)color;
-(void)canSelectButton;
-(void)canNotSelectButton;
@end

