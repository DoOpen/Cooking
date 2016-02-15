//
//  MComunitySocialModel.h
//  Cooking
//
//  Created by ocarol on 16/2/15.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MComunitySocialLastAuthorsModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, copy) NSString *photo60;
@property (nonatomic, copy) NSString *photo160;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *photo;
@property (nonatomic, copy) NSString *mail;
@property (nonatomic, copy) NSString *user_id;
@property (nonatomic, assign) BOOL is_expert;

@end



@interface MComunitySocialModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray<MComunitySocialLastAuthorsModel *> *latest_authors;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, copy) NSString *contentType;

@end



