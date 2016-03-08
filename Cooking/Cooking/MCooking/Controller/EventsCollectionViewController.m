//
//  EventsCollectionViewController.m
//  Cooking
//
//  Created by 李永方 on 16/2/16.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "EventsCollectionViewController.h"
#import "EventsCollectionViewCell.h"
#import "eventsDetailViewController.h"

static NSString *eventsCell = @"eventsCell";

@interface EventsCollectionViewController ()<CKHTTPRequestDelegate>

@end

@implementation EventsCollectionViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"EventsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:eventsCell];
    self.collectionView.backgroundColor = [UIColor whiteColor];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.MCookM.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    EventsCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:eventsCell forIndexPath:indexPath];
    cell.CurrentIndex = indexPath.item;
    cell.MCookM = self.MCookM;
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

    McookheadEvents *eventsM = self.MCookM.events[indexPath.item];
    //早餐的数据请求

//    if ([eventsM.ID isEqualToString:@"100094175"]) {
//        
//        [CKHTTPRequest GET:self URL:@"http://api.xiachufang.com/v2/events/100094175/dishes_order_by_hot.json?offset=0&detail=true&origin=iphone&api_sign=24461f4eb529c009b0e3d0efacefa424&sk=VJLD90zORKSBXdQbpWTJ1w&limit=18&version=5.2.2&timestamp=1456827719&api_key=0f9f79be1dac5f003e7de6f876b17c00" parameter:nil];
//    }else if ([eventsM.ID isEqualToString:@"100094175"]) {
//    
//        [CKHTTPRequest GET:self URL:@"http://api.xiachufang.com/v2/events/100094176/dishes_order_by_hot.json?offset=0&detail=true&origin=iphone&api_sign=24461f4eb529c009b0e3d0efacefa424&sk=VJLD90zORKSBXdQbpWTJ1w&limit=18&version=5.2.2&timestamp=1456827719&api_key=0f9f79be1dac5f003e7de6f876b17c00" parameter:nil];
//    
//    }else{
//    
//        [CKHTTPRequest GET:self URL:@"http://api.xiachufang.com/v2/events/100094177/dishes_order_by_hot.json?offset=0&detail=true&origin=iphone&api_sign=24461f4eb529c009b0e3d0efacefa424&sk=VJLD90zORKSBXdQbpWTJ1w&limit=18&version=5.2.2&timestamp=1456827719&api_key=0f9f79be1dac5f003e7de6f876b17c00" parameter:nil];
//    }
//    //响应代理方法
//        if ([self.delegate respondsToSelector:@selector(didSelectedEvents:)]) {
//        [self.delegate didSelectedEvents:self];
//    }
    
   
    
    //执行 block 进行跳转
    self.eventBlock();
    
    
    
  }

#pragma mark-

@end
