//
//  CKHTTPManager.m
//  Cooking
//
//  Created by ocarol on 16/2/4.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import "CKHTTPManager.h"

#define CKHTTPFILEPATH(fileName) [[NSBundle mainBundle] pathForResource:fileName ofType:@""]
#define CKHTTPStrNOTNULL(f) (f!=nil && [f isKindOfClass:[NSString class]] && ![f isEqualToString:@""])

static CKHTTPManager *instance = nil;

@implementation CKHTTPManager

/** 单例 */
+ (CKHTTPManager *)shareManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;

}


// ------------------------------------------- 网络请求 -------------------------------------------
/* 网络请求 GET */
- (void)GET:(nullable NSString *)URLString
 parameters:(nullable id)parameters
   progress:(nullable void (^)(NSProgress *downloadProgress)) downloadProgress
    success:(nullable void (^)(NSURLSessionDataTask *task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError *error))failure {

    NSURL *nsurl = [NSURL URLWithString:BASEURL];
    nsurl = [NSURL URLWithString:URLString relativeToURL:nsurl];
    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    [session GET:URLString parameters:parameters progress:downloadProgress success:success failure:failure];

}

/* 网络请求 POST */
- (void)POST:(nullable NSString *)URLString
  parameters:(nullable id)parameters
    progress:(nullable void (^)(NSProgress * _Nullable uploadProgress)) uploadProgress
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {

    AFHTTPSessionManager *session = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:BASEURL]];
    [session POST:URLString parameters:parameters progress:uploadProgress success:success failure:failure];

}



// ------------------------------------------- 本地请求 -------------------------------------------
/* 本地请求 */
- (void)Local:(nullable NSString *)fileURL
      success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
      failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    
    NSString *filePath = CKHTTPFILEPATH(fileURL);
    
    if (CKHTTPStrNOTNULL(filePath)) {
        NSData *data=[NSData dataWithContentsOfFile:filePath];
        id responseObject=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if (responseObject != nil) {
            (success ==nil) ? nil : success(nil,responseObject);
            
        }else{
            if (failure) {
                NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"local file :%@ load data failed!",fileURL]};
                failure(nil,[NSError errorWithDomain:@"cn.DoOpen.Cooking" code:-1 userInfo:userInfo]);
            }
        }
    }else{
        if (failure) {
            NSDictionary *userInfo = @{ NSLocalizedDescriptionKey : [NSString stringWithFormat:@"local file :%@ not found!",fileURL]};
            failure(nil,[NSError errorWithDomain:@"cn.DoOpen.Cooking" code:-1 userInfo:userInfo]);
        }
    }
    
}



// ------------------------------------------- 网络和本地请求 -------------------------------------------
/* 网络和本地请求 GET */
- (void)GET:(nullable NSString *)url
    fileURL:(nullable NSString *)fileURL
  parameter:(nullable NSDictionary *)parameter
   progress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgress
    success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
    failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    [self Type:@"GET" request:url fileURL:fileURL parameter:parameter progress:downloadProgress success:success failure:failure];
}

/* 网络和本地请求 POST */
- (void)POST:(nullable NSString *)url
     fileURL:(nullable NSString *)fileURL
   parameter:(nullable NSDictionary *)parameter
    progress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgress
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    [self Type:@"POST" request:url fileURL:fileURL parameter:parameter progress:downloadProgress success:success failure:failure];
}


- (void)Type:(nullable NSString *)Type
     request:(nullable NSString *)url
     fileURL:(nullable NSString *)fileURL
   parameter:(nullable NSDictionary *)parameter
    progress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgress
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    if (!CKHTTPStrNOTNULL(fileURL)) { //当filePath为空时，只支持网络请求
        [self HTTP:Type request:url parameter:parameter progress:downloadProgress success:success failure:failure];
        
    }else if(CKHTTPStrNOTNULL(url)) { // 当filePath和url均有值时，先本地请求，再网络请求
        [self Local:fileURL success:success failure:^(NSURLSessionDataTask * _Nullable task, NSError *error) {
            [self HTTP:Type request:url parameter:parameter progress:downloadProgress success:success failure:failure];
        }];
    }else{ // 当filePath有值，url为空时，只支持本地请求
        [self Local:fileURL success:success failure:nil];
    }
}


- (void)HTTP:(nullable NSString *)Type
     request:(nullable NSString *)url
   parameter:(nullable NSDictionary *)parameter
    progress:(nullable void (^)(NSProgress * _Nullable downloadProgress)) downloadProgress
     success:(nullable void (^)(NSURLSessionDataTask * _Nullable task, id _Nullable responseObject))success
     failure:(nullable void (^)(NSURLSessionDataTask * _Nullable task, NSError * _Nullable error))failure {
    
    if ([Type isEqualToString:@"GET"]) {
        [self GET:url parameters:parameter progress:downloadProgress success:success failure:failure];
    }else if ([Type isEqualToString:@"POST"])
        [self POST:url parameters:parameter progress:downloadProgress success:success failure:failure];
}


@end
