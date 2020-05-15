//
//  UILabel+Extension.h
//  XuanRui_APP
//
//  Created by bing tian on 2018/9/11.
//  Copyright © 2018年 XRZJ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Extension)
/**
 设置文本,并指定行间距
 
 @param text 文本内容
 @param lineSpacing 行间距
 */
-(void)setText:(NSString*)text lineSpacing:(CGFloat)lineSpacing;

@end
