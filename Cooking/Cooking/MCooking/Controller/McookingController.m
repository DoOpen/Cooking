//
//  McookingController.m
//  Cooking
//
//  Created by YongFangLili on 16/2/1.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import "McookingController.h"
#import <Masonry.h>
#import <Mantle.h>
#import "MCookModel.h"
#import "MCookHeadView.h"
#import "NavCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "RecieveRedBagController.h"
#import "EventsCollectionViewController.h"

@interface McookingController ()<UISearchBarDelegate,CKHTTPRequestDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) MCookHeadView *headView;
@property (nonatomic,strong)MCookModel *headDatas;
@property (nonatomic,strong)McookCellModel *issuesDatas;

@property (nonatomic,strong)McookRedBagModel *redBagDatas;

@property(nonatomic, strong)UISearchBar *mySearchBar;

@property (nonatomic,strong)UIView *popView;

@property (nonatomic, strong)UICollectionView *navCollectionView;

@property (nonatomic, strong)EventsCollectionViewController *eventViewController;
// 新手红包
@property (nonatomic, strong) UIImageView *redbagImgeView;

@end

static NSString *navcell = @"navcell";
static NSString *eventsCell = @"eventsCell";


@implementation McookingController

-(instancetype)init{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        return self;
    };
    return nil;
}
-(void)viewWillAppear:(BOOL)animated {
    
    self.tabBarController.tabBar.hidden = NO;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化 nav
    [self initNav];
    //数据请求
    [self requsData];
    
    [self initHeadView];

    
    }
#pragma mark -数据请求
-(void)requsData{
    
   //头部数据请求
    //  @"http://api.xiachufang.com/v2/init_page_v5.json?timezone=Asia%2FShanghai&api_sign=68aeeb939943f67b51a886af151b2b2b&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&version=5.2.2";
    [CKHTTPRequest GET:self URL:HEADVIEWDATAURL parameter:nil];
    
    // 红包请求http://api.xiachufang.com/v2/ad/show.json?slot_name=homepage_banner_ad1&height=172.5&origin=iphone&api_sign=f2dfd7fcfcee24a68b589a1f73064b21&width=690&supported_types=1&version=5.2.2&api_key=0f9f79be1dac5f003e7de6f876b17c00
    
    [CKHTTPRequest getCookingHeadData:self params:nil];

}
#pragma mark -CKHTTPRequestDelegate
// 成功请求到数据
-(void)requestFinished:(id)responseDict cmd:(NSString *)cmd postdict:(NSDictionary *)postdict{
    NSLog(@"%@",responseDict);
    if ([responseDict[@"status"] isEqualToString:@"ok"]) {
        //判断是否是头部请求
        if ([cmd isEqualToString:HEADVIEWDATAURL]) {
            self.headDatas = [MTLJSONAdapter modelOfClass:[MCookModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
            [self initHeadView];
            [self.navCollectionView reloadData];
            [self.eventViewController.collectionView reloadData];
        }
        //判断是否是红包请求
        if ([cmd isEqualToString:REDBAGURL]) {
            self.redBagDatas = [MTLJSONAdapter modelOfClass:[McookRedBagModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
            
        }
    }
    
    if ([cmd isEqualToString:ISSUEURL]) {
        
        self.issuesDatas = [MTLJSONAdapter modelOfClass:[McookCellModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
        
    }
    
}
// 请求数据失败
-(void)requestFailWithError:(NSError *)error cmd:(NSString *)cmd postdict:(NSDictionary *)postdic{




}

#pragma mark -初始化 nav
-(void)initNav{

    UIBarButtonItem *leftbarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"homepageCreateRecipeButton"] style:UIBarButtonItemStylePlain target:self action:@selector(homePageClick)];
    [self.navigationItem setLeftBarButtonItem:leftbarItem];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"buylistButtonImage"] style:UIBarButtonItemStylePlain target:self action: @selector(bulistClick)];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
    
    //搜索框
    UIView *titleview = [[UIView alloc]initWithFrame:CGRectMake(0,0, 267, 30)];
    _mySearchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0,0, 267, 30)];
    _mySearchBar.layer.cornerRadius = 5;
    _mySearchBar.layer.borderWidth = 1;
    _mySearchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    _mySearchBar.layer.masksToBounds = YES;
    _mySearchBar.delegate = self;
    _mySearchBar.searchBarStyle = UISearchBarStyleMinimal ;
    _mySearchBar.backgroundColor = [UIColor colorWithRed:239.0 / 225.0 green:239.0 / 225.0 blue:239.0 / 225.0 alpha:1.0];
    _mySearchBar.placeholder = @"菜谱、食谱";
    _mySearchBar.delegate = self;
    [titleview addSubview:_mySearchBar];
    self.navigationItem.titleView = titleview;
}

#pragma mark -初始化 headview
-(void)initHeadView{
    
    self.headView = [[MCookHeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 355)];
    _headView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = self.headView;
    //
    [self.headView addSubview:[self setUpPopImage]];
    
    [self.headView addSubview:self.navCollectionView];
    
    [self.headView addSubview:self.redbagImgeView];
    
    [self.headView addSubview:self.eventViewController.collectionView];


}

