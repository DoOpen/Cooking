//
//  UIImage+Circle.h
//  Cooking
//
//  Created by 李永方 on 16/3/9.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Circle)

+ (instancetype)imageWithIconName:(NSString *)icon borderImage:(NSString *)borderImage border:(int)border;

-(UIImage*) roundCorners:(CGFloat)radius;

@end
