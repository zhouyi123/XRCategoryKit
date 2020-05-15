//
//  UIView+UIViewAddition.h
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@interface UIView (UIViewAddition)

@property(nonatomic) CGFloat left;
@property(nonatomic) CGFloat right;
@property(nonatomic) CGFloat top;
@property(nonatomic) CGFloat bottom;
@property(nonatomic) CGFloat width;
@property(nonatomic) CGFloat height;
@property (nonatomic, assign) CGSize size;
@property(nonatomic) CGFloat x;
@property(nonatomic) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGPoint origin;
@property (nonatomic, strong) NSDictionary *theViewDic;

- (void)showFrame;

#pragma mark  ----------- 增加View点击事件 ---------------
/**
 增加点击事件
 */
- (void)tb_addTarget:(id)target action:(SEL)action;

#pragma mark  ----------- 增加VIew渐变 ---------------

/**
 渐变
 colors       渐变颜色
 startPoint   x,y起始点
 endPoint     x,y结束点
 locations    颜色渐变发生位置 @[@(0.5f), @(1.0f)];
 */
//- (CAGradientLayer *)shadowAsInverseDownWithColor:(UIColor *)color andWidth:(float)ww;
//- (CAGradientLayer *)shadowAsInverseUpWithColor:(UIColor *)color andWidth:(float)ww;
-(void)addDropShadowWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint andLocations:(NSArray<NSNumber *> *)locations;

#pragma mark  ----------- 获取Window当前显示的ViewController ---------------

/**
 获取Window当前显示的ViewController
 */
- (UIViewController*)currentViewController;
- (UIViewController *)getSuperViewController;

#pragma mark  ----------- 固定圆角与阴影 ---------------
/**
 指定大小的圆角处理
 */
- (void)cornerRadius:(CGFloat)radius;
/**
 指定大小圆角，且带border
 */
- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth;

/**
 指定大小圆角，且带border，是否带阴影shadow
 */
- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth showShadow:(BOOL)shadow;

- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth showShadowColor:(UIColor *)color;

#pragma mark  ----------- 添加阴影 ---------------

// 添加阴影
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity;



#pragma mark  ----------- border ---------------
/**
 添加border
 */
- (void)borderWithColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth;

#pragma mark  ----------- View的四个角进行选择性的圆角处理 ---------------
/**
 对UIView的四个角进行选择性的圆角处理
 */
- (void)makeRoundedCorner:(UIRectCorner)byRoundingCorners cornerRadii:(CGSize)cornerRadii;



#pragma mark  ----------- 计算 UIlabel Size---------------
/**
 UIlabel Size
 */
+(CGSize)getSizeWithText:(NSString*)text andFont:(UIFont *)font andSize:(CGSize)size;

#pragma mark  ----------- 改变字体形态---------------
/**
 改变字体形态
 */
+ (NSMutableAttributedString *)changeContent:(NSArray *)changeArr allContent:(NSString *)contentStr andColor:(NSArray*)colorArr andFont:(NSArray *)fontArr;

#pragma mark  ----------- UIView ---------------
+ (id)viewWithBackgroudColor:(UIColor *)backgroudColor;

+(UIView*)ViewWithframe:(CGRect)rect color:(UIColor*)color AddToSuperview:(UIView *)superview;

+(UIView*)LineviewWithframe:(CGRect)rect color:(UIColor*)color AddToSuperview:(UIView*)superview;

#pragma mark  ----------- UILabel ---------------
/** Label 字色 字号 文字 行数 等*/

+(UILabel *)LabelWithFrame:(CGRect)frame TextColor:(UIColor *)textColor BackgroundColor:(UIColor *)backgroundColor FontSize:(CGFloat)size NumberOfLines:(NSInteger)numberOfLines TextAlignment:(NSTextAlignment)textAlignment Text:(NSString *)text;

+(UILabel*)LabelWithText:(NSString*)string font:(int)font textColor:(UIColor *)color TextAlignment:(int)textAlignment AddToSuperView:(UIView *)superview;

+(UILabel*)LabelWithFrame:(CGRect)frame text:(NSString*)string font:(int)font textColor:(UIColor*)color TextAlignment:(int)textAlignment AddToSuperView:(UIView *)superview;

//new
+(UILabel*)createLabelWithFrame:(CGRect)frame text:(NSString *)string font:(UIFont *)font textColor:(UIColor *)color TextAlignment:(int)textAlignment AddToSuperView:(UIView *)superview;

#pragma mark  ----------- UIButton ---------------
/** UIButton 字色 字号 文字 图片 等*/
+(UIButton *)buttonWithTitle:(NSString *)title frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor font:(int)font;

+(UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(int)font image:(UIImage *)image target:(id)target action:(SEL)action  AddToSuperView:(UIView *)superview;
+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titlecolor:(UIColor*)title_color target:(id)target action:(SEL)action AddToSuperView:(UIView *)superview;

+(UIButton*)buttonWithFrame:(CGRect)fram backgroundimage:(UIImage*)image target:(id)target action:(SEL)action AddToSuperView:(UIView *)superview;

+(UIButton*)buttonWithFrame:(CGRect)fram image:(UIImage *)image target:(id)target action:(SEL)action AddToSuperView:(UIView *)superview;
//new
+(UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font image:(UIImage *)image target:(id)target action:(SEL)action AddToSuperView:(UIView *)superview;


#pragma mark  ----------- UITextField ---------------
+(UITextField *)fieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textColor:(UIColor *)color andPlaceholderTextColor:(UIColor *)placeholdertextColor andPlaceholderFont:(UIFont *)placeholderFont AddToSuperView:(UIView *)superview;

#pragma mark  ----------- UIImageView ---------------
+(UIImageView *)ImageViewWithFrame:(CGRect)frame Image:(NSString *)image AddToSuperView:(UIView *)superview;
//new
+(UIImageView *)createImageViewWithFrame:(CGRect)frame Image:(UIImage *)image AddToSuperView:(UIView *)superview;

#pragma mark  ----------- AlertTitle ---------------
+(void)showAlertTitle:(NSString *)titleString detailsText:(NSString *)detailsString time:(float)time aboutType:(MBProgressHUDMode)mode;

+(void)hideAlert;

#pragma mark  ----------- className ---------------

/**
 className
 */
+ (NSString *)className;

/**
 增加缺省页
 */
+(id)showLackPageViewframe:(CGRect)frame name:(NSString *)imgName title:(NSString *)title;

+(id)showLackPageViewframe:(CGRect)frame name:(NSString *)imgName title:(NSString *)title changContent:(NSString *)content;
//+(id)showLackPageViewHasframe:(CGRect)frame name:(NSString *)imgName title:(NSString *)title target:(id)target action:(SEL)action;
+(id)showLackPageViewframe:(CGRect)frame name:(NSString *)imgName title:(NSString *)title btnTitle:(NSString *)btntitle target:(id)target action:(SEL)action;

@end

