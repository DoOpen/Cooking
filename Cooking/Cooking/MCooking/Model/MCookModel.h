//
//  MCookModel.h
//  Cooking
//
//  Created by YongFangLili on 16/2/11.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <Mantle/Mantle.h>
@class MCookHeadViewNavs;
@class McookheadEvents;
@class McookissueModel;
@class McookissueItemsModel;

/**主要模型*/
@interface MCookModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,strong) NSDictionary *pop_events;

@property (nonatomic,strong) NSArray <MCookHeadViewNavs *>* navs;
/**本周流行菜谱图片url*/
@property (nonatomic,copy) NSString *pop_recipe_picurl;

@property (nonatomic,strong) NSArray <McookheadEvents *> *events;

@property (nonatomic,assign) NSInteger count;


@end


/**navs 模型*/
@interface MCookHeadViewNavs : MTLModel<MTLJSONSerializing>

/**链接 url*/
@property (nonatomic,copy) NSString *url;
/**链接 名称*/
@property (nonatomic,copy) NSString *name;
/**链接 图片*/
@property (nonatomic,copy) NSString *picurl;

@end

/**events 模型*/
@interface McookheadEvents:MTLModel<MTLJSONSerializing>
@property (nonatomic,assign)NSInteger n_dishes;
@property (nonatomic,strong)NSDictionary *customization;
@property (nonatomic,copy)NSString *ID;
@property (nonatomic,strong)NSArray *dishes;
@property (nonatomic,copy)NSString *name;

@end


/**红包 模型*/
@interface McookRedBagModel : MTLModel<MTLJSONSerializing>

@property (nonatomic,copy)   NSString *start_time;
@property (nonatomic,assign) NSInteger ad_type;
@property (nonatomic,assign) NSString *end_time;
@property (nonatomic,strong) NSDictionary *ad_info;
@property (nonatomic,copy)   NSString *url;
@property (nonatomic,assign) NSInteger width;
@property (nonatomic,assign) NSInteger height;

@end

/**cell模型*/
@interface McookCellModel : MTLModel<MTLJSONSerializing>
@property (nonatomic,assign) BOOL has_next;
@property (nonatomic,assign) BOOL has_prev;
@property (nonatomic,copy)   NSString *next;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSArray<McookissueModel *> *issues;
@end

@interface McookissueModel : MTLModel<MTLJSONSerializing>
@property (nonatomic,assign) NSInteger items_count;
@property (nonatomic,copy)   NSString *title;
@property (nonatomic,strong) NSArray<McookissueItemsModel *> *items;
@property (nonatomic,assign) NSInteger issue_id;
@property (nonatomic,copy)   NSString *publish_date;
@property (nonatomic,strong) NSArray *today_events;
@end

@interface McookissueItemsModel : MTLModel<MTLJSONSerializing>
@property (nonatomic,copy)   NSString *publish_time;
@property (nonatomic,copy)   NSString *url;
@property (nonatomic,assign) NSInteger templated;
@property (nonatomic,assign) NSInteger ID;
//contents
@property (nonatomic,copy)   NSString *title_2nd;
@property (nonatomic,copy)   NSString *title_1st;
@property (nonatomic,copy)   NSString *title;
@property (nonatomic,assign) NSInteger n_cooked;
@property (nonatomic,assign) NSInteger n_dishes;
@property (nonatomic,copy)   NSString *recipe_id;
@property (nonatomic,copy)   NSString *desc;

//contens -image
@property (nonatomic,copy)   NSString *imageurl;
@property (nonatomic,copy)   NSString *imagewidth;
@property (nonatomic,copy)   NSString *imageheight;
//contens -author
@property (nonatomic,copy)   NSString *authorUrl;
@property (nonatomic,copy)   NSString *authorPhoto;
@property (nonatomic,copy)   NSString *authorId;
@property (nonatomic,copy)   NSString *authorname;

@end
