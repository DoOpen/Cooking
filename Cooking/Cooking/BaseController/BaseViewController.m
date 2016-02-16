//
//  BaseViewController.m
//  Cooking
//
//  Created by YongFangLili on 16/2/1.
//  Copyright © 2016 DoOpen. All rights reserved.
//

#import "BaseViewController.h"
#import "McookingController.h"
#import "MComunityController.h"
#import "MarketViewController.h"
#import "MineViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUpChildControllers];
    [self.tabBar setTranslucent:NO];
    self.tabBar.barTintColor = [UIColor whiteColor];
    
//    self.tabBar.translucent = NO;
}



#pragma mark -初始化子视图
-(void)setUpChildControllers{
    
  
    /** 下厨房 */
    McookingController *Cook = [[McookingController alloc]init];
    [self addChildControllers:Cook Withtitle:@"下厨房" Withimage:@"tabADeselected" WithSelected:@"tabASelected"];
        
   
    /** 市集 */
    MarketViewController *Market = [[MarketViewController alloc]init];
    [self addChildControllers:Market Withtitle:@"市集" Withimage:@"tabBDeselected" WithSelected:@"tabBSelected"];
//    Market.view.backgroundColor = [UIColor blueColor];
    Market.view.backgroundColor = KMainBackgroudColor;
    
    /** 社区 */
    MComunityController *Comunity = [[MComunityController alloc] init];
    [self addChildControllers:Comunity Withtitle:@"社区" Withimage:@"tabCDeselected" WithSelected:@"tabCSelected"];
//    Comunity.view.backgroundColor = [UIColor magentaColor];
    Comunity.view.backgroundColor = KMainBackgroudColor;
    
    /** 我 */
    MineViewController *Mine = [[MineViewController alloc] init];
    [self addChildControllers:Mine Withtitle:@"我" Withimage:@"tabDDeselected" WithSelected:@"tabDSelected"];
//    Mine.view.backgroundColor = [UIColor purpleColor];
    Mine.view.backgroundColor = KMainBackgroudColor;
    
}

#pragma mark -加载子视图
-(void)addChildControllers:(UIViewController *)Vc Withtitle:(NSString *)title Withimage:(NSString *)image WithSelected:(NSString *)selectImage{
    
    Vc.title = title;
    self.view.backgroundColor = KMainBackgroudColor;
    
    // 去掉渲染
    UIImage *normalImge = KImageOriginalWithName(image);
    UIImage *selectedImge = KImageOriginalWithName(selectImage);
    
    // 设置对应控制按钮去的图片
    Vc.tabBarItem.image = normalImge;
    Vc.tabBarItem.selectedImage = selectedImge;
    
    // 设置tabBarItem的标题颜色
    [Vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor grayColor]} forState:UIControlStateNormal];
    [Vc.tabBarItem setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor orangeColor]} forState:UIControlStateSelected];
    
    // 创建导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Vc];
    // 导航栏字体设置
    [nav.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15],NSForegroundColorAttributeName:[UIColor blackColor]}];
    
    // 设置导航栏的颜色背景
    nav.navigationBar.barTintColor = [UIColor whiteColor];
    // 设置导航为不透明
    nav.navigationBar.translucent = NO;
    [self addChildViewController:nav];
    
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
