//
//  eventsDetailViewController.m
//  Cooking
//
//  Created by 李永方 on 16/3/1.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "eventsDetailViewController.h"
#import "MCookModel.h"
#import "EventDetailHeadView.h"
#import "EventsDetailViewCell.h"
//#import "CKHTTPRequest.h"

#define BREAKFAST @"http://api.xiachufang.com/v2/events/show.json?version=5.2.2&id=100096297&api_sign=c75b74cbe23fb46f84f13ad6f7910257&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&sk=VJLD90zORKSBXdQbpWTJ1w"
#define BREAKFASTORDER @"http://api.xiachufang.com/v2/events/100096297/dishes_order_by_hot.json?offset=0&detail=true&origin=iphone&api_sign=ea89ea7a50e1762fc79d1a4430c58330&sk=VJLD90zORKSBXdQbpWTJ1w&limit=18&version=5.2.2&timestamp=1457424881&api_key=0f9f79be1dac5f003e7de6f876b17c00"
#define DINERURL @"http://api.xiachufang.com/v2/events/show.json?version=5.2.2&id=100095999&api_sign=d5c10acfc982a2a6edd1cb3d3a49333f&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&sk=VJLD90zORKSBXdQbpWTJ1w"
#define DINERDISHES @"http://api.xiachufang.com/v2/events/100095999/dishes_order_by_hot.json?offset=0&detail=true&origin=iphone&api_sign=f1cc3a66d415d303f2849b1236f90da1&sk=VJLD90zORKSBXdQbpWTJ1w&limit=18&version=5.2.2&timestamp=1457368917&api_key=0f9f79be1dac5f003e7de6f876b17c00"
#define FILE_DINERDISHES @"dishes_order_by_hot.json"


@interface eventsDetailViewController ()<CKHTTPRequestDelegate>

@property (nonatomic,strong)mcookEventDetail *eventDetail;

@property (nonatomic,strong)UICollectionReusableView *headView;

@property (nonatomic,strong)McookEventDetailCellModel *eventDetailM;

@end

@implementation eventsDetailViewController

static NSString * const reuseIdentifier = @"eventDetailCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    
    

    [self.collectionView registerClass:[EventsDetailViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self.collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];//注册header的view
    
    [self reloadEventDetailData];
    self.collectionView.backgroundColor = KMainBackgroudColor;

}

- (void)viewWillAppear:(BOOL)animated {
    [self.tabBarController.tabBar setTranslucent:YES];
    self.tabBarController.tabBar.hidden = YES;
//    self.collectionView.frame = self.view.bounds;
}

#pragma mark -刷新网络数据
-(void)reloadEventDetailData {
    
    [CKHTTPRequest GET:self URL:BREAKFAST parameter:nil];
//    [CKHTTPRequest GET:self URL:BREAKFASTORDER parameter:nil];
    [CKHTTPRequest Local:self fileURL:FILE_DINERDISHES];
   

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


}

-(void)requestFinished:(id)responseDict cmd:(NSString *)cmd postdict:(NSDictionary *)postdict{
    
    NSLog(@"%@",responseDict);
    if ([responseDict[@"status"] isEqualToString:@"ok"]){
    
        //判断是否是头部请求
        if ([cmd isEqualToString:BREAKFAST]) {
            self.eventDetail = [MTLJSONAdapter modelOfClass:[mcookEventDetail class] fromJSONDictionary:responseDict[@"content"] error:nil];
            

        }
        if ([cmd isEqualToString:BREAKFASTORDER]) {
            
            self.eventDetailM = [MTLJSONAdapter modelOfClass:[McookEventDetailCellModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
            
            
            
        }
        
        if ([cmd isEqualToString:FILE_DINERDISHES]) {
            
            self.eventDetailM = [MTLJSONAdapter modelOfClass:[McookEventDetailCellModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
            
            
            
        }

    }
    [self.collectionView reloadData];

}

-(void)requestFailWithError:(NSError *)error cmd:(NSString *)cmd postdict:(NSDictionary *)postdict{



}

#pragma mark -初始化导航栏
-(void)initNav {
    
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(goBack)];
    
    [self.navigationItem setLeftBarButtonItem:leftBar];


}


-(void)goBack{

    [self.navigationController popViewControllerAnimated:YES];

}




#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete implementation, return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of items
    return self.eventDetailM.dishes.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    McookEventDetailDishesM *dishM = self.eventDetailM.dishes[indexPath.row];
    EventsDetailViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.DishesM = dishM;
    
    // Configure the cell
    
    return cell;
}

//显示header和footer的回调方法

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath

{
    
//    if (kind == UICollectionElementKindSectionHeader)
//        　{//如果想要自定义header，只需要定义UICollectionReusableView的子类A，然后在该处使用，注意AIdentifier要设为注册的字符串，此处为“header”
//            
//            UICollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
//            view.backgroundColor = [UIColor cyanColor];
//            
//        return view;
//        }
//    
//    return nil;
    
    EventDetailHeadView *eventHeadView = [EventDetailHeadView eventDetailHeadView:collectionView withKind:kind forIndexPath:indexPath];
    eventHeadView.eventDetailM = self.eventDetail;
    return eventHeadView;
    
}

#pragma mark <UICollectionViewDelegate>

/*
// Uncomment this method to specify if the specified item should be highlighted during tracking
- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}
*/

/*
// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}
*/

/*
// Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
- (BOOL)collectionView:(UICollectionView *)collectionView shouldShowMenuForItemAtIndexPath:(NSIndexPath *)indexPath {
	return NO;
}

- (BOOL)collectionView:(UICollectionView *)collectionView canPerformAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	return NO;
}

- (void)collectionView:(UICollectionView *)collectionView performAction:(SEL)action forItemAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender {
	
}
*/

@end
