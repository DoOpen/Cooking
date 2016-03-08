//
//  EventsCollectionViewController.h
//  Cooking
//
//  Created by 李永方 on 16/2/16.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MCookModel.h"
//@class EventsCollectionViewController;
//@protocol EventsCollectionViewControllerDelegate <NSObject>
//
//-(void)didSelectedEvents:(EventsCollectionViewController *)eventVc;
//
//@end

@interface EventsCollectionViewController : UICollectionViewController

@property (nonatomic, strong) MCookModel * MCookM;

@property (nonatomic, copy) void(^eventBlock)();

///**代理*/
//@property (nonatomic,weak)id<EventsCollectionViewControllerDelegate>delegate;

@end
