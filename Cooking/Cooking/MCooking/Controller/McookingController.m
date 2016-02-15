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
#define HEADVIEWDATAURL @"/v2/init_page_v5.json?timezone=Asia%2FShanghai&api_sign=68aeeb939943f67b51a886af151b2b2b&api_key=0f9f79be1dac5f003e7de6f876b17c00&origin=iphone&version=5.2.2"
#define REDBAGURL @"http://api.xiachufang.com/v2/ad/show.json?slot_name=homepage_banner_ad1&height=172.5&origin=iphone&api_sign=f2dfd7fcfcee24a68b589a1f73064b21&width=690&supported_types=1&version=5.2.2&api_key=0f9f79be1dac5f003e7de6f876b17c00"



@interface McookingController ()<UISearchBarDelegate,CKHTTPRequestDelegate,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong)MCookModel *headDatas;
@property (nonatomic,strong)McookRedBagModel *redBagDatas;

@property(nonatomic, strong)UISearchBar *mySearchBar;

@property (nonatomic,strong)UIView *popView;

@property (nonatomic, strong)UICollectionView *navCollectionView;
// 新手红包
@property (nonatomic, strong) UIImageView *redbagImgeView;

@end

static NSString *navcell = @"navcell";

@implementation McookingController

-(instancetype)init{
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
        return self;
    };
    return nil;
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
    [CKHTTPRequest GET:self URL:REDBAGURL parameter:nil];

}
#pragma mark -CKHTTPRequestDelegate
// 成功请求到数据
-(void)requestFinished:(id)responseDict cmd:(NSString *)cmd postdict:(NSDictionary *)postdict{
    NSLog(@"%@",responseDict);
    if ([responseDict[@"status"] isEqualToString:@"ok"]) {
        //判断是否是头部请求
        if ([cmd isEqualToString:HEADVIEWDATAURL]) {
            self.headDatas = [MTLJSONAdapter modelOfClass:[MCookModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
            MCookModel *model = self.headDatas;
            [self initHeadView];
            [self.eventCollectionView reloadData];
        }
        //判断是否是红包请求
        if ([cmd isEqualToString:REDBAGURL]) {
            self.redBagDatas = [MTLJSONAdapter modelOfClass:[McookRedBagModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
            
            
        }
        

    }
    
   //    NSLog(@"%@",mcookM);
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
    
    MCookHeadView *headView = [[MCookHeadView alloc]initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 335)];
    headView.backgroundColor = [UIColor redColor];
    self.tableView.tableHeaderView = headView;
    //
    [headView addSubview:[self setUpPopImage]];
    
    [headView addSubview:self.eventCollectionView];


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

-(UICollectionView *)eventCollectionView{
    
    if (!_navCollectionView) {
        
        UICollectionViewFlowLayout *flowlayout = [[UICollectionViewFlowLayout alloc]init];
        
        _navCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, (CGRectGetMaxY(self.popView.frame)), [UIScreen mainScreen].bounds.size.width, 93) collectionViewLayout:flowlayout];
        _navCollectionView.delegate = self;
        _navCollectionView.dataSource = self;
        flowlayout.minimumInteritemSpacing = 0;
//        flowlayout.itemSize = CGSizeMake(90, 90);
        _navCollectionView.backgroundColor = [UIColor whiteColor];
        [_navCollectionView registerClass:[NavCollectionViewCell class] forCellWithReuseIdentifier:navcell];
        
    }
    
    
    return _navCollectionView;
    
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


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
