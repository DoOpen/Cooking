//
//  EventDetailHeadView.h
//  Cooking
//
//  Created by 李永方 on 16/3/8.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mcookEventDetail;

@interface EventDetailHeadView : UICollectionReusableView

@property (nonatomic,strong)mcookEventDetail *eventDetailM;

+(instancetype)eventDetailHeadView:(UICollectionView *)collectionView withKind:(NSString *)kind forIndexPath:(NSIndexPath *)Indexpath;

@end
