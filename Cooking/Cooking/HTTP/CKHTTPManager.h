//
//  CKHTTPManager.h
//  Cooking
//
//  Created by ocarol on 16/2/4.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


@interface CKHTTPManager : NSObject

/** 单例 */
+ (nullable CKHTTPManager *)shareManager;

// ------------------------------------------- 网络请求 -------------------------------------------
/* 网络请求 GET */
- (void)GET:(nullable NSString *)URLString
 parameters:(nullable id)parameters
   progress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgress
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

/* 网络请求 POST */
- (void)POST:(nullable NSString *)URLString
  parameters:(nullable id)parameters
    progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

// ------------------------------------------- 本地请求 -------------------------------------------
/* 本地请求 */
- (void)Local:(nullable NSString *)fileURL
      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

// ------------------------------------------- 网络和本地请求 -------------------------------------------
/* 网络和本地请求 GET */
- (void)GET:(nullable NSString *)url
    fileURL:(nullable NSString *)fileURL
  parameter:(nullable NSDictionary *)parameter
   progress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgress
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

/* 网络和本地请求 POST */
- (void)POST:(nullable NSString *)url
     fileURL:(nullable NSString *)fileURL
   parameter:(nullable NSDictionary *)parameter
    progress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgress
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;



@end
