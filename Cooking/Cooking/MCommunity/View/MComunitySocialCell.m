//
//  MComunitySocialCell.m
//  Cooking
//
//  Created by ocarol on 16/2/10.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "MComunitySocialCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#define latest_authore_photo(x) latest_authore_photo_x

@interface MComunitySocialCell()


@property (weak, nonatomic) IBOutlet UIImageView *latest_authore_photo_0;

@property (weak, nonatomic) IBOutlet UIImageView *latest_authore_photo_1;

@property (weak, nonatomic) IBOutlet UIImageView *latest_authore_photo_2;

@property (weak, nonatomic) IBOutlet UIImageView *latest_authore_photo_3;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *descLabel;


@end

@implementation MComunitySocialCell

-(void)setDataModel:(MComunitySocialModel *)dataModel {
    _dataModel = dataModel;
    
    self.nameLabel.text = dataModel.name;
    self.descLabel.text = dataModel.desc;
    
    NSArray *imageArray = @[self.latest_authore_photo_0,self.latest_authore_photo_1,self.latest_authore_photo_2,self.latest_authore_photo_3];
    
    for (int i = 0; i < dataModel.latest_authors.count; i++) {
        MComunitySocialLastAuthorsModel *lastAuthorsModel = dataModel.latest_authors[i];
        [imageArray[i] sd_setImageWithURL:[NSURL URLWithString:lastAuthorsModel.photo]];
    }

}

@end
