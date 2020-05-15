//
//  CCCountButton.m
//  xuanrui
//
//  Created by apple on 2018/8/3.
//  Copyright © 2018年 apple. All rights reserved.
//

#import "CCCountButton.h"

#define unableColor  [UIColor colorWithRed:157.0f/255.0f green:159.0f/255.0f blue:161.0f/255.0f alpha:1.0f]
#define activeColor  [UIColor colorWithRed:0.0f/255.0f green:174.0f/255.0f blue:102.0f/255.0f alpha:1.0f]

@interface CCCountButton()
//倒计时数
//@property(assign,nonatomic) NSInteger count;

@end

@implementation CCCountButton

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self=[super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

-(void)setup
{
    [self setTitle:@"获取验证码" forState:UIControlStateNormal];
    self.titleLabel.font=[UIFont systemFontOfSize:16];
    [self setTitleColor:unableColor forState:UIControlStateNormal];
    self.titleLabel.textAlignment = NSTextAlignmentRight;
    self.contentVerticalAlignment=UIControlContentVerticalAlignmentFill;
    self.enabled=NO;
}

-(void)timeCountDownBeginFrom:(NSInteger)timeCount
{
    self.enabled=NO;
    __block NSInteger count=timeCount;
    //执行队列
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //计时器 -》 dispatch_source_set_timer自动生成
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    dispatch_source_set_timer(timer, DISPATCH_TIME_NOW, 1.0 * NSEC_PER_SEC, 0 * NSEC_PER_SEC);
    dispatch_source_set_event_handler(timer, ^{
        if (count <= 0) {
            dispatch_source_cancel(timer);
            //主线程设置按钮样式
            dispatch_async(dispatch_get_main_queue(), ^{
                // 倒计时结束
                [self setTitle:@"获取验证码" forState:UIControlStateNormal];
                [self setTitleColor:activeColor forState:UIControlStateNormal];
                [self setEnabled:YES];
                [self setUserInteractionEnabled:YES];
            });
        } else {
            //开始计时
            //剩余秒数 seconds
            NSInteger seconds = count;
            NSString *strTime = [NSString stringWithFormat:@"%lds", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self setTitle:strTime forState:UIControlStateNormal];
            });
            
        }
        count--;
    });
    dispatch_resume(timer);
}
-(void)btnBecomeActive
{
    self.enabled=YES;
    
    [self setTitleColor:activeColor forState:UIControlStateNormal];
}
-(void)btnBecomeUnable
{
    [self setTitleColor:unableColor forState:UIControlStateNormal];
    self.enabled=NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
