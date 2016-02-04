//
//  CKHTTPManager.h
//  Cooking
//
//  Created by ocarol on 16/2/4.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>


@interface CKHTTPManager : NSObject

+ (nullable CKHTTPManager *)shareManager;

- (void)GET:(nullable NSString *)URLString
                    parameters:(nullable id)parameters
                      progress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgress
                       success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                       failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;

- (void)POST:(nullable NSString *)URLString
                     parameters:(nullable id)parameters
                       progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
                        success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
                        failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure;
@end
