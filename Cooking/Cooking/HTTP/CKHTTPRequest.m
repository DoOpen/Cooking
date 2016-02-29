//
//  CKHTTPRequest.m
//  Cooking
//
//  Created by ocarol on 16/2/4.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import "CKHTTPRequest.h"

/** 请求成功 执行的代码块 */
#define CKSUCCESS(CKurl)     if ([delegate respondsToSelector:@selector(requestFinished:cmd:postdict:)] && delegate != nil)	[delegate requestFinished:responseObject cmd:CKurl postdict:parameter];
/** 请求失败 执行的代码块 */
#define CKFAILFUL(CKurl)     if ([delegate respondsToSelector:@selector(requestFailWithError:cmd:postdict:)] && delegate != nil) [delegate requestFailWithError:error cmd:CKurl postdict:parameter];

#define CKHTTPURL  KStrNOTNULL(fileURL) ? fileURL : url

@implementation CKHTTPRequest

// ------------------------------------------- 网络请求 -------------------------------------------
+ (void)GET:(__weak id<CKHTTPRequestDelegate>)delegate URL:(NSString *)url parameter:(NSDictionary *)parameter {

    [[CKHTTPManager shareManager] GET:url
                           parameters:parameter
                             progress:nil
                              success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                                  CKSUCCESS(url);
                              } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                                  CKFAILFUL(url);
                              }];

}

+ (void)POST:(__weak id<CKHTTPRequestDelegate>)delegate URL:(NSString *)url parameter:(NSDictionary *)parameter {

[[CKHTTPManager shareManager] POST:url
                        parameters:parameter
                          progress:nil
                           success:^(NSURLSessionDataTask *task, id  _Nullable responseObject) {
                               CKSUCCESS(url);
                           } failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
                               CKFAILFUL(url);
                           }];
}

// ------------------------------------------- 网络和本地请求 -------------------------------------------
+ (void)GET:(__weak id<CKHTTPRequestDelegate>)delegate URL:(NSString *)url fileURL:(NSString *)fileURL parameter:(NSDictionary *)parameter {

[[CKHTTPManager shareManager] GET:url
                          fileURL:fileURL
                        parameter:parameter
                         progress:nil
                          success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
                              CKSUCCESS(CKHTTPURL);
                          }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
                              CKFAILFUL(CKHTTPURL);
                          }];
}

+ (void)POST:(__weak id<CKHTTPRequestDelegate>)delegate URL:(NSString *)url fileURL:(NSString *)fileURL parameter:(NSDictionary *)parameter {
    
    [[CKHTTPManager shareManager] POST:url
                              fileURL:fileURL
                            parameter:parameter
                             progress:nil
                              success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
                                  CKSUCCESS(CKHTTPURL);
                              }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
                                  CKFAILFUL(CKHTTPURL);
                              }];
}

// ------------------------------------------- 本地请求 -------------------------------------------
/* 本地请求 */
+ (void)Local:(__weak id<CKHTTPRequestDelegate>)delegate fileURL:(NSString *)fileURL {
    NSDictionary *parameter = nil;
    [[CKHTTPManager shareManager] Local:fileURL
                                success:^(NSURLSessionDataTask * _Nullable task, id  _Nullable responseObject) {
                                    CKSUCCESS(fileURL);
                                }failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error) {
                                    CKFAILFUL(fileURL);
                                }];

}


+ (void)getSocial:(id<CKHTTPRequestDelegate>)delegate params:(NSDictionary *)params {
    [self GET:delegate URL:cmd_v2_social parameter:nil];
}

/** 首页*/
+ (void)getCookingHeadData:(id<CKHTTPRequestDelegate>)delegate params:(NSDictionary *)params {
    
    [self GET:delegate URL:HEADVIEWDATAURL parameter:params];
    
    [self GET:delegate URL:REDBAGURL parameter:params];
    
//    NSString *url = KFILEPATH(FILE_ISSUEURL);
    
    [self GET:delegate URL:ISSUEURL fileURL:FILE_ISSUEURL parameter:nil];

}

/** 市集*/
+ (void)getMarketReuest:(id<CKHTTPRequestDelegate>)delegate params:(NSDictionary *)params {

    [self GET:delegate URL:MARKETURL parameter:nil];

}

@end
