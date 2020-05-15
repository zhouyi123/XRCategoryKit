//
//  UIColor+add.h
//  ZIM2
//
//  Created by maqing on 17/6/23.
//  Copyright © 2017年 ls51. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (add)
+ (UIColor *) colorWithHexString: (NSString *)color;

/**
 传入两个颜色和系数
 
 @param beginColor 开始颜色
 @param coe 系数（0->1）
 @param endColor 终止颜色
 @return 过度颜色
 */
+ (UIColor *)getColorWithColor:(UIColor *)beginColor andCoe:(double)coe  andEndColor:(UIColor *)endColor;
@end
