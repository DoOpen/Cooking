//
//  issueTemplate2Cell.m
//  Cooking
//
//  Created by 李永方 on 16/2/18.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "issueTemplate2Cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>


static NSString *ID = @"emplate2Cell";

@interface issueTemplate2Cell()

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *title_1Label;
@property (nonatomic, strong) UILabel *title_2Label;
@property (nonatomic, strong) UIView *SerperatorView;

@end

@implementation issueTemplate2Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(instancetype)issueWithTabelView:(UITableView *)tabelview {
    
    issueTemplate2Cell *cell = [tabelview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[issueTemplate2Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];

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
        [self setupUI:self.issueItemM];
    }
    return  self;
}

-(void)setupUI:(McookissueItemsModel *)issueM {
    
    
    self.titleImage = [[UIImageView alloc] init];
    
    [self.contentView addSubview:self.titleImage];
    
    self.title_1Label = [[UILabel alloc] init];
    self.title_1Label.numberOfLines = 0;
    
    self.title_1Label.textAlignment = NSTextAlignmentCenter;
    self.title_1Label.font = [UIFont fontWithName:@"Helvetica-Bold" size:22];
//    labelname.font = [UIFont fontWithName:@"Helvetica-Bold" size:15];
    self.title_1Label.textColor = [UIColor whiteColor];
    
    [self.title_1Label sizeToFit];
    
    [self.titleImage addSubview:self.title_1Label];
    
    self.title_2Label = [[UILabel alloc] init];
    self.title_2Label.font = [UIFont systemFontOfSize:15];
    self.title_2Label.textColor = [UIColor whiteColor];
    self.title_2Label.textAlignment = NSTextAlignmentCenter;
    self.title_2Label.numberOfLines = 0;
    [self.title_2Label sizeToFit];
    [self.titleImage addSubview:self.title_2Label];
    
    self.SerperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 10 * KSizeScaleY)];
    self.SerperatorView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.SerperatorView];
    
    
}

-(void)setUpFrame:(McookissueItemsModel *)issueM {
    
    CGFloat scale =[issueM.imageheight doubleValue] / [issueM.imagewidth doubleValue];
    
    CGFloat imageY = KScreenWidth * scale;
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:issueM.imageurl]];
    self.title_2Label.text = issueM.title_2nd;
    self.title_1Label.text = issueM.title_1st;
    
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).with.offset(0); //with is an optional semantic
        
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        
        make.width.equalTo(self.contentView.mas_width);
        
        make.height.equalTo(@(imageY));
    }];
    
    [self.title_1Label mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerX.equalTo(self.titleImage.mas_centerX);
        make.centerY.equalTo(self.titleImage.mas_centerY);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        
    }];
    
    [self.title_2Label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.title_1Label.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.titleImage.mas_centerX);
        
        
    }];
    
    [self.SerperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleImage.mas_bottom).with.offset(0);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.equalTo(@(10 *KSizeScaleY));
    }];
    
}

@end
