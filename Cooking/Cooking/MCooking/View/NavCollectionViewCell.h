//
//  NavCollectionViewCell.h
//  Cooking
//
//  Created by 李永方 on 16/2/15.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCookModel.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface NavCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) UIImageView *navsView;

@property (nonatomic,strong) UILabel *navsLabel;

@property (nonatomic,strong) MCookHeadViewNavs *McookM;



@end
