//
//  CCPageController.m
//  XuanRui_APP
//
//  Created by apple on 2018/8/4.
//  Copyright © 2018年 XRZJ. All rights reserved.
//

#import "CCPageController.h"

#define dotW 9
#define dotH 2
#define activeDotW 9
#define margin 0

@implementation CCPageController

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //计算圆点间距
    CGFloat marginX = margin + 9;
    
    //计算整个pageControll的宽度
    CGFloat newW = marginX * self.subviews.count;

    //设置新frame
    self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, newW, self.frame.size.height);
    
    //设置居中
    CGPoint center = self.center;
    center.x = self.superview.center.x;
    self.center = center;
    
    //遍历subview,设置圆点frame
    for (int i=0; i<[self.subviews count]; i++) {
        UIImageView* dot = [self.subviews objectAtIndex:i];
        
        [dot setFrame:CGRectMake(i * marginX, dot.frame.origin.y, dotW, dotH)];
        dot.layer.cornerRadius=1;
        dot.layer.masksToBounds=YES;
        
    }
    
    
    
}


@end
