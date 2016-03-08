//
//  MCookModel.m
//  Cooking
//
//  Created by YongFangLili on 16/2/11.
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
        @"count" : @"pop_events.count"
       
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
        @"ad_info" : @"ad_info",
        @"url" : @"ad_info.url",
        @"width" : @"ad_info.image.width",
        @"height" : @"ad_info.image.height"
        
    };

}

@end

/**cell模型*/
@implementation McookCellModel

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    
    return @{
             @"has_next" : @"cursor.has_next",
             @"has_prev" : @"cursor.has_prev",
             @"next" : @"cursor.next",
             @"count" : @"count",
             @"issues" : @"issues",
            };
}

+ (NSValueTransformer *)issuesJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[McookissueModel class]];
    
}

@end

/*issue*/
@implementation McookissueModel

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
   
    return @{
             
            @"items_count" : @"items_count",
            @"title" : @"title",
            @"items" : @"items",
            @"issue_id" : @"issue_id",
            @"publish_date" : @"publish_date",
            @"today_events" : @"today_events"
    };
}
+ (NSValueTransformer *)itemsJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[McookissueItemsModel class]];
}

@end

/*items*/
@implementation McookissueItemsModel

+ (NSDictionary *) JSONKeyPathsByPropertyKey {
    
    
    return @{
             
             @"publish_time" : @"publish_time",
             @"url" : @"url",
             @"templated" : @"template",
             @"ID" : @"id",
             @"title_2nd" : @"contents.title_2nd",
             @"title_1st" : @"contents.title_1st",
             @"title" : @"contents.title",
             @"n_cooked" : @"contents.n_cooked",
             @"n_dishes" : @"contents.n_dishes",
         
             
             @"recipe_id" : @"contents.recipe_id",
             @"desc" : @"contents.desc",
             @"score" : @"contents.score",
             
             @"imageurl" : @"contents.image.url",
             @"imagewidth" : @"contents.image.width",
             @"imageheight" : @"contents.image.height",
             
             @"authorUrl" : @"contents.author.url",
             @"authorPhoto" : @"contents.author.photo",
             @"authorId" : @"contents.author.id",
             @"authorname" : @"contents.author.name",
             
             
             };
}

+ (NSValueTransformer *)n_dishesJSONTransformer {
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSString *dished = value;
        NSNumber *disheM = @(dished.integerValue);
        return disheM;
    }];
    
//    return [MTLValueTransformertransformerUsingForwardBlock:^id(id value,BOOL *success, NSError *__autoreleasing *error) {
//        
//        NSNumber *num = value;
//        
//        NSString *tempStr = [NSStringstringWithFormat:@"%@", num];
//        
//        return tempStr;
//        
//    } reverseBlock:^id(id value,BOOL *success, NSError *__autoreleasing *error) {
//        
//        NSString *tempStr = value;
//        
//        NSNumber *tempNum = @(tempStr.integerValue);
//        
//        return tempNum;
//        
//    }];
}

+ (NSValueTransformer *)n_cookedJSONTransformer {
    
    return [MTLValueTransformer transformerUsingForwardBlock:^id(id value, BOOL *success, NSError *__autoreleasing *error) {
        
        NSString *n_cooked = value;
        NSNumber *n_cookedM = @(n_cooked.integerValue);
        
        
        return n_cookedM;
    }];
    
   }


@end


///**pop 模型*/
//@implementation McookPopModel
//
//+ (NSDictionary *) JSONKeyPathsByPropertyKey {
//    return @{
//
//        @"count" : @"count",
//        @"recipe_id" : @"recipe_id"
//    };
//    
//}
//
//
//@end
//
//

@implementation mcookEventDetail


+(NSDictionary *) JSONKeyPathsByPropertyKey {

    return @{
             
             @"name" : @"event.name",
             @"n_dishes" : @"event.n_dishes",
             @"desc" : @"event.desc",
             @"ID" : @"event.id"
             
             };
}

@end

@implementation McookEventDetailCellModel

+(NSDictionary *) JSONKeyPathsByPropertyKey {

    return @{

            @"total" : @"total",
            @"count" : @"count",
            @"dishes":@"dishes"

    };

}
+ (NSValueTransformer *)dishesJSONTransformer {
    
    return [MTLJSONAdapter arrayTransformerWithModelClass:[McookEventDetailDishesM class]];
}


@end

@implementation McookEventDetailDishesM

+(NSDictionary *) JSONKeyPathsByPropertyKey {
    
    return @{
             
             @"thumbnail" : @"thumbnail",
             @"ndiggs" : @"ndiggs",
             @"desc" : @"desc",
             @"name": @"name",
             @"authorPhoto60":@"author.photo60",
             @"authorHometown_location":@"author.hometown_location",
             @"authorName":@"author.name",
             @"events" : @"events"
             
             };
    
}



@end


