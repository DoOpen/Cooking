//
//  RecieveRedBagController.m
//  Cooking
//
//  Created by 李永方 on 16/2/16.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "RecieveRedBagController.h"

@interface RecieveRedBagController ()

@property(nonatomic,strong)UIWebView *redBagWebView;

@end

@implementation RecieveRedBagController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    
    NSURLRequest *requst = [NSURLRequest requestWithURL:[NSURL URLWithString:self.redBagM.url]];
    
    [self.redBagWebView loadRequest:requst];
    // Do any additional setup after loading the view.
}
-(void)initNav{
    
    
    self.tabBarController.tabBar.hidden = YES;
    self.view.backgroundColor = KMainBackgroudColor;
    self.title = @"新人20元红包等你领";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    UIBarButtonItem *leftBar = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"backStretchBackgroundNormal"] style:UIBarButtonItemStylePlain target:self action:@selector(BackToMcook)];
    self.navigationItem.leftBarButtonItem = leftBar;

}


#pragma mark -返回上一层
-(void)BackToMcook {
    
    [self.navigationController popViewControllerAnimated:YES];


}
-(UIWebView *)redBagWebView {

    if (!_redBagWebView) {
        _redBagWebView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, KScreenHeight - KNavBarHeight)];
        _redBagWebView.backgroundColor = KMainBackgroudColor;
    }
    [self.view addSubview:_redBagWebView];
    return _redBagWebView;

}

-(void)dealloc{
    
    NSLog(@"我走了");


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
