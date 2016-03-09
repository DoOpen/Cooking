//
//  eventDesController.m
//  Cooking
//
//  Created by 李永方 on 16/3/8.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "eventDesController.h"
#import "MCookModel.h"
#import <Masonry.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIButton+Circle.h"
#import "UIImage+Circle.h"


@interface eventDesController ()<UIScrollViewDelegate>

@property (nonatomic,strong)UIScrollView *headScrollview;
@property (nonatomic,strong)NSArray *imagesArry;
@property (nonatomic,strong)UIButton *ImagePages;
@property (nonatomic,strong)UIView *desView;
@end

@implementation eventDesController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    
    [self setUpUI];
//    self.tableView.separatorStyle = NO;
    self.desView.backgroundColor = [UIColor cyanColor];
//    [self setUpDiscViewUI];
    self.tableView.contentSize = CGSizeMake(KScreenWidth, 2 * KScreenHeight);
    self.tableView.scrollEnabled = YES;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 20;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//
//    return KScreenWidth;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//
//
////    UIImageView *headView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth)];
////    [headView sd_setImageWithURL:[NSURL URLWithString:self.DishesM.photo]];
//    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth)];
//    [head addSubview:self.headScrollview];
//    [head addSubview:self.ImagePages];
//    [self.ImagePages mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(head.mas_right).with.offset(-10 * KSizeScaleX );
//        make.bottom.equalTo(head.mas_bottom).with.offset(-10 * KSizeScaleY);
//        make.width.equalTo(@(28 * KSizeScaleX));
//        make.height.equalTo(@(28 * KSizeScaleY));
//        
//    }];
//
//
//    
//    return head;
//}

-(void)setUpUI{

    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth)];
    [head addSubview:self.headScrollview];
    [head addSubview:self.ImagePages];
    [self.ImagePages mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(head.mas_right).with.offset(-10 * KSizeScaleX );
        make.bottom.equalTo(head.mas_bottom).with.offset(-10 * KSizeScaleY);
        make.width.equalTo(@(28 * KSizeScaleX));
        make.height.equalTo(@(28 * KSizeScaleY));
        
    }];
    
    [self.tableView addSubview:head];
    //去掉分割线
    self.tableView.separatorStyle = NO;

}
#pragma mark -headScrollviewDelagate

-(void)scrollViewDidScroll:(UIScrollView *)scrollView {

    CGFloat offsetX = scrollView.contentOffset.x;
    NSInteger page = offsetX / KScreenWidth + 1;
    if (offsetX < 0) {
        page = 1;
        
    }

    [self.ImagePages setTitle:[NSString stringWithFormat:@"%ld/%lu",(long)page,(unsigned long)self.imagesArry.count] forState:UIControlStateNormal];
}

-(UIScrollView *)headScrollview{
    

    if (!_headScrollview) {
        
        
        _headScrollview = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenWidth)];
        for (int i = 0; i < self.imagesArry.count; i++) {
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * KScreenWidth, 0, KScreenWidth, KScreenWidth)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:self.imagesArry[i]]];
            [_headScrollview addSubview:imageView];
        }
        
        _headScrollview.contentSize = CGSizeMake(self.imagesArry.count * KScreenWidth, KScreenWidth);
        _headScrollview.pagingEnabled = true;
        _headScrollview.showsHorizontalScrollIndicator = NO;
//        [_headScrollview addSubview:self.ImagePages];
        _headScrollview.delegate = self;
        
    }

    return _headScrollview;
}

-(NSArray *)imagesArry{

    if (!_imagesArry) {
        
        NSMutableArray *arry = [NSMutableArray array];
        [arry addObject:self.DishesM.photo];
        for (NSDictionary *dict in self.DishesM.extra_pics) {
            
            NSString *imageurl = dict[@"600"];
            [arry addObject:imageurl];
        }
        _imagesArry = arry;
    }
    return _imagesArry;

}

-(UIButton *)ImagePages {

    if (!_ImagePages) {
        
        _ImagePages = [UIButton CircleButtonWithFrame:CGRectMake(0, 0, 28 * KSizeScaleX, 28 * KSizeScaleY) withTitle:nil WithImage:nil];
        [_ImagePages setBackgroundColor:[UIColor whiteColor]];
        [_ImagePages.titleLabel setFont:[UIFont systemFontOfSize:12]];
        [_ImagePages setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        _ImagePages.userInteractionEnabled = YES;
    }

    return _ImagePages;

}

-(UIView *)desView{

    if (!_desView) {
        
        _desView = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.headScrollview.frame), KScreenWidth,2 * KScreenHeight - self.headScrollview.frame.size.height)];
        [self.tableView addSubview:_desView];
        [self setUpDiscViewUI];
    }

    return _desView;

}

