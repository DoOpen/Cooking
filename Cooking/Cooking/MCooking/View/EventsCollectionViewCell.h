//
//  EventsCollectionViewCell.h
//  Cooking
//
//  Created by YongFangLili on 16/2/16.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCookModel.h"

@interface EventsCollectionViewCell : UICollectionViewCell

@property (nonatomic, assign) NSInteger CurrentIndex;
//模型数据
@property (nonatomic, strong) MCookModel * MCookM;

@end
