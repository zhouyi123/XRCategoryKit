//
//  UIImage+Extension.h
//  PPStar
//
//  Created by CC on 2017/6/17.
//  Copyright © 2017年 wind. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Extension)

/**
 颜色转图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 染色+图形描边
 */
+ (UIImage *)imageMaskedWithColor:(UIColor *)color strokeColor:(UIColor *)strokeColor andImageName:(NSString *)name;

/**
 取缓存中的图片
 */
+ (UIImage *)imageWithNameWithOutCache:(NSString *)name;

/**
 模糊效果
 image是图片，blur是模糊度
 */
+(UIImage *)blurryImage:(UIImage *)image withBlurLevel:(CGFloat)blur;//通用模糊效果

/**
 图片拉伸
 */
+(UIImage *)extensionTheImage:(UIImage *)img andTop:(CGFloat)top andBottom:(CGFloat)bottom andLeft:(CGFloat)left andRight:(CGFloat)right;//（用于气泡拉伸）

/**
 图片压缩
 maxLength 图片指定大小
 */
+(UIImage *)oldImage:(UIImage *)oldImage toSize:(CGSize)size;// 图片等比例压缩
-(NSData *)compressWithMaxLength:(NSUInteger)maxLength;//通过压缩质量和尺寸，一定小于指定大小
-(NSData *)compressQualityWithMaxLength:(NSInteger)maxLength;//压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；缺点在于，不能保证图片压缩后小于指定大小。

+ (CGSize)getImageSizeWithURL:(id)URL;
//将一个CALayer对象绘制到一个UIImage对象上，并返回这个UIImage对象
+ (UIImage *)imageFromLayer:(CALayer *)layer;



@end