-(void)setUpDiscViewUI{


    //创建图像
    UIImageView *authorPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 40, 40)];
    [authorPhoto sd_setImageWithURL:[NSURL URLWithString:self.DishesM.authorPhoto]];
    authorPhoto.layer.cornerRadius = authorPhoto.frame.size.width / 2;
    authorPhoto.layer.masksToBounds = YES;
    [_desView addSubview:authorPhoto];
    
    //创建作者名 label
    UILabel *authorLabel = [[UILabel alloc] init];
    authorLabel.text = [NSString stringWithFormat:@"%@做过", self.DishesM.authorName];
    authorLabel.font = [UIFont systemFontOfSize:14];
    [_desView addSubview:authorLabel];
   
    
    //时间 label
    UILabel *createTimeLabel = [[UILabel alloc] init];
    createTimeLabel.text = [NSString stringWithFormat:@"%@做过",self.DishesM.friendly_create_time];
    createTimeLabel.textColor = [UIColor lightGrayColor];
    createTimeLabel.font = [UIFont systemFontOfSize:14];
    [_desView addSubview:createTimeLabel];
    
//    //创建标题 view
//    [_desView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.tableView);
//        make.right.equalTo(self.tableView);
//        make.top.equalTo(self.headScrollview.mas_bottom);
//        make.bottom.equalTo(self.tableView);
//        
//    }];
    UIView *nameTitleView = [[UIView alloc] init];
    nameTitleView.backgroundColor = [UIColor whiteColor];
    nameTitleView.layer.cornerRadius = 2;
    nameTitleView.layer.masksToBounds = YES;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.text = self.DishesM.name;
    [nameLabel sizeToFit];
    nameLabel.textColor = [UIColor redColor];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [nameTitleView addSubview:nameLabel];
    [nameTitleView addSubview:arrowView];
    [_desView addSubview:nameTitleView];
    
    //创建decLabel
    UILabel *desclabel = [[UILabel alloc] init];
    desclabel.text = self.DishesM.desc;
    desclabel.numberOfLines = 0;
    desclabel.font =[UIFont systemFontOfSize:15];
    [_desView addSubview:desclabel];
    
    //点赞 label
    UIView *ndiggsView = [[UIView alloc] init];
    //分割线
    UIView *saperatorLine1 = [[UIView alloc] init];
    saperatorLine1.backgroundColor = [UIColor grayColor];
    UIView *saperatorLine2 = [[UIView alloc] init];
    saperatorLine2.backgroundColor = [UIColor grayColor];
    [ndiggsView addSubview:saperatorLine1];
    [ndiggsView addSubview:saperatorLine2];
    //label
    UILabel *ndiggsLabel = [[UILabel alloc] init];
    ndiggsLabel.text = [NSString stringWithFormat:@"%ld人赞",(long)self.DishesM.ndiggs];
    [ndiggsView addSubview:ndiggsLabel];
    [_desView addSubview:ndiggsView];
    
    
    //评论
   
    UILabel *comentLabel = [[UILabel alloc] init];
    if(self.DishesM.ncomments){
    comentLabel.text = [NSString stringWithFormat: @"所有%ld条评论",(long)self.DishesM.ncomments];
    }
    UILabel *commentLabel1 = [[UILabel alloc] init];
    
    UILabel *commentLabel2 = [[UILabel alloc] init];
    
    NSInteger count = self.DishesM.latest_comments.count ;
    if (count >2) {
         NSDictionary *comments1 = self.DishesM.latest_comments[count -2];
         NSDictionary *comments2 = self.DishesM.latest_comments[count -1];
        commentLabel1.text = [NSString stringWithFormat:@"%@:%@",comments1[@"author"][@"name"],comments1[@"txt"]];
        commentLabel1.numberOfLines = 0;
        commentLabel2.text = [NSString stringWithFormat:@"%@:%@",comments2[@"author"][@"name"],comments2[@"txt"]];
        commentLabel2.numberOfLines = 0;
        
    }
    [_desView addSubview:comentLabel];
    [_desView addSubview:commentLabel1];
    [_desView addSubview:commentLabel2];
    
   
    //编辑点赞与评论
    UIView *editCommtsView = [[UIView alloc] init];
    UIButton *ndggstBtn = [UIButton CircleButtonWithFrame:CGRectMake(0, 0, 40 * KSizeScaleX, 40 *KSizeScaleX) withTitle:nil WithImage:[UIImage imageNamed:@"dishPagerLike"]];
    UIButton *commentsBtn = [UIButton CircleButtonWithFrame:CGRectMake(0, 0, 40 * KSizeScaleX, 40 *KSizeScaleX) withTitle:nil WithImage:[UIImage imageNamed:@"dishComment"]];
    
    UIButton *sharesBtn = [UIButton CircleButtonWithFrame:CGRectMake(0, 0, 40 * KSizeScaleX, 40 *KSizeScaleX) withTitle:nil WithImage:[UIImage imageNamed:@"convenient_share_other"]];
    [editCommtsView addSubview:ndggstBtn];
    [editCommtsView addSubview:commentsBtn];
    [editCommtsView addSubview:sharesBtn];
    [_desView addSubview:editCommtsView];
    
    
    
    //设置约束
    [authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.centerY.equalTo(authorPhoto);
        make.left.equalTo(authorPhoto.mas_right).with.offset(10 * KSizeScaleX);
    }];
    
    [createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(authorPhoto);
        make.right.equalTo(_desView.mas_right).with.offset(-10 * KSizeScaleX);
    }];
    
    [nameTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(authorLabel);
        make.right.equalTo(createTimeLabel);
        make.top.equalTo(authorLabel.mas_bottom).with.offset(15 * KSizeScaleY);
        make.height.equalTo(@(40 * KSizeScaleY));
        
        
    }];
    
    
    //nameTitleView
    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(nameTitleView.mas_right).with.offset(-10*KSizeScaleX);
        make.centerY.equalTo(nameTitleView);
        make.width.equalTo(@(22));
        make.height.equalTo(@(22));
        
    }];
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameTitleView.mas_left).with.offset(10 * KSizeScaleX);
        make.right.equalTo(arrowView.mas_left).with.offset(10 * KSizeScaleX);
        make.centerY.equalTo(nameTitleView);
        
    }];
    
    //desclabel
    [desclabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(nameTitleView);
        make.right.equalTo(nameTitleView);
        make.top.equalTo(nameTitleView.mas_bottom).with.offset(10 * KSizeScaleX);
    
    }];
    
    //ndiggestView 点赞
    [ndiggsView mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.top.equalTo(desclabel.mas_bottom).with.offset(15 *KSizeScaleY);
        make.left.equalTo(desclabel);
        make.right.equalTo(desclabel);
        make.height.equalTo(nameTitleView);
    }];
    
    [saperatorLine1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ndiggsView);
        make.right.equalTo(ndiggsView);
        make.top.equalTo(ndiggsView);
        make.height.equalTo(@(1));
    }];
    [saperatorLine2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ndiggsView);
        make.right.equalTo(ndiggsView);
        make.bottom.equalTo(ndiggsView);
        make.height.equalTo(@(1));
    }];
    
    [ndiggsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(ndiggsView);
        make.right.equalTo(ndiggsView);
        make.centerY.equalTo(ndiggsView);
        
    }];
    
    //评论
    [comentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ndiggsView);
        make.right.equalTo(ndiggsView);
        make.top.equalTo(ndiggsView.mas_bottom).with.offset(10 * KSizeScaleY);
        
    }];
    [commentLabel1 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(comentLabel);
        make.right.equalTo(comentLabel);
        make.top.equalTo(comentLabel.mas_bottom).with.offset(20 * KSizeScaleY);
    }];
    
    [commentLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(commentLabel1);
        make.right.equalTo(commentLabel1);
        make.top.equalTo(commentLabel1.mas_bottom).with.offset(10 * KSizeScaleY);
    }];
    
    //编辑评论，点赞
    if (self.DishesM.latest_comments.count == 0) {
        [editCommtsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(ndiggsView);
            make.right.equalTo(ndiggsView);
            make.top.equalTo(ndiggsView.mas_bottom).with.offset(10 * KSizeScaleY);
            make.height.equalTo(@(40 * KSizeScaleY));
        }];

    }else if (self.DishesM.latest_comments.count == 1){
        [editCommtsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(commentLabel1);
            make.right.equalTo(commentLabel1);
            make.top.equalTo(commentLabel1.mas_bottom).with.offset(10 * KSizeScaleY);
            make.height.equalTo(@(40 * KSizeScaleY));
        }];
    }else{
        [editCommtsView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(commentLabel2);
            make.right.equalTo(commentLabel2);
            make.top.equalTo(commentLabel2.mas_bottom).with.offset(10 * KSizeScaleY);
            make.height.equalTo(@(40 * KSizeScaleY));
    }];}
    
    //点赞
    [ndggstBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo(editCommtsView);
        make.top.equalTo(editCommtsView);
        make.width.equalTo(@(40 * KSizeScaleY));
        make.height.equalTo(@(40 * KSizeScaleY));
        
    }];
    
    //评论 btn
    [commentsBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(ndggstBtn.mas_right).with.offset(15 * KSizeScaleX);
        make.centerY.equalTo(ndggstBtn);
        make.width.equalTo(ndggstBtn);
        make.height.equalTo(ndggstBtn);
    }];
    //分享 btn
    [sharesBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(editCommtsView.mas_right).with.offset(-10 * KSizeScaleX);
        make.centerY.equalTo(ndggstBtn);
        make.width.equalTo(ndggstBtn);
        make.height.equalTo(ndggstBtn);
    }];

}
//-(void)setUpDiscViewUI{
//    
//    
//    //创建图像
//    UIImageView *authorPhoto = [[UIImageView alloc] initWithFrame:CGRectMake(15, 14, 40, 40)];
//    [authorPhoto sd_setImageWithURL:[NSURL URLWithString:self.DishesM.authorPhoto]];
//    authorPhoto.layer.cornerRadius = authorPhoto.frame.size.width / 2;
//    authorPhoto.layer.masksToBounds = YES;
//    [self.tableView addSubview:authorPhoto];
//    
//    //创建作者名 label
//    UILabel *authorLabel = [[UILabel alloc] init];
//    authorLabel.text = [NSString stringWithFormat:@"%@做过", self.DishesM.authorName];
//    authorLabel.font = [UIFont systemFontOfSize:14];
//    [self.tableView addSubview:authorLabel];
//    
//    
//    //时间 label
//    UILabel *createTimeLabel = [[UILabel alloc] init];
//    createTimeLabel.text = [NSString stringWithFormat:@"%@做过",self.DishesM.friendly_create_time];
//    createTimeLabel.textColor = [UIColor lightGrayColor];
//    createTimeLabel.font = [UIFont systemFontOfSize:14];
//    [self.tableView addSubview:createTimeLabel];
//    
//    
//    
//    //创建标题 view
//    UIView *nameTitleView = [[UIView alloc] init];
//    nameTitleView.backgroundColor = [UIColor whiteColor];
//    nameTitleView.layer.cornerRadius = 2;
//    nameTitleView.layer.masksToBounds = YES;
//    
//    UILabel *nameLabel = [[UILabel alloc] init];
//    nameLabel.text = self.DishesM.name;
//    [nameLabel sizeToFit];
//    nameLabel.textColor = [UIColor redColor];
//    
//    UIImageView *arrowView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
//    //    UIImageView *arrowView = [[UIImageView alloc] init];
//    //    arrowView.image = [UIImage imageNamed:@"arrow"];
//    [nameTitleView addSubview:nameLabel];
//    [nameTitleView addSubview:arrowView];
//    [self.tableView addSubview:nameTitleView];
//    
//    //创建decLabel
//    UILabel *desclabel = [[UILabel alloc] init];
//    desclabel.text = self.DishesM.desc;
//    desclabel.numberOfLines = 0;
//    desclabel.font =[UIFont systemFontOfSize:15];
//    [self.tableView addSubview:desclabel];
//    
//    //设置约束
//    [authorPhoto mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(self.tableView.mas_left).with.offset(15 * KSizeScaleX);
//        make.top.equalTo(self.headScrollview.mas_bottom).with.offset(15 * KSizeScaleY);
//        make.width.equalTo(@(40));
//        make.height.equalTo(@(40));
//    }];
//    [authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.centerY.equalTo(authorPhoto);
//        make.left.equalTo(authorPhoto.mas_right).with.offset(10 * KSizeScaleX);
//    }];
//    
//    [createTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(authorPhoto);
//        make.right.equalTo(@(KScreenWidth-10 * KSizeScaleX);
//    }];
//    
//    [nameTitleView mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(authorLabel);
//        make.right.equalTo(createTimeLabel);
//        make.top.equalTo(authorLabel.mas_bottom).with.offset(15 * KSizeScaleY);
//        make.height.equalTo(@(40 * KSizeScaleY));
//    }];
//    
//    //nameTitleView
//    [arrowView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo(nameTitleView.mas_right).with.offset(-10*KSizeScaleX);
//        make.centerY.equalTo(nameTitleView);
//        make.width.equalTo(@(22));
//        make.height.equalTo(@(22));
//        
//    }];
//    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(nameTitleView.mas_left).with.offset(10 * KSizeScaleX);
//        make.right.equalTo(arrowView.mas_left).with.offset(10 * KSizeScaleX);
//        make.centerY.equalTo(nameTitleView);
//        
//    }];
//    
//    //desclabel
//    [desclabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        
//        make.left.equalTo(nameTitleView);
//        make.right.equalTo(nameTitleView);
//        make.top.equalTo(nameTitleView.mas_bottom).with.offset(10 * KSizeScaleX);
//        
//    }];
//    
//    
//    
//    
//}

@end
