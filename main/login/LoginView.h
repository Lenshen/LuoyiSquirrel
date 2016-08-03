//
//  LoginView.h
//  LuoyiSquirrel
//
//  Created by 远深 on 16/8/2.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginView : UIView

@property (nonatomic, strong)UITextField *mobileTF;
@property (nonatomic, strong)UITextField *codeTF;
@property (nonatomic, strong)UIButton *openSquirrelButton;
@property (nonatomic,strong)UIButton *shareButton;


- (instancetype)initWithFrame:(CGRect)frame;
@end
