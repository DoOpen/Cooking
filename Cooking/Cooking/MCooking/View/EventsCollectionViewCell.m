//
//  EventsCollectionViewCell.m
//  Cooking
//
//  Created by YongFangLili on 16/2/16.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "EventsCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface EventsCollectionViewCell()


@property (weak, nonatomic) IBOutlet UIImageView *breakBgimage;

@property (weak, nonatomic) IBOutlet UIImageView *breakTheamImage;

@property (weak, nonatomic) IBOutlet UILabel *breakNameLbl;

@property (weak, nonatomic) IBOutlet UILabel *breakNumLbl;

@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;

@property (strong, nonatomic) NSArray *localImages;

@end


@implementation EventsCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setMCookM:(MCookModel *)MCookM {
    
    _MCookM = MCookM;
    
    McookheadEvents *eventM = MCookM.events[self.CurrentIndex];

    self.breakBgimage.contentMode = UIViewContentModeScaleToFill;
    self.breakBgimage.image = [UIImage imageNamed:self.localImages[self.CurrentIndex]];
    NSURL *url = [NSURL URLWithString:eventM.dishes[1][@"thumbnail_280"]];
    
    [self.breakTheamImage sd_setImageWithURL:url];
    self.breakBgimage.contentMode = UIViewContentModeScaleAspectFit;
    
    NSString *name = eventM.name;
    name = [name substringToIndex:2];
    self.breakNameLbl.text = name;
    [self.breakNameLbl sizeToFit];
    
    NSString *number = [NSString stringWithFormat:@"%ld作品",(long)eventM.n_dishes];
    self.breakNumLbl.text = number;
    
    self.pageControl.numberOfPages = MCookM.count;
    
    self.pageControl.currentPage = self.CurrentIndex;
    
}

-(NSArray *)localImages {

    if (!_localImages) {
        
        _localImages = @[@"themeSmallPicForBreakfast",@"themeSmallPicForLaunch",@"themeSmallPicForSupper"];
    }

    return _localImages;

}
@end
