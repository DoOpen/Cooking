//
//  UIButton+Circle.m
//  Cooking
//
//  Created by 李永方 on 16/3/8.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "UIButton+Circle.h"

@implementation UIButton (Circle)

+(instancetype)CircleButtonWithFrame:(CGRect)frame withTitle:(NSString *)title WithImage:(UIImage *)image{

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    button.layer.borderWidth = 1;
    button.layer.borderColor = [UIColor lightGrayColor].CGColor;
    button.layer.cornerRadius = frame.size.width / 2 + 1;
    button.layer.masksToBounds = YES;
    [button setImage:image forState:UIControlStateNormal];
    
    return button;

}
@end
