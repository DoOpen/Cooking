//
//  issueTemplate1Cell.m
//  Cooking
//
//  Created by 李永方 on 16/2/18.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "issueTemplate1Cell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>

static NSString *ID = @"emplate1Cell";

@interface issueTemplate1Cell()

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *SerperatorView;

@end

@implementation issueTemplate1Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+(instancetype)issueWithTabelView:(UITableView *)tabelview {

    issueTemplate1Cell *cell = [tabelview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[issueTemplate1Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    }
    return cell;
}

-(void)setIssueItemM:(McookissueItemsModel *)issueItemM {

    _issueItemM = issueItemM;
    [self setupUI:issueItemM];
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
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:issueM.imageurl]];
    [self.contentView addSubview:self.titleImage];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.text = issueM.title;
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.titleLabel];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.text = issueM.desc;
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    [self.contentView addSubview:self.descLabel];
    
    self.SerperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 10 * KSizeScaleY)];
    self.SerperatorView.backgroundColor = KMainBackgroudColor;
    [self.contentView addSubview:self.SerperatorView];
    

}

-(void)setUpFrame:(McookissueItemsModel *)issueM {
    
    CGFloat scale =[issueM.imageheight doubleValue] / [issueM.imagewidth doubleValue];
    
    CGFloat imageY = KScreenWidth * scale;
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).with.offset(0); //with is an optional semantic

        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        
        make.width.equalTo(self.contentView.mas_width);
        
        make.height.equalTo(@(imageY));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleImage.mas_bottom).with.offset(20);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(20);
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(20);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(20);
        make.bottom.equalTo(self.SerperatorView.mas_top).with.offset(-30);
        

    }];
    
    [self.SerperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.equalTo(@(10 *KSizeScaleY));
    }];

}
@end
