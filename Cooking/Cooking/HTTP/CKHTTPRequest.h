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


@end
