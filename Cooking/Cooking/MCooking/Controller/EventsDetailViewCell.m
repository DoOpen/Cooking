//
//  EventsDetailViewCell.m
//  Cooking
//
//  Created by 李永方 on 16/3/2.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "EventsDetailViewCell.h"
#import "UIButton+Circle.h"
#import "MCookModel.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>



#define DINERURL @"http://api.xiachufang.com/v2/events/show.json?version=5.2.2&id=100095999&api_sign=d5c10acfc982a2a6edd1cb3d3a49333f&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&sk=VJLD90zORKSBXdQbpWTJ1w"
#define DINERDISHES @"http://api.xiachufang.com/v2/events/100095999/dishes_order_by_hot.json?offset=0&detail=true&origin=iphone&api_sign=f1cc3a66d415d303f2849b1236f90da1&sk=VJLD90zORKSBXdQbpWTJ1w&limit=18&version=5.2.2&timestamp=1457368917&api_key=0f9f79be1dac5f003e7de6f876b17c00"

static NSString *ID = @"eventDetailCell";

@interface EventsDetailViewCell()

@property (nonatomic, strong) UIImageView *photoImage;

@property (nonatomic, strong) UILabel *authorName;

@property (nonatomic, strong) UILabel *detailLabel;

@property (nonatomic, strong) UIButton *ndiggsButton;

@property (nonatomic, strong) UILabel *ndiggsLabel;

@end

@implementation EventsDetailViewCell

-(void)setDishesM:(McookEventDetailDishesM *)DishesM {
    
    _DishesM = DishesM;
//    [self.contentView addSubview:self.ndiggsButton];
    [self setUpUI:DishesM];

}


+(instancetype)eventDetailWithColletionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)IndexPath {


    EventsDetailViewCell *eventDetailCell = [collectionView
                                             dequeueReusableCellWithReuseIdentifier:ID forIndexPath:IndexPath];
    
    if (!eventDetailCell) {
        
        eventDetailCell = [[EventsDetailViewCell alloc]init];
        
        
    }
    
    return eventDetailCell;

}
#pragma mark -设置 UI 界面
-(void)setUpUI:(McookEventDetailDishesM *)dishesM {

    [self.photoImage sd_setImageWithURL:[NSURL URLWithString:dishesM.thumbnail]];
    
    self.authorName.text = dishesM.authorName;
    if ([dishesM.name isEqualToString:dishesM.events[0][@"name"]]) {
        
        self.detailLabel.text = dishesM.desc;
    } else {
    self.detailLabel.text = dishesM.name;
    }
    self.ndiggsLabel.text = [NSString stringWithFormat:@"%ld",(long)dishesM.ndiggs];

    //设置 frame
    [self.photoImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.width.equalTo(@(self.bounds.size.width));
        make.height.equalTo(@(185 * KSizeScaleY));
        make.top.equalTo(self.mas_top).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        
    }];
    
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.photoImage.mas_bottom).with.offset(10 * KSizeScaleY);
        make.centerX.equalTo(self);
        make.left.equalTo(self.mas_left).with.offset(20 * KSizeScaleX);
        make.right.equalTo(self.mas_right).with.offset(-20 * KSizeScaleX);
        
    }];
    
    
    [self.ndiggsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
//        make.top.equalTo(self.ndiggsButton.mas_bottom).with.offset(10 * KSizeScaleY);
        make.bottom.equalTo(self.mas_bottom).with.offset(-5 * KSizeScaleY);
        
    }];
    
    [self.ndiggsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
//        make.top.equalTo(self.detailLabel.mas_bottom).with.offset(20 * KSizeScaleY);
        make.bottom.equalTo(self.ndiggsLabel.mas_top).with.offset(-5 * KSizeScaleY);
        make.width.equalTo(@(22 * KSizeScaleX));
        make.height.equalTo(@(22 * KSizeScaleY));
        
    }];
    [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //        make.centerX.equalTo(self);
        make.top.equalTo(self.authorName.mas_bottom).with.offset(20 * KSizeScaleY);
        make.bottom.equalTo(self.mas_bottom).with.offset(-60 * KSizeScaleY);
        
        make.left.equalTo(self.mas_left).with.offset(20 * KSizeScaleX);
        make.right.equalTo(self.mas_right).with.offset(-20 * KSizeScaleX);
    }];
    

}


#pragma mark -懒加载
-(UIImageView *)photoImage {


    if (!_photoImage) {
        
        _photoImage = [[UIImageView alloc]init];
        _photoImage.contentMode =  UIViewContentModeScaleToFill;
        [self.contentView addSubview:_photoImage];
    }
    return _photoImage;
}

-(UILabel *)authorName {

    if (!_authorName) {
        
        _authorName = [[UILabel alloc] init];
        _authorName = [[UILabel alloc] init];
        _authorName.font = [UIFont systemFontOfSize:13];
        _authorName.textAlignment = NSTextAlignmentCenter;
        _authorName.textColor = [UIColor redColor];
        
        [self.contentView addSubview:_authorName];
    }

    return _authorName;

}

-(UILabel *)detailLabel {

    if (!_detailLabel) {
        
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.font = [UIFont systemFontOfSize:13];
        _detailLabel.numberOfLines = 2;
        _detailLabel.textAlignment = NSTextAlignmentCenter;
        [self.contentView addSubview:_detailLabel];
        
    }
    
    return _detailLabel;


}

-(UIButton *)ndiggsButton{

    if (!_ndiggsButton) {
        
        _ndiggsButton = [UIButton CircleButtonWithFrame:CGRectMake(0, 0, 22, 22) withTitle:nil WithImage:[UIImage imageNamed:@"dishPagerLike"]];
        
        [self.contentView addSubview:_ndiggsButton];
    }
    return _ndiggsButton;

}
-(UILabel *)ndiggsLabel{

    if (!_ndiggsLabel) {
        
        _ndiggsLabel = [[UILabel alloc] init];
        _ndiggsLabel.font = [UIFont systemFontOfSize:13];
        _ndiggsLabel.textColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_ndiggsLabel];
    }
    
    return _ndiggsLabel;

}
@end
