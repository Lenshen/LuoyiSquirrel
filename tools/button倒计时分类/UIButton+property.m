//
//  UIButton+property.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/9/13.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "UIButton+property.h"
#import <objc/runtime.h>
static char *PersonNameKey = "PersonNameKey";


@implementation UIButton (property)

- (void)setMember:(NSInteger)member
{
    objc_setAssociatedObject(self, PersonNameKey, [NSNumber numberWithInteger:member], OBJC_ASSOCIATION_ASSIGN);



}
- (NSInteger)member
{
    NSNumber *resourceCountNumber = objc_getAssociatedObject(self, PersonNameKey);

    if (! resourceCountNumber)
    {
        return 0;
    }
    else
    {
        return [resourceCountNumber integerValue];
    } }

@end