#pragma mark -流行菜谱
-(UIView *)setUpPopImage{
    
    UIView *popView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 130)];
    self.popView = popView;
    UIImageView *popImmageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0,185, 130)];
    popImmageView.image = [UIImage imageNamed:@"feedsNotLogin"];
    NSURL *popurl = [NSURL URLWithString:self.headDatas.pop_recipe_picurl];
    [popImmageView sd_setImageWithURL:popurl placeholderImage:[UIImage imageNamed:@"feedsNotLogin"]];
    
    UIImageView *worksImageView = [[UIImageView alloc]initWithFrame:CGRectMake(popImmageView.frame.size.width + 5,0 , 185, 130)];
    worksImageView.image = [UIImage imageNamed:@"feedsNotLogin"];
    [popView addSubview:popImmageView];
    [popView addSubview: worksImageView];
    
    return popView;

}
#pragma mark -redImageview
-(UIImageView *)redbagImgeView {
    
    if (!_redbagImgeView) {
        
        _redbagImgeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navCollectionView.frame), KScreenWidth, 45 * KSizeScaleY)];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ClickRedBagImage:)];
        _redbagImgeView.userInteractionEnabled = YES;
        
        [_redbagImgeView addGestureRecognizer:tapGesture];
    }
    return _redbagImgeView;

}
#pragma mark - 点击进入新用户领取红包
-(void)ClickRedBagImage:(UITapGestureRecognizer *)sender {

    NSLog(@"%s",__func__);
    NSLog(@"%@",sender);
    RecieveRedBagController *redBagVC = [[RecieveRedBagController alloc]init];
    redBagVC.redBagM = self.redBagDatas;
    
    [self.navigationController pushViewController:redBagVC animated:YES];
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{


    NSLog(@"%@",sender);

}
#pragma mark -set 方法红包图片
-(void)setRedBagDatas:(McookRedBagModel *)redBagDatas {

    _redBagDatas = redBagDatas;
    
    [self.redbagImgeView sd_setImageWithURL:[NSURL URLWithString:redBagDatas.ad_info[@"pic_url"]]];
    
    [self.redbagImgeView setContentMode: UIViewContentModeScaleAspectFit];
    

}

#pragma mark -navs
-(UICollectionView *)navCollectionView {
    if (!_navCollectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        
        _navCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, (CGRectGetMaxY(self.popView.frame)), [UIScreen mainScreen].bounds.size.width, 93) collectionViewLayout:flowlayout];
//        flowlayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        flowlayout.minimumInteritemSpacing = 0;
//        _navCollectionView.showsHorizontalScrollIndicator = NO;
        _navCollectionView.delegate = self;
        _navCollectionView.dataSource = self;
       
        
        _navCollectionView.backgroundColor = [UIColor whiteColor];
        [_navCollectionView registerClass:[NavCollectionViewCell class] forCellWithReuseIdentifier:navcell];
        
    }
    return _navCollectionView;
}

#pragma mark -events 轮播器
-(EventsCollectionViewController *)eventViewController {

    if (!_eventViewController) {
        
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
        flowLayout.itemSize = CGSizeMake(KScreenWidth, CGRectGetMaxY(self.headView.frame) - CGRectGetMaxY(self.redbagImgeView.frame));
        flowLayout.scrollDirection =  UICollectionViewScrollDirectionHorizontal;
        flowLayout.minimumInteritemSpacing = 0;
        flowLayout.minimumLineSpacing = 0;
        
        _eventViewController = [[EventsCollectionViewController alloc] initWithCollectionViewLayout:flowLayout];
        [_eventViewController.collectionView registerNib:[UINib nibWithNibName:@"EventsCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:eventsCell];
        _eventViewController.collectionView.pagingEnabled = YES;
                //去掉滚动条
        _eventViewController.collectionView.showsHorizontalScrollIndicator = NO;
        
        
       
       
    }
    CGFloat eventViewY = CGRectGetMaxY(self.redbagImgeView.frame);
    
    _eventViewController.collectionView.frame = CGRectMake(0,eventViewY, KScreenWidth, CGRectGetMaxY(self.headView.frame) -eventViewY);
    
    _eventViewController.MCookM = self.headDatas;

    return _eventViewController;
}

#pragma mark - colletioview delegate

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
   
    return 1;
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    
    NSArray *navArray = self.headDatas.navs;
    
    return navArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{

    NavCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:navcell forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    cell.McookM = self.headDatas.navs[indexPath.item];
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个Item 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat itemW = [UIScreen mainScreen].bounds.size.width /(CGFloat)self.headDatas.navs.count;
    return CGSizeMake(itemW, 93);
}

//取消searchbar背景色
- (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size
{
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}


#pragma mark -homepage
-(void)homePageClick{
    
    
    NSLog(@"%s",__FUNCTION__);
    
}

#pragma mark -bulistClick
-(void)bulistClick{

    NSLog(@"%s",__FUNCTION__);
    
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Incomplete implementation, return the number of sections
    return 8;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 8;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell ==nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle: UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    
    cell.backgroundColor = [UIColor blueColor];
    
    return cell;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{

//    if (section == 0) {
//        return 390;
//    }
    
    return 55;
    
}


@end
