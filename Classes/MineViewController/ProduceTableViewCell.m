//
//  ProduceTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/9/11.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ProduceTableViewCell.h"

@implementation ProduceTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {
        [self configUI];
    }
    return self;
}

- (void)configUI
{

    NSString *dealersStr = @"联系电话:";
    NSString *dealersStrAddress = @"官方网址:";
    CGSize dealerSize = [dealersStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGSize dealersStrAddressSize = [dealersStrAddress sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];

    NSString *dealersTFStr = @"请输入联系电话";
    NSAttributedString *attribute = [[NSAttributedString alloc]initWithString:dealersTFStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    NSString *dealersAdressTFStr = @"请输入官方网址";
    NSAttributedString *dealersAdressAttribute = [[NSAttributedString alloc]initWithString:dealersAdressTFStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];



    _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 20, 35)];

    UILabel *produceIM = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10, 20,200, 21)];
    produceIM.font = [UIFont systemFontOfSize:15];
    produceIM.text = @"厂家信息";
    produceIM.textAlignment = NSTextAlignmentLeft;

    UILabel *lineLabel0 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10,CGRectGetMaxY(produceIM.frame), BYSScreenWidth-70, 0.5)];
    lineLabel0.backgroundColor = RGB(194, 195, 196);




    UILabel *dealersLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10, CGRectGetMaxY(lineLabel0.frame)+10,dealerSize.width, 21)];
    dealersLabel.font = [UIFont systemFontOfSize:15];
    dealersLabel.text = dealersStr;

    _dealersTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dealersLabel.frame), CGRectGetMinY(dealersLabel.frame)+3, BYSScreenWidth-(CGRectGetMinX(dealersLabel.frame)+30), 21)];
    NSLog(@"%f",CGRectGetMinX(dealersLabel.frame)+30);
    _dealersTF.attributedPlaceholder = attribute;


    UILabel *lineLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10,CGRectGetMaxY(_dealersTF.frame), BYSScreenWidth-(CGRectGetMinX(dealersLabel.frame)+30), 0.5)];
    lineLabel.backgroundColor = RGB(194, 195, 196);

    UILabel *dealersAdressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10, CGRectGetMaxY(lineLabel.frame)+10, dealersStrAddressSize.width, 21)];
    dealersAdressLabel.font = [UIFont systemFontOfSize:15];
    dealersAdressLabel.text = dealersStrAddress;


    _dealersAdrressTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dealersAdressLabel.frame),CGRectGetMaxY(lineLabel.frame)+12, BYSScreenWidth-(CGRectGetMinX(dealersAdressLabel.frame)+30), 21)];
    _dealersAdrressTF.attributedPlaceholder = dealersAdressAttribute;

    UILabel *lineLabel2 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10,CGRectGetMaxY(_dealersAdrressTF.frame), BYSScreenWidth-(CGRectGetMinX(dealersAdressLabel.frame)+30), 0.5)];
    lineLabel2.backgroundColor = RGB(194, 195, 196);



    [self.contentView addSubview:_numberLabel];
    [self.contentView addSubview:dealersLabel];
    [self.contentView addSubview:_dealersTF];
    [self.contentView addSubview:lineLabel];
    [self.contentView addSubview:dealersAdressLabel];
    [self.contentView addSubview:_dealersAdrressTF];
    [self.contentView addSubview:lineLabel2];
    [self.contentView addSubview:lineLabel0];
    [self.contentView addSubview:produceIM];
    
    
    







}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.dealersTF resignFirstResponder];
    [self.dealersAdrressTF resignFirstResponder];
}

@end
