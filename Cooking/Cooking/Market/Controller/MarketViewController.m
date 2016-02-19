//
//  MarketViewController.m
//  Cooking
//
//  Created by YongFangLili on 16/2/1.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import "MarketViewController.h"

@interface MarketViewController ()<UISearchBarDelegate>

@property (nonatomic, strong)UISearchBar * mySearchBar;
@property (nonatomic, strong)UIWebView *webView;


@end

@implementation MarketViewController

-(void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self loadData];



}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initNav];
    
    [self loadData];
    
    }
-(void)initNav {

    self.view.backgroundColor = KMainBackgroudColor;
    
    UIBarButtonItem *leftbarItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"leftPageButtonBackgroundNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(homePageClick)];
    [self.navigationItem setLeftBarButtonItem:leftbarItem];
    
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"shoppingCart"] style:UIBarButtonItemStylePlain target:self action: @selector(bulistClick)];
    [self.navigationItem setRightBarButtonItem:rightBarItem];
    
    _mySearchBar = [[UISearchBar alloc] initWithFrame:self.navigationItem.titleView.bounds];
    
    _mySearchBar.layer.cornerRadius = 5;
    _mySearchBar.layer.borderWidth = 1;
    _mySearchBar.layer.borderColor = [UIColor whiteColor].CGColor;
    _mySearchBar.layer.masksToBounds = YES;
    _mySearchBar.delegate = self;
    _mySearchBar.searchBarStyle = UISearchBarStyleMinimal ;
    _mySearchBar.backgroundColor = [UIColor colorWithRed:239.0 / 225.0 green:239.0 / 225.0 blue:239.0 / 225.0 alpha:1.0];
    _mySearchBar.placeholder = @"搜索商品";
    _mySearchBar.delegate = self;
    self.navigationItem.titleView = _mySearchBar;

}

-(void)loadData {


    NSURL *url = [NSURL URLWithString:MARKETURL];
    NSURLRequest *requst = [NSURLRequest requestWithURL:url];
    
    [self.webView loadRequest:requst];
    
}
-(UIWebView *)webView {
    
    if (!_webView) {
        
        [_webView.scrollView setBackgroundColor:[UIColor redColor]];
        
        _webView.backgroundColor = KMainBackgroudColor;
        _webView = [[UIWebView alloc]initWithFrame:self.view.bounds];
        
        [self.view addSubview:_webView];
    }

    return _webView;


}
//-(void)RequstData {
//    
//    [CKHTTPRequest getMarketReuest:self params:nil];
//    
//}
//#pragma mark -CKHTTPRequestDelegate
//// 成功请求到数据
//-(void)requestFinished:(id)responseDict cmd:(NSString *)cmd postdict:(NSDictionary *)postdict{
//    NSLog(@"%@",responseDict);
//    
//    
////    if ([responseDict[@"status"] isEqualToString:@"ok"]) {
////        //判断是否是头部请求
////        if ([cmd isEqualToString:HEADVIEWDATAURL]) {
////            self.headDatas = [MTLJSONAdapter modelOfClass:[MCookModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
////            [self initHeadView];
////            [self.navCollectionView reloadData];
////            [self.eventViewController.collectionView reloadData];
////        }
////        //判断是否是红包请求
////        if ([cmd isEqualToString:REDBAGURL]) {
////            self.redBagDatas = [MTLJSONAdapter modelOfClass:[McookRedBagModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
////            
////        }
////    }
////    
////    if ([cmd isEqualToString:ISSUEURL]) {
////        
////        self.issuesDatas = [MTLJSONAdapter modelOfClass:[McookCellModel class] fromJSONDictionary:responseDict[@"content"] error:nil];
////        [self.tableView reloadData];
////        
////    }
//    
//}
// 请求数据失败
//-(void)requestFailWithError:(NSError *)error cmd:(NSString *)cmd postdict:(NSDictionary *)postdic{
//    
//    
//    
//    
//}

//#pragma mark - Table view data source
//
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Incomplete implementation, return the number of sections
//    return 0;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete implementation, return the number of rows
//    return 0;
//}
//
///*
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
//    
//    // Configure the cell...
//    
//    return cell;
//}
//*/
//
///*
//// Override to support conditional editing of the table view.
//- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the specified item to be editable.
//    return YES;
//}
//*/
//
///*
//// Override to support editing the table view.
//- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
//        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//    }   
//}
//*/
//
///*
//// Override to support rearranging the table view.
//- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
//}
//*/
//
///*
//// Override to support conditional rearranging of the table view.
//- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
//    // Return NO if you do not want the item to be re-orderable.
//    return YES;
//}
//*/
//
///*
//#pragma mark - Navigation
//
//// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    // Get the new view controller using [segue destinationViewController].
//    // Pass the selected object to the new view controller.
//}
//*/

@end
