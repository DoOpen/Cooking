//
//  CKHTTPManager.m
//  Cooking
//
//  Created by ocarol on 16/2/4.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import "CKHTTPManager.h"

static CKHTTPManager *instance = nil;

@implementation CKHTTPManager

+ (CKHTTPManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;

}

- (void)GET:(NSString *)URLString
 parameters:(nullable id)parameters
   progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
    success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {

    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    [session GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];

}

- (void)POST:(NSString *)URLString
  parameters:(nullable id)parameters
    progress:(nullable void (^)(NSProgress *uploadProgress)) uploadProgress
     success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {

    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    [session POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];

}

@end
