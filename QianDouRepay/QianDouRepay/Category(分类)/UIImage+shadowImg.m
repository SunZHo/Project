//
//  UIImage+shadowImg.m
//  daichuqu
//
//  Created by 杨 on 16/9/1.
//  Copyright © 2016年 北京诚行天下投资咨询有限公司. All rights reserved.
//

#import "UIImage+shadowImg.h"

@implementation UIImage (shadowImg)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size

{
    
    @autoreleasepool {
        
        CGRect rect = CGRectMake(0, 0, size.width, size.height);
        
        UIGraphicsBeginImageContext(rect.size);
        
        CGContextRef context = UIGraphicsGetCurrentContext();
        
        CGContextSetFillColorWithColor(context,
                                       
                                       color.CGColor);
        
        CGContextFillRect(context, rect);
        
        UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
        
        UIGraphicsEndImageContext();
        
        
        
        return img;
        
    }
    
}
@end
