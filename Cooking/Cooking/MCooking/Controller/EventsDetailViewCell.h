//
//  EventsDetailViewCell.h
//  Cooking
//
//  Created by 李永方 on 16/3/2.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <UIKit/UIKit.h>
@class McookEventDetailDishesM;

@interface EventsDetailViewCell : UICollectionViewCell

+(instancetype)eventDetailWithColletionView:(UICollectionView *)collectionView forIndexPath:(NSIndexPath*)IndexPath;

@property (nonatomic,strong)McookEventDetailDishesM *DishesM;

@end
