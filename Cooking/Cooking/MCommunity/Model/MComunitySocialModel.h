//
//  MComunitySocialModel.h
//  Cooking
//
//  Created by ocarol on 16/2/15.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface MComunitySocialLastAuthorsModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSString *photo60;
@property (nonatomic, strong) NSString *photo160;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *photo;
@property (nonatomic, strong) NSString *mail;
@property (nonatomic, strong) NSString *user_id;
@property (nonatomic, assign) BOOL is_expert;

@end



@interface MComunitySocialModel : MTLModel <MTLJSONSerializing>

@property (nonatomic, strong) NSArray<MComunitySocialLastAuthorsModel *> *latest_authors;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *desc;
@property (nonatomic, assign) NSString *contentType;

@end



