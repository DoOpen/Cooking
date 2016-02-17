//
//  CKHTTPRequest.m
//  Cooking
//
//  Created by ocarol on 16/2/4.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import "CKHTTPRequest.h"

/** 请求成功 执行的代码块 */
#define HTTPSUCCESS     if ([delegate respondsToSelector:@selector(requestFinished:cmd:postdict:)] && delegate != nil)	[delegate requestFinished:responseObject cmd:url postdict:parameter];
/** 请求失败 执行的代码块 */
#define HTTPfAILFUL     if ([delegate respondsToSelector:@selector(requestFailWithError:cmd:postdict:)] && delegate != nil)	[delegate requestFailWithError:error cmd:url postdict:parameter];

@implementation CKHTTPRequest

+ (void)GET:(__weak id<CKHTTPRequestDelegate>)delegate URL:(NSString *)url parameter:(NSDictionary *)parameter {

    [[CKHTTPManager shareManager] GET:url
                           parameters:parameter
                             progress:nil
                              success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                                        HTTPSUCCESS
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                                        HTTPfAILFUL
                              }];

}

+ (void)POST:(__weak id<CKHTTPRequestDelegate>)delegate URL:(NSString *)url parameter:(NSDictionary *)parameter {

[[CKHTTPManager shareManager] POST:url
                        parameters:parameter
                          progress:nil
                           success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                                    HTTPSUCCESS
                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                                   HTTPfAILFUL
                           }];
}

+ (void)getSocial:(id<CKHTTPRequestDelegate>)delegate params:(NSDictionary *)params {
    [self GET:delegate URL:cmd_v2_social parameter:nil];
}

/** 首页*/
+ (void)getCookingHeadData:(id<CKHTTPRequestDelegate>)delegate params:(NSDictionary *)params {
    
    [self GET:delegate URL:HEADVIEWDATAURL parameter:params];
    
    [self GET:delegate URL:REDBAGURL parameter:params];
    
    [self GET:delegate URL:ISSUEURL parameter:params];

}
@end
