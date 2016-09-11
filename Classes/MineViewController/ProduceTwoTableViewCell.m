//
//  ProduceTwoTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/9/11.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "ProduceTwoTableViewCell.h"

@implementation ProduceTwoTableViewCell


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

    NSString *dealersStr = @"生产商 : ";
    NSString *dealersStrAddress = @"生产商地址 : ";
    NSString *qs = @"生产许可证 : ";
    NSString *produceAddress = @"产地 : ";

    CGSize dealerSize = [dealersStr sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGSize dealersStrAddressSize = [dealersStrAddress sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];

    CGSize qsSize = [qs sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];
    CGSize produceAddressSize = [produceAddress sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15]}];

    NSString *dealersTFStr = @"请输入生产商";
    NSAttributedString *attribute = [[NSAttributedString alloc]initWithString:dealersTFStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    NSString *dealersAdressTFStr = @"请输入生产商地址";
    NSAttributedString *dealersAdressAttribute = [[NSAttributedString alloc]initWithString:dealersAdressTFStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];

    NSString *qsTFStr = @"请输入生产许可证";
    NSAttributedString *qsAttribute = [[NSAttributedString alloc]initWithString:qsTFStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];
    NSString *produceAddressTFStr = @"请输入产地";
    NSAttributedString *produceAddressAttribute = [[NSAttributedString alloc]initWithString:produceAddressTFStr attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]}];



    _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(10, 10, 20, 35)];






    UILabel *dealersLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10,20,dealerSize.width, 21)];
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


    UILabel *qsLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10,CGRectGetMaxY(lineLabel2.frame)+10,qsSize.width, 21)];
    qsLabel.font = [UIFont systemFontOfSize:15];
    qsLabel.text = qs;

    _qsTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(qsLabel.frame), CGRectGetMinY(qsLabel.frame)+3, BYSScreenWidth-(CGRectGetMinX(dealersLabel.frame)+30), 21)];
    NSLog(@"%f",CGRectGetMinX(dealersLabel.frame)+30);
    _qsTF.attributedPlaceholder = qsAttribute;


    UILabel *lineLabel3 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10,CGRectGetMaxY(_qsTF.frame), BYSScreenWidth-(CGRectGetMinX(dealersLabel.frame)+30), 0.5)];
    lineLabel3.backgroundColor = RGB(194, 195, 196);


    UILabel *produceAddressLabel = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10,CGRectGetMaxY(lineLabel3.frame)+10,dealerSize.width, 21)];
    produceAddressLabel.font = [UIFont systemFontOfSize:15];
    produceAddressLabel.text = produceAddress;

    _produceAdrressTF = [[UITextField alloc]initWithFrame:CGRectMake(CGRectGetMaxX(dealersLabel.frame), CGRectGetMinY(produceAddressLabel.frame)+3, BYSScreenWidth-(CGRectGetMinX(dealersLabel.frame)+30), 21)];
    NSLog(@"%f",CGRectGetMinX(dealersLabel.frame)+30);
    _produceAdrressTF.attributedPlaceholder = produceAddressAttribute;


    UILabel *lineLabel4 = [[UILabel alloc]initWithFrame:CGRectMake(CGRectGetMaxX(_numberLabel.frame)+10,CGRectGetMaxY(_produceAdrressTF.frame), BYSScreenWidth-(CGRectGetMinX(dealersLabel.frame)+30), 0.5)];
    lineLabel4.backgroundColor = RGB(194, 195, 196);

    




    [self.contentView addSubview:_numberLabel];
    [self.contentView addSubview:dealersLabel];
    [self.contentView addSubview:_dealersTF];
    [self.contentView addSubview:lineLabel];
    [self.contentView addSubview:dealersAdressLabel];
    [self.contentView addSubview:_dealersAdrressTF];
    [self.contentView addSubview:lineLabel2];

    [self.contentView addSubview:qsLabel];
    [self.contentView addSubview:_qsTF];
    [self.contentView addSubview:lineLabel3];

    [self.contentView addSubview:produceAddressLabel];
    [self.contentView addSubview:_produceAdrressTF];
    [self.contentView addSubview:lineLabel4];















}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.dealersTF resignFirstResponder];
    [self.dealersAdrressTF resignFirstResponder];
}
@end
