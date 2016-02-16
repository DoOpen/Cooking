//
//  RecieveRedBagController.m
//  Cooking
//
//  Created by 李永方 on 16/2/16.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "RecieveRedBagController.h"

@interface RecieveRedBagController ()

@end

@implementation RecieveRedBagController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNav];
    // Do any additional setup after loading the view.
}
-(void)initNav{
    
    self.view.backgroundColor = KMainBackgroudColor;
    self.title = @"新人20元红包等你领";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    



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
