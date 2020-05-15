//
//  CCCountButton.h
//  xuanrui
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CCCountButton : UIButton

//计时开始
- (void)timeCountDownBeginFrom:(NSInteger)timeCount;
//变成可以点击状态
- (void)btnBecomeActive;
//变成灰色状态
- (void)btnBecomeUnable;



//激活时文字颜色
//@property(assign,nonatomic) UIColor* activeColor;

@end
