//
//  VerticalButton.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/7.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "VerticalButton.h"

@implementation VerticalButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat midX = self.frame.size.width / 2;
    CGFloat midY = self.frame.size.height/ 2 ;
    self.titleLabel.center = CGPointMake(midX, midY + 15);
    self.imageView.center = CGPointMake(midX, midY - 10);

}

@end
