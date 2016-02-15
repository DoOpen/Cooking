//
//  CKHTTPRequest.h
//  Cooking
//
//  Created by ocarol on 16/2/4.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CKHTTPManager.h"

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


#define cmd_v2_social @"v2/social/init_page.json?origin=iphone&longitude=116.302625&api_sign=a853053285b17f8eea07e00143eed77b&sk=z00zJGwoQSS53CR6h04P2w&latitude=40.035940&version=5.2.2&api_key=0f9f79be1dac5f003e7de6f876b17c00"

/** 社区 */
+ (void)getSocial:(id<CKHTTPRequestDelegate>)delegate params:(NSDictionary *)params;



@end