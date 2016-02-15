//
//  MComunitySocialModel.m
//  Cooking
//
//  Created by ocarol on 16/2/15.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "MComunitySocialModel.h"

@implementation MComunitySocialLastAuthorsModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
    
        return @{
                 @"photo60": @"photo60",
                 @"photo160": @"photo160",
                 @"name": @"name",
                 @"photo": @"photo",
                 @"is_expert": @"is_expert",
                 @"mail": @"mail",
                 @"user_id": @"id"
                 };
   
}

@end



@implementation MComunitySocialModel

+ (NSDictionary *)JSONKeyPathsByPropertyKey {

    return @{
            @"latest_authors": @"latest_authors",
            @"name": @"name",
            @"desc": @"desc"
             };

}

// 模型里面的数组
+ (NSValueTransformer *)latest_authorsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MComunitySocialLastAuthorsModel class]];
}

@end
