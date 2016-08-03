//
//  TriangleView.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/25.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "TriangleView.h"

@implementation TriangleView

- (void)drawRect:(CGRect)rect
{
    
    [[UIColor
      clearColor]set];

    UIRectFill([self

                bounds]);

    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    CGContextBeginPath(contextRef);
    
    CGContextMoveToPoint(contextRef,self.frame.size.width/2, 0);
    CGContextAddLineToPoint(contextRef,self.frame.size.width/2-10, 15);
    CGContextAddLineToPoint(contextRef, self.frame.size.width/2+10, 15);
    CGContextClosePath(contextRef);


    [TableviewColor setFill];

    CGContextDrawPath(contextRef, kCGPathFillStroke);




}
@end
