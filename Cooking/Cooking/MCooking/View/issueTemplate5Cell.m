//
//  issueTemplate5Cell.m
//  Cooking
//
//  Created by 李永方 on 16/2/18.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "issueTemplate5Cell.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <Masonry.h>


static NSString *ID = @"emplate5Cell";

@interface issueTemplate5Cell()

@property (nonatomic, strong) UIImageView *titleImage;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIView *SerperatorView;

//@property (nonatomic,strong) UILabel *scoreLabel;
@property (nonatomic,strong) UIImageView *authorImageView;
@property (nonatomic,strong) UILabel *authorName;
@property (nonatomic,strong) UILabel *nsdishesLabel;



@end

@implementation issueTemplate5Cell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

+(instancetype)issueWithTabelView:(UITableView *)tabelview {
    
    issueTemplate5Cell *cell = [tabelview dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        
        cell = [[issueTemplate5Cell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
    }
    return cell;
}

-(void)setIssueItemM:(McookissueItemsModel *)issueItemM {
    
    _issueItemM = issueItemM;

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
    
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.textAlignment = NSTextAlignmentLeft;
    self.titleLabel.font = [UIFont systemFontOfSize:16];
    self.titleLabel.textColor = [UIColor darkGrayColor];
    self.titleLabel.numberOfLines = 0;
    [self.titleLabel sizeToFit];
    [self.contentView addSubview:self.titleLabel];
    
    self.descLabel = [[UILabel alloc] init];
    self.descLabel.font = [UIFont systemFontOfSize:13];
    self.descLabel.textColor = [UIColor grayColor];
    self.descLabel.textAlignment = NSTextAlignmentLeft;
    self.descLabel.numberOfLines = 0;
    [self.contentView addSubview:self.descLabel];
    
    self.nsdishesLabel = [[UILabel alloc] init];
    self.nsdishesLabel.font = [UIFont systemFontOfSize:10];
    self.nsdishesLabel.textColor = [UIColor lightGrayColor];
    self.nsdishesLabel.textAlignment = NSTextAlignmentLeft;
    [self.nsdishesLabel sizeToFit];
    [self.contentView addSubview:self.nsdishesLabel];
    
    //author
    self.authorImageView = [[UIImageView alloc] init];
    self.authorImageView.layer.cornerRadius = 25;
    self.authorImageView.layer.masksToBounds = YES;
    UITapGestureRecognizer *Tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Clickauthorimage:)];
    self.authorImageView.userInteractionEnabled = YES;
    [self.authorImageView addGestureRecognizer:Tap];
    [self.contentView addSubview:self.authorImageView];
    
    self.authorName = [[UILabel alloc] init];
    self.authorName.font = [UIFont systemFontOfSize:10];
    self.authorName.textColor = [UIColor lightGrayColor];
    self.authorName.textAlignment = NSTextAlignmentCenter;
    [self.authorName sizeToFit];
    [self.contentView addSubview:self.authorName];
    
    
    //分割线
    self.SerperatorView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, 10 * KSizeScaleY)];
    self.SerperatorView.backgroundColor = KMainBackgroudColor;
    [self.contentView addSubview:self.SerperatorView];
    
    
}

-(void)setUpFrame:(McookissueItemsModel *)issueM {
    
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:issueM.imageurl]];
    
    self.titleLabel.text = issueM.title;
         [self.titleLabel sizeToFit];
    self.descLabel.text = issueM.desc;
         [self.descLabel sizeToFit];
//    NSString *n_dishes ;
//    if ([issueM.n_dishes isKindOfClass:[NSString class]]) {
//        
//        n_dishes = issueM.n_dishes;
//        
//    }else {
//    
//        n_dishes = [NSString stringWithFormat:@"%ld",(long)issueM.n_dishes];
//    
//    
//    }
     NSInteger inter = [issueM.n_dishes integerValue];
    if ([issueM.score isEqualToString:@""]) {
       
        self.nsdishesLabel.text = [NSString stringWithFormat:@"%ld人做过",inter];
//        self.nsdishesLabel.text = [NSString stringWithFormat:@"%@人做过",n_dishes];
        
        }else {
            
        NSString *score = [issueM.score substringToIndex:3];
            
        self.nsdishesLabel.text = [NSString stringWithFormat:@"%@分 · %ld人做过",score,inter];
//         self.nsdishesLabel.text = [NSString stringWithFormat:@"%@分 · %@人做过",score,n_dishes];
    }
    
    //author
    [self.authorImageView sd_setImageWithURL:[NSURL URLWithString:issueM.authorPhoto]];
    self.authorName.text = issueM.authorname;
    
    CGFloat scale =[issueM.imageheight doubleValue] / [issueM.imagewidth doubleValue];
    
    CGFloat imageY = KScreenWidth * scale;
    
    [self.titleImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.contentView.mas_top).with.offset(0); //with is an optional semantic
        
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        
        make.width.equalTo(self.contentView.mas_width);
        
        make.height.equalTo(@(imageY));
    }];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleImage.mas_bottom).with.offset(15);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        
    }];
    
    [self.descLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);

    }];
    
    [self.nsdishesLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.descLabel.mas_bottom).with.offset(10);
        make.left.equalTo(self.contentView.mas_left).with.offset(20);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        
    }];
    
    [self.SerperatorView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.nsdishesLabel.mas_bottom).with.offset(20);
        make.left.equalTo(self.contentView.mas_left).with.offset(0);
        make.right.equalTo(self.contentView.mas_right).with.offset(0);
        make.bottom.equalTo(self.contentView.mas_bottom).with.offset(0);
        make.height.equalTo(@(10 *KSizeScaleY));
    }];
    
    //author
    [self.authorImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.titleImage.mas_bottom).with.offset(-12.5);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        make.width.equalTo(@(50));
        make.height.equalTo(@(50));
    
    }];
    
    [self.authorName mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(self.authorImageView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.authorImageView.mas_centerX);
        make.right.equalTo(self.contentView.mas_right).with.offset(-20);
        
        
    }];
}

-(void)Clickauthorimage:(UITapGestureRecognizer *)sender {


    NSLog(@"你点击了我");

}


@end

