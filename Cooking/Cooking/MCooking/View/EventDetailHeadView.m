//
//  EventDetailHeadView.m
//  Cooking
//
//  Created by 李永方 on 16/3/8.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "EventDetailHeadView.h"
#import "MCookModel.h"
#import <Masonry.h>

static NSString *ID = @"header";

@interface EventDetailHeadView()

@property (nonatomic,strong) UILabel *nameLabel;
@property (nonatomic,strong) UILabel *descLabel;
@property (nonatomic,strong) UILabel *n_dishesLabel;

@end
@implementation EventDetailHeadView

-(void)setEventDetailM:(mcookEventDetail *)eventDetailM {

    _eventDetailM = eventDetailM;
    
    [self setUpUI:eventDetailM];
}
#pragma mark - 创建 hedview 方法
+(instancetype)eventDetailHeadView:(UICollectionView *)collectionView withKind:(NSString *)kind forIndexPath:(NSIndexPath *)Indexpath; {

    [collectionView registerClass:[EventDetailHeadView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:ID];//注册header的view

    if (kind == UICollectionElementKindSectionHeader)
        
    {//如果想要自定义header，只需要定义UICollectionReusableView的子类A，然后在该处使用，注意AIdentifier要设为注册的字符串，此处为“header”
            
            EventDetailHeadView *eventHeadView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:ID forIndexPath:Indexpath];
//            eventHeadView.backgroundColor = [UIColor cyanColor];
        
            return eventHeadView;
        }
    
    return nil;
}

-(void)setUpUI:(mcookEventDetail *)eventDetailM{
    
    self.nameLabel.text = eventDetailM.name;
    [self.nameLabel sizeToFit];
   
    if (eventDetailM.n_dishes != 0) {
        self.n_dishesLabel.text = [NSString stringWithFormat:@"%ld 作品", eventDetailM.n_dishes];
    }
    
     [self.n_dishesLabel sizeToFit];
    self.descLabel.text = eventDetailM.desc;
     [self.descLabel sizeToFit];
    
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self);
        make.top.equalTo(self.mas_top).with.offset(20 * KSizeScaleY);
    }];
    
    [self.n_dishesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.nameLabel);
        make.top.equalTo(self.nameLabel.mas_bottom).with.offset(10 * KSizeScaleY);
        
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.n_dishesLabel);
        make.top.equalTo(self.n_dishesLabel.mas_bottom).with.offset(20 * KSizeScaleY);
        make.bottom.equalTo(self.mas_bottom).with.offset(-20 * KSizeScaleY);
        
        
    }];
    

}

#pragma mark -懒加载
-(UILabel *)nameLabel{


    if (!_nameLabel) {
        
        _nameLabel = [[UILabel alloc] init];
        
//        [_nameLabel sizeToFit];
         _nameLabel.font = [UIFont systemFontOfSize:17];
        
        [self addSubview:_nameLabel];
    }
//
    return _nameLabel;

}

-(UILabel *)descLabel {

    if (!_descLabel) {
        
        _descLabel = [[UILabel alloc] init];
        _descLabel.font = [UIFont systemFontOfSize:15];
        
//        [_descLabel sizeToFit];
        [self addSubview:_descLabel];
    }
    
    return _descLabel;

}

-(UILabel *)n_dishesLabel {

    if (!_n_dishesLabel) {
        
        _n_dishesLabel = [[UILabel alloc] init];
        
//        [_n_dishesLabel sizeToFit];
        _n_dishesLabel.font = [UIFont systemFontOfSize:15];
        _n_dishesLabel.textColor = [UIColor lightGrayColor];
        
        [self addSubview:_n_dishesLabel];
        
    }
    return _n_dishesLabel;

}

@end
