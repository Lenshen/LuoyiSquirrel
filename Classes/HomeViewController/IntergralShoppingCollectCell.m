//
//  IntergralShoppingCollectCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/14.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "IntergralShoppingCollectCell.h"

@implementation IntergralShoppingCollectCell


        

- (UIImageView *)imageView
{
    if (!_imageView) {

        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(5, 10, self.contentView.frame.size.width-10, 90)];
        _imageView.backgroundColor = [UIColor blueColor];
        _imageView.layer.cornerRadius = 15;
        _imageView.layer.masksToBounds = YES;



    }
    return _imageView;
}
- (UILabel *)label
{
    if (!_label) {

        _label = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.imageView.frame)+10, self.contentView.frame.size.width-10, 20)];
//        _label.backgroundColor = [UIColor yellowColor];
    }
    return _label;
}

- (UILabel *)moneyLable
{
    if (!_moneyLable) {

        _moneyLable = [[UILabel alloc]initWithFrame:CGRectMake(10, CGRectGetMaxY(self.label.frame)+10, 70, 20)];
//        _moneyLable.backgroundColor = [UIColor lightGrayColor];
        _moneyLable.font = [UIFont systemFontOfSize:14];

    }
    return _moneyLable;
}

- (UIButton *)convertButton
{
    if (!_convertButton) {
        _convertButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _convertButton.frame = CGRectMake(self.contentView.frame.size.width-10-50,CGRectGetMaxY(self.label.frame)+10 , 50,20);
        _convertButton.backgroundColor = NavigationColor;
        _convertButton.layer.cornerRadius = 5;

        [_convertButton setTitle:@"兑换" forState:UIControlStateNormal];
        _convertButton.titleLabel.font = [UIFont systemFontOfSize:14];
        [_convertButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];


    }
    return _convertButton;
}


@end
