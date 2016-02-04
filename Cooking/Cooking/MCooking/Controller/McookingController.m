//
//  McookingController.m
//  Cooking
//
//  Created by YongFangLili on 16/2/1.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import "McookingController.h"
#import <Masonry.h>

@interface McookingController ()<UISearchBarDelegate>

@property(nonatomic, strong)UISearchBar *mySearchBar;

@property (nonatomic,strong)UIView *NavView;

@end

@implementation McookingController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化 nav
    [self initNav];
    


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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete implementation, return the number of rows
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
