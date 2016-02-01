//
//  BaseViewController.m
//  Cooking
//
//  Created by 李永方 on 16/2/1.
//  Copyright © 2016年 李永方. All rights reserved.
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
    
}



#pragma mark -初始化子视图
-(void)setUpChildControllers{
    
    /**下厨房*/
    McookingController *Cook = [[McookingController alloc]init];
    [self addChildControllers:Cook Withtitle:@"下厨房" Withimage:@"tabADeselected~iphone" WithSelected:@"tabASelected~iphone"];
    Cook.view.backgroundColor = [UIColor redColor];
    
    /**市集*/
    MarketViewController *Market = [[MarketViewController alloc]init];
    [self addChildControllers:Market Withtitle:@"市集" Withimage:@"tabBDeselected~iphone" WithSelected:@"tabBSelected~iphone"];
    Market.view.backgroundColor = [UIColor blueColor];
    
    /**社区*/
    MComunityController *Comunity = [[MComunityController alloc] init];
    [self addChildControllers:Comunity Withtitle:@"社区" Withimage:@"tabCDeselected~iphone" WithSelected:@"tabCSelected~iphone"];
    Comunity.view.backgroundColor = [UIColor magentaColor];
    
    /**我*/
    MineViewController *Mine = [[MineViewController alloc] init];
    [self addChildControllers:Mine Withtitle:@"我" Withimage:@"tabDDeselected~iphone" WithSelected:@"tabDSelected~iphone"];
    Mine.view.backgroundColor = [UIColor purpleColor];
    
}

#pragma mark -加载子视图
-(void)addChildControllers:(UIViewController *)Vc Withtitle:(NSString *)title Withimage:(NSString *)image WithSelected:(NSString *)selectImage{
    
    Vc.title = title;
    self.view.backgroundColor = [UIColor blueColor];
    
    //去掉渲染
    UIImage *normalImge = [UIImage imageNamed:image];
    normalImge = [normalImge imageWithRenderingMode: UIImageRenderingModeAlwaysOriginal];
    UIImage *selectedImge = [UIImage imageNamed:selectImage];
    selectedImge = [selectedImge imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    //设置对应控制按钮去的图片
    Vc.tabBarItem.image = normalImge;
    Vc.tabBarItem.selectedImage = selectedImge;

    //创建导航控制器
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:Vc];
    [self addChildViewController:nav];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}


@end
