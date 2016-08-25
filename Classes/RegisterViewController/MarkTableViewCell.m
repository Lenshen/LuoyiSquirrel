//
//  MarkTableViewCell.m
//  LuoyiSquirrel
//
//  Created by 远深 on 16/7/15.
//  Copyright © 2016年 LuoyiSquirrel. All rights reserved.
//

#import "MarkTableViewCell.h"
#import "HXTagsView.h"

@implementation MarkTableViewCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    if (self) {

    }
    return self;
}
//- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier withArray:(NSArray *)titleArray
//{
//    self = [super initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
//    if (self) {
//        
//        self.titileArray = titleArray;
//        NSLog(@"%@",titleArray);
//        [self configUI];
//
//
//    }
//    return self;
//}

//- (void)setMarkArray:(NSArray *)titileArray
//{
//    [self configUI:titileArray];
//}
//
//- (void)setTitle:(NSString *)title
//{
//    _titleLabel.text = title;
//}
//- (void)setTag_idArray:(NSArray *)tag_array
//{
//
//    _tagsView.tag_idArray = tag_array;
//}
- (void)setModel:(markCellModel *)model
{
    [self configUI:model];
    
}
- (void)configUI:(markCellModel *)model

{


    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    _titleLabel.text = model.title;
    [self.contentView addSubview:_titleLabel];

    //单行不需要设置高度,内部根据初始化参数自动计算高度
    _tagsView = [[HXTagsView alloc] initWithFrame:CGRectMake(0, _titleLabel.frame.origin.y+_titleLabel.frame.size.height, BYSScreenWidth-10, 0)];
    _tagsView.type = 0;
    _tagsView.tag_idArray = model.tag_idArray;
//    NSLog(@"%@-------%@",_tag_idArray,_tagsView.tag_idArray)
    _tagsView.highlightedBackgroundImage = [UIImage imageNamed:@"勾勾"];
    _tagsView.tag = 1000;
    [_tagsView setTagAry:model.markArray delegate:self];
    [self.contentView addSubview:_tagsView];
    

}


@end
