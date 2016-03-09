//
//  UIImage+Circle.m
//  Cooking
//
//  Created by 李永方 on 16/3/9.
//  Copyright © 2016年 DoOpen. All rights reserved.
//

#import "UIImage+Circle.h"


static void addRoundedRectToPath(CGContextRef context, CGRect rect, float ovalWidth,float ovalHeight)
{
    float fw, fh;
    if(ovalWidth == 0 || ovalHeight == 0)
    {
        CGContextAddRect(context, rect);
        return;
    }
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
    CGContextScaleCTM(context, ovalWidth, ovalHeight);
    fw = CGRectGetWidth(rect) / ovalWidth;
    fh = CGRectGetHeight(rect) / ovalHeight;
    
    CGContextMoveToPoint(context, fw, fh/2);  // Start at lower right corner
    CGContextAddArcToPoint(context, fw, fh, fw/2, fh, 1);  // Top right corner
    CGContextAddArcToPoint(context, 0, fh, 0, fh/2, 1); // Top left corner
    CGContextAddArcToPoint(context, 0, 0, fw/2, 0, 1); // Lower left corner
    CGContextAddArcToPoint(context, fw, 0, fw, fh/2, 1); // Back to lower right
    
    CGContextClosePath(context);
    CGContextRestoreGState(context);
}


@implementation UIImage (Circle)

+ (instancetype)imageWithIconName:(NSString *)icon borderImage:(NSString *)borderImage border:(int)border{

        //头像图片
        
        UIImage * image = [UIImage imageNamed:icon];
        
        //边框图片
        
        UIImage * borderImg = [UIImage imageNamed:borderImage];

        CGSize size = CGSizeMake(image.size.width + border, image.size.height + border);

        //创建图片上下文

        UIGraphicsBeginImageContextWithOptions(size, NO, 0);

        //绘制边框的圆

        CGContextRef context = UIGraphicsGetCurrentContext();

        CGContextAddEllipseInRect(context, CGRectMake(0, 0, size.width, size.height));

        //剪切可视范围

        CGContextClip(context);

        //绘制边框图片

        [borderImg drawInRect:CGRectMake(0, 0, size.width, size.height)];

        //设置头像frame

        CGFloat iconX = border / 2;
        CGFloat iconY = border / 2;

        CGFloat iconW = image.size.width;

        CGFloat iconH = image.size.height;

        //绘制圆形头像范围

        CGContextAddEllipseInRect(context, CGRectMake(iconX, iconY, iconW, iconH));
        //剪切可视范围
        CGContextClip(context);

        //绘制头像

        [image drawInRect:CGRectMake(iconX, iconY, iconW, iconH)];

        //取出整个图片上下文的图片

        UIImage *iconImage = UIGraphicsGetImageFromCurrentImageContext();

        return iconImage;
}

-(UIImage*) roundCorners:(CGFloat)radius
{
    int w = self.size.width;
    int h = self.size.height;
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, w, h, 8, 4*w, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedFirst);
    
    CGContextBeginPath(context);
    CGRect rect = CGRectMake(0, 0, self.size.width, self.size.height);
    addRoundedRectToPath(context, rect, radius, radius);
    CGContextClosePath(context);
    CGContextClip(context);
    
    CGContextDrawImage(context, CGRectMake(0, 0, w, h), self.CGImage);
    
    CGImageRef imageMasked = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    UIImage* image = [[UIImage alloc] initWithCGImage:imageMasked];
    CFRelease(imageMasked);
    
    return image;
}


@end
