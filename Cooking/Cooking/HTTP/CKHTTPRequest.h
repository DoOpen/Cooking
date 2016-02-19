//
//  CKHTTPRequest.h
//  Cooking
//
//  Created by ocarol on 16/2/4.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKHTTPManager.h"

// 社区
#define cmd_v2_social @"v2/social/init_page.json?origin=iphone&longitude=116.302625&api_sign=a853053285b17f8eea07e00143eed77b&sk=z00zJGwoQSS53CR6h04P2w&latitude=40.035940&version=5.2.2&api_key=0f9f79be1dac5f003e7de6f876b17c00"

// 首页头部
#define HEADVIEWDATAURL @"/v2/init_page_v5.json?timezone=Asia%2FShanghai&api_sign=68aeeb939943f67b51a886af151b2b2b&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&version=5.2.2"
// 首页红包
#define REDBAGURL @"http://api.xiachufang.com/v2/ad/show.json?slot_name=homepage_banner_ad1&height=172.5&origin=iphone&api_sign=f2dfd7fcfcee24a68b589a1f73064b21&width=690&supported_types=1&version=5.2.2&api_key=0f9f79be1dac5f003e7de6f876b17c00"
// 首页 cell
#define ISSUEURL @"http://api.xiachufang.com/v2/issues/list.json?cursor=&origin=iphone&api_sign=8c9575b24b527a0b9011e5c5c4b33c8e&size=2&timezone=Asia%2FShanghai&version=5.2.2&api_key=0f9f79be1dac5f003e7de6f876b17c00"

// 市集 URL
#define MARKETURL @"http://www.xiachufang.com/page/ec-tab/?version=12"


@protocol CKHTTPRequestDelegate <NSObject>

@required
- (void)requestFinished:(id)responseDict cmd:(NSString*)cmd postdict:(NSDictionary*)postdict;
- (void)requestFailWithError:(NSError *)error cmd:(NSString *)cmd postdict:(NSDictionary*)postdict;
@end

@interface CKHTTPRequest : NSObject

/*----------------------------基础请求-------------------------------*/
+ (void)GET:(__weak id<CKHTTPRequestDelegate>)delegate URL:(NSString *)url parameter:(NSDictionary *)parameter;
+ (void)POST:(__weak id<CKHTTPRequestDelegate>)delegate URL:(NSString *)url parameter:(NSDictionary *)parameter;

/*----------------------------请求列表-------------------------------*/


/** 社区 */
+ (void)getSocial:(id<CKHTTPRequestDelegate>)delegate params:(NSDictionary *)params;

/** 首页 下厨房*/
+ (void)getCookingHeadData:(id<CKHTTPRequestDelegate>)delegate params:(NSDictionary *)params;

/** 市集*/
+ (void)getMarketReuest:(id<CKHTTPRequestDelegate>)delegate params:(NSDictionary *)params;


 



@end