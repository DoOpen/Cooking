//
//  NavsViewController.m
//  Cooking
//
//  Created by 李永方 on 16/3/1.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "NavsViewController.h"
#import "MCookModel.h"

@interface NavsViewController ()

@property (nonatomic,strong)UIWebView *navWebView;

@end

@implementation NavsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
//    [self ]
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:self.navM.url]];
    
    [self.navWebView loadRequest:requst];

}
-(void)initNav{
    
    
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = KMainBackgroudColor;

    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(BackToMcook)];
    self.navigationItem.leftBarButtonItem = leftBar;
    
}

#pragma mark -返回上一层
-(void)BackToMcook {
    
    [self.navigationController popViewControllerAnimated:YES];
    
    
}

-(UIWebView *)navWebView{
    
    if (!_navWebView) {
        _navWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - KNavBarHeight)];
        _navWebView.backgroundColor = KMainBackgroudColor;
    }
    [self.view addSubview:_navWebView];
    return _navWebView;
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
