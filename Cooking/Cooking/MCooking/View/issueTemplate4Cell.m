//
//  issueTemplate4Cell.m
//  Cooking
//
//  Created by 李永方 on 16/2/18.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "issueTemplate4Cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>


static NSString *ID = @"emplate4Cell";

@interface issueTemplate4Cell()

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *SerperatorView;

@end

@implementation issueTemplate4Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(instancetype)issueWithTabelView:(UITableView *)tabelview {
    
    issueTemplate4Cell *cell = [tabelview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[issueTemplate4Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

-(void)setIssueItemM:(McookissueItemsModel *)issueItemM {
    
    _issueItemM = issueItemM;
    //    [self setupUI:issueItemM];
    [self setUpFrame:issueItemM];
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    
        [self setupUI];
        
        
    }
    
    
    return  self;
}

-(void)setupUI {
    
    
    self.titleImage = [[UIImageView alloc] init];
    [self.contentView addSubview:self.titleImage];
    
}

-(void)setUpFrame:(McookissueItemsModel *)issueM {
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:issueM.imageurl]];
    
    CGFloat scale =[issueM.imageheight doubleValue] / [issueM.imagewidth doubleValue];
    
    CGFloat imageY = KScreenWidth * scale;
    
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).with.offset(0); //with is an optional semantic
        
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        
        make.width.equalTo(self.contentView.mas_width);
        
        make.height.equalTo(@(imageY));
    }];
    
}



@end
