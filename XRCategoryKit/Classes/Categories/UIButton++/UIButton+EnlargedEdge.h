//
//  UIButton+EnlargedEdge.h
//  XinJiYuan
//
//  Created by zhouyi on 20/11/10.
//  Copyright © 2018年 XRZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (EnlargedEdge)

- (void)setEnlargeEdge:(CGFloat) size;

- (void)setEnlargeEdgeWithTop:(CGFloat) top right:(CGFloat) right bottom:(CGFloat) bottom left:(CGFloat) left;
//获取渐变的layer
- (void )getLayerDropShadowWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint andLocations:(NSArray<NSNumber *> *)locations;
@end
