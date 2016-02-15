//
//  MCookModel.m
//  Cooking
//
//  Created by 李永方 on 16/2/11.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "MCookModel.h"

@implementation MCookModel

#pragma mark-MTLJSONSerializing协议方法的实现

+(NSDictionary *)JSONKeyPathsByPropertyKey {
    
    return @{
        
        @"pop_events" : @"pop_events",
        @"pop_recipe_picurl" : @"pop_recipe_picurl",
        @"navs": @"navs",
        
        //pop_events数组集合
        @"events": @"pop_events.events",
       
        };

}

// 模型里面的数组(映射数组里的方法)
+ (NSValueTransformer *)navsJSONTransformer {
    return [MTLJSONAdapter arrayTransformerWithModelClass:[MCookHeadViewNavs class]];
}

+ (NSValueTransformer *)eventsJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[McookheadEvents class]];
    
}

@end


@implementation MCookHeadViewNavs

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    
    return @{
             
             @"url" : @"url",
             @"name" : @"name",
             @"picurl" : @"picurl"
             
             };
}

@end


@implementation McookheadEvents

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    
    return @{
             
             @"n_dishes" : @"n_dishes",
             @"customization" : @"customization",
             @"ID" : @"id",
             @"dishes" : @"dishes.dishes",
             @"name" : @"name"
             
             };
}

@end


@implementation McookRedBagModel

+ (NSDictionary *) JSONKeyPathsByPropertyKey {

    return @{

        @"start_time" : @"start_time",
        @"ad_type" : @"ad_type",
        @"end_time" : @"end_time",
        @"ad_info" : @"ad_info"

    };

}

@end


