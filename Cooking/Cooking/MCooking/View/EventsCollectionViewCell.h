//
//  EventsCollectionViewCell.h
//  Cooking
//
//  Created by 李永方 on 16/2/16.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventsCollectionViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *breakBgimage;

@property (weak, nonatomic) IBOutlet UIImageView *breakTheamImage;

@property (weak, nonatomic) IBOutlet UILabel *breakNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *breakNumLbl;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@end
