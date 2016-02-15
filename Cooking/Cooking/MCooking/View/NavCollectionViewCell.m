//
//  NavCollectionViewCell.m
//  Cooking
//
//  Created by YongFangLili on 16/2/15.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "NavCollectionViewCell.h"

@implementation NavCollectionViewCell

-(id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setUpUI];
    }
    return self;
}


-(void)setUpUI {
    
    //创建 cell 里的子控件
    CGFloat MarginX = (CGRectGetWidth(self.frame) - 50) / 2.0;
    _navsView = [[UIImageView alloc]initWithFrame:CGRectMake(MarginX, 10, 50, 50)];
    //    _navsView.backgroundColor = [UIColor blueColor];
    
    _navsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_navsView.frame), 40, 40)];
    _navsLabel.textAlignment = NSTextAlignmentCenter;
    _navsLabel.textColor = [UIColor darkGrayColor];
    _navsLabel.font = [UIFont systemFontOfSize:13];
    CGPoint center = _navsLabel.center;
    center.x = self.contentView.center.x;
    _navsLabel.center = center;
    //    _navsLabel.backgroundColor = [UIColor blueColor];
    
    [self.contentView addSubview:_navsView];
    [self.contentView addSubview:_navsLabel];
    
    
    
}

-(void)setMcookM:(MCookHeadViewNavs *)McookM {
    
    _McookM = McookM;
    self.navsLabel.text = _McookM.name;
    [self.navsLabel sizeToFit];
    [self.navsView sd_setImageWithURL:[NSURL URLWithString:_McookM.picurl]];

}
@end
