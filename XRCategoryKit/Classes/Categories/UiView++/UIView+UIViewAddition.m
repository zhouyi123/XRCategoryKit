//
//  UIView+UIViewAddition.m
//  XiYouPartner
//
//  Created by 265G on 15/8/10.
//  Copyright (c) 2015年 YXCompanion. All rights reserved.
//

#import "UIView+UIViewAddition.h"
//#import "TBTabBarController.h"
//#import "TBNavigationController.h"

static NSString *theViewDicKey = @"theViewDicKey";   //定义一个key值

@implementation UIView (UIViewAddition)

- (CGFloat)left
{
    return self.frame.origin.x;
}

- (void)setLeft:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right
{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)top
{
    return self.frame.origin.y;
}

- (void)setTop:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom
{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)width
{
    CGRect frame = self.frame;
    frame.size.width = width;
    self.frame = frame;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)height
{
    CGRect frame = self.frame;
    frame.size.height = height;
    self.frame = frame;
}

- (void)showFrame
{
    NSLog(@"%f %f %f %f", self.frame.origin.x, self.frame.origin.y, self.width, self.height);
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX
{
    CGRect newFrame = self.frame;
    newFrame.origin.x = newX;
    self.frame = newFrame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY
{
    CGRect newFrame = self.frame;
    newFrame.origin.y = newY;
    self.frame = newFrame;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

-(void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}
-(CGFloat)centerX
{
    return self.center.x;
    
}

-(void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
-(CGFloat)centerY
{
    return self.center.y;
    
}

- (void)setSize:(CGSize)size {
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}
- (CGSize)size {
    return self.frame.size;
}

+ (id)viewWithBackgroudColor:(UIColor *)backgroudColor
{
    UIView * view =[UIView new];
    view.backgroundColor=backgroudColor;
    return view;
}

-(void)setTheViewDic:(NSDictionary *)theViewDic{
    objc_setAssociatedObject(self, &theViewDicKey, theViewDic, OBJC_ASSOCIATION_COPY);
}

-(NSDictionary *)theViewDic{
    return objc_getAssociatedObject(self, &theViewDicKey);
}

- (void)tb_addTarget:(id)target action:(SEL)action;
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:target action:action];
    self.userInteractionEnabled = YES;
    [self addGestureRecognizer:tap];
}

-(id)setCheekWithColor:(UIColor*)color borderWidth:(float)width roundedRect:(float)radian
{
    self.clipsToBounds=YES;
    if(radian)self.layer.cornerRadius = radian;
    if(color)self.layer.borderColor = [color CGColor];
    if(width > 0)self.layer.borderWidth = width;
    return self;
}
//获取Window当前显示的ViewController
- (UIViewController*)currentViewController{
    UIViewController* vc = MY_WINDOW.rootViewController;
    while (1) {
        if ([vc isKindOfClass:[UITabBarController class]]) {
            if ([self superview]) {
                vc = [self getSuperViewController];
            }else{
                vc = ((UITabBarController*)vc).selectedViewController;
            }
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}
- (UIViewController *)getSuperViewController
{
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    UIViewController* vc = MY_WINDOW.rootViewController;
    vc = ((UITabBarController*)vc).selectedViewController;
    return vc;
}

#pragma mark  ----------- UILabel ---------------

+(UILabel*)createLabelWithFrame:(CGRect)frame text:(NSString *)string font:(UIFont *)font textColor:(UIColor *)color TextAlignment:(int)textAlignment AddToSuperView:(UIView *)superview{
    UILabel*label = [[UILabel alloc] init];
    label.numberOfLines = 0;
    label.frame = frame;
    label.text = string;
    label.font = font;
//    label.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
//    label.adjustsFontForContentSizeCategory = YES;
    label.textColor = color;
    label.textAlignment = textAlignment;
    [superview addSubview:label];
    return label;
}

+(UILabel*)LabelWithText:(NSString*)string font:(int)font textColor:(UIColor *)color TextAlignment:(int)textAlignment AddToSuperView:(UIView *)superview
{
    UILabel*label = [[UILabel alloc] init];
    label.text = string;
    label.font = FONT_Regular(font);
    label.textColor = color;
    label.textAlignment = textAlignment;
    if(superview)[superview addSubview:label];
    return label;
}

+(UILabel*)LabelWithFrame:(CGRect)frame text:(NSString*)string font:(int)font textColor:(UIColor *)color TextAlignment:(int)textAlignment AddToSuperView:(UIView *)superview
{
    UILabel*label = [[UILabel alloc] init];
    label.frame = frame;
    label.text = string;
    label.font = FONT_Regular(font);
    label.textColor = color;
    label.textAlignment = textAlignment;
    [superview addSubview:label];
    return label;
}

+(UILabel *)LabelWithFrame:(CGRect)frame
                 TextColor:(UIColor *)textColor
           BackgroundColor:(UIColor *)backgroundColor
                  FontSize:(CGFloat)size
             NumberOfLines:(NSInteger)numberOfLines
             TextAlignment:(NSTextAlignment)textAlignment
                      Text:(NSString *)text
{
    UILabel * label = [[UILabel alloc]initWithFrame:frame];
    label.backgroundColor  = backgroundColor;
    label.textColor = textColor;
    label.numberOfLines = numberOfLines;
    if (![text isBlankString]) {
        label.text = text;
    }
    label.textAlignment = textAlignment;
    label.font = FONT_Regular(size);
    return label;
}

+(UIButton *)buttonWithTitle:(NSString *)title frame:(CGRect)frame backgroundColor:(UIColor *)backgroundColor titleColor:(UIColor *)titleColor font:(int)font
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    button.backgroundColor = backgroundColor;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = FONT_Regular(font);
    return button;
}
+(UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(int)font image:(UIImage *)image target:(id)target action:(SEL)action AddToSuperView:(UIView *)superview{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if(font)button.titleLabel.font = FONT_Regular(font);
    if(image)[button setImage:image forState:UIControlStateNormal];
    if(title)[button setTitle:title forState:UIControlStateNormal];
    if(titleColor) [button setTitleColor:titleColor forState:UIControlStateNormal];
    if(target)[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (superview) [superview addSubview:button];
    return button;
}

+(UIButton *)createButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor font:(UIFont *)font image:(UIImage *)image target:(id)target action:(SEL)action AddToSuperView:(UIView *)superview{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    if(font)button.titleLabel.font = font;
    if(image)[button setImage:image forState:UIControlStateNormal];
    if(image)[button setImage:image forState:UIControlStateHighlighted];
    if(title)[button setTitle:title forState:UIControlStateNormal];
    if(titleColor) [button setTitleColor:titleColor forState:UIControlStateNormal];
    if(target)[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (superview) [superview addSubview:button];
    return button;
}

+ (UIButton *)buttonWithFrame:(CGRect)frame title:(NSString *)title titlecolor:(UIColor*)title_color target:(id)target action:(SEL)action AddToSuperView:(UIView *)superview
{
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = frame;
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:title_color forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (superview) {
        [superview addSubview:button];
    };
    return button;
}

+(UIButton*)buttonWithFrame:(CGRect)fram backgroundimage:(UIImage *)image target:(id)target action:(SEL)action AddToSuperView:(UIView *)superview
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = fram;
    [button setBackgroundImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (superview) {
        [superview addSubview:button];
    };

    return button;
}
+(UIButton*)buttonWithFrame:(CGRect)fram image:(UIImage *)image target:(id)target action:(SEL)action AddToSuperView:(UIView *)superview
{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = fram;
    [button setImage:image forState:UIControlStateNormal];
    if(action)[button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    if (superview) {
        [superview addSubview:button];
    }

    return button;
}

+(UITextField *)fieldWithFrame:(CGRect)frame placeholder:(NSString *)placeholder textColor:(UIColor *)color andPlaceholderTextColor:(UIColor *)placeholdertextColor andPlaceholderFont:(UIFont *)placeholderFont AddToSuperView:(UIView *)superview
{
    UITextField *textField = [[UITextField alloc]initWithFrame:frame];
    textField.leftViewMode = UITextFieldViewModeAlways;
    textField.placeholder = placeholder;
    textField.textColor = color;
    textField.backgroundColor = [UIColor clearColor];
    textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    textField.borderStyle = UITextBorderStyleNone;

    if(placeholder.length && placeholdertextColor){
        NSAttributedString *attrStringc = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSForegroundColorAttributeName: placeholdertextColor}];
        textField.attributedPlaceholder = attrStringc;
    }
  
    if(placeholder.length && placeholdertextColor){
        NSAttributedString *attrStringf = [[NSAttributedString alloc] initWithString:placeholder attributes:@{NSFontAttributeName:placeholderFont}];
        textField.attributedPlaceholder = attrStringf;
    }
        
        
    if (superview) [superview addSubview:textField];
    return textField;
}

+(UIImageView *)ImageViewWithFrame:(CGRect)frame Image:(NSString *)image AddToSuperView:(UIView *)superview
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:frame];
    imgView.clipsToBounds = YES;
    imgView.contentMode =  UIViewContentModeScaleAspectFill;
    imgView.image = [UIImage imageNamed:image];
    if (superview)[superview addSubview:imgView];
    return imgView;
}
+(UIImageView *)createImageViewWithFrame:(CGRect)frame Image:(UIImage *)image AddToSuperView:(UIView *)superview
{
    UIImageView * imgView = [[UIImageView alloc]initWithFrame:frame];
    imgView.clipsToBounds = YES;
    imgView.contentMode =  UIViewContentModeScaleAspectFill;
    imgView.image = image;
    if (superview)[superview addSubview:imgView];
    return imgView;
}

- (void)cornerRadius:(CGFloat)radius {
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius  = radius;
}

- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.masksToBounds = YES;
    if(radius)self.layer.cornerRadius  = radius;
    if(borderColor)self.layer.borderColor = borderColor.CGColor;
    if(borderWidth)self.layer.borderWidth = borderWidth;
}
- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth showShadow:(BOOL)shadow{
    if(radius)self.layer.cornerRadius  = radius;
    if(borderColor)self.layer.borderColor = borderColor.CGColor;
    if(borderWidth)self.layer.borderWidth = borderWidth;
    //添加阴影
    if (shadow) {
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2, 2);// 阴影的范围
        self.layer.shadowRadius = 5;// 阴影扩散的范围控制
        self.layer.shadowOpacity = 0.2; // 阴影透明度
        self.layer.shadowColor = [UIColor blackColor].CGColor; // 阴影的颜色
    }
}

- (void)cornerRadius:(CGFloat)radius borderColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth showShadowColor:(UIColor *)color{
    if(radius)self.layer.cornerRadius  = radius;
    if(borderColor)self.layer.borderColor = borderColor.CGColor;
    if(borderWidth)self.layer.borderWidth = borderWidth;
    //添加阴影
    if (color) {
        self.layer.backgroundColor = [UIColor whiteColor].CGColor;
        self.layer.shadowOffset = CGSizeMake(2, 2);// 阴影的范围
        self.layer.shadowRadius = 5;// 阴影扩散的范围控制
        self.layer.shadowOpacity = 0.2; // 阴影透明度
        self.layer.shadowColor = color.CGColor; // 阴影的颜色
    }
}
// 添加阴影
- (void)dropShadowWithOffset:(CGSize)offset
                      radius:(CGFloat)radius
                       color:(UIColor *)color
                     opacity:(CGFloat)opacity{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    self.layer.shadowPath = path;
    CGPathCloseSubpath(path);
    CGPathRelease(path);
    
    self.layer.shadowColor = color.CGColor;
    self.layer.shadowOffset = offset;
    self.layer.shadowRadius = radius;
    self.layer.shadowOpacity = opacity;
    
    // Default clipsToBounds is YES, will clip off the shadow, so we disable it.
    self.clipsToBounds = NO;
}

- (void)borderWithColor:(UIColor*)borderColor borderWidth:(CGFloat)borderWidth {
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
}

- (void)makeRoundedCorner:(UIRectCorner)byRoundingCorners cornerRadii:(CGSize)cornerRadii {
    UIBezierPath* path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:byRoundingCorners cornerRadii:cornerRadii];
    path.lineWidth     = 0.5;
    path.lineCapStyle  = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    CAShapeLayer* shape = [CAShapeLayer layer];
    shape.path = path.CGPath;
    self.layer.mask = shape;
}

-(void)addDropShadowWithColors:(NSArray *)colors startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint andLocations:(NSArray<NSNumber *> *)locations{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.bounds;
    NSMutableArray *theColors = [NSMutableArray new];
    for (int i = 0; i < colors.count; i++) {
        UIColor * theColor = [colors objectAtIndex:i];
        [theColors addObject:(id)theColor.CGColor];
    }
    gradient.colors = theColors;
    gradient.startPoint = startPoint;
    gradient.endPoint = endPoint;
    if(locations)gradient.locations = locations;
    [self.layer insertSublayer:gradient atIndex:0];

}


+(UIView*)ViewWithframe:(CGRect)rect color:(UIColor*)color AddToSuperview:(UIView *)superview
{
    UIView*view=[[UIView alloc]initWithFrame:rect];
    view.backgroundColor=color;
    if(superview)[superview addSubview:view];
    return view;
}

+(UIView*)LineviewWithframe:(CGRect)rect color:(UIColor*)color AddToSuperview:(UIView *)superview
{
    UIView*view=[[UIView alloc]initWithFrame:rect];
    view.backgroundColor=color;
   if(superview) [superview addSubview:view];
    return view;
}

+(CGSize)getSizeWithText:(NSString*)text andFont:(UIFont *)font andSize:(CGSize)size
{
    if (!text) {
        return CGSizeMake(0, 0);
    }
    NSDictionary * tdic = [NSDictionary dictionaryWithObjectsAndKeys:font, NSFontAttributeName,nil];
    size =[text boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:tdic context:nil].size;
    
    return size;
}
+ (NSMutableAttributedString *)changeContent:(NSArray *)changeArr allContent:(NSString *)contentStr andColor:(NSArray*)colorArr andFont:(NSArray *)fontArr
{
    NSMutableAttributedString * sString =[[NSMutableAttributedString alloc] initWithString:contentStr];
    for (int i= 0; i < changeArr.count; i ++) {
        NSLog(@"%@~~~%@~~~~%@",[colorArr objectAtIndex:i],[changeArr objectAtIndex:i],[fontArr objectAtIndex:i]);
        [sString addAttribute:NSForegroundColorAttributeName value:[colorArr objectAtIndex:i] range:[contentStr rangeOfString:[changeArr objectAtIndex:i]]];
        [sString addAttribute:NSFontAttributeName value:[fontArr objectAtIndex:i] range:[contentStr rangeOfString:[changeArr objectAtIndex:i]]];
    }
    return sString;
}



+(void)hideAlert
{
    [MBProgressHUD hideHUDForView:MY_WINDOW animated:YES];
}

+(void)showAlertTitle:(NSString *)titleString detailsText:(NSString *)detailsString time:(float)time aboutType:(MBProgressHUDMode)mode
{
    [self hideAlert];
    MBProgressHUD *hud =[MBProgressHUD showHUDAddedTo:MY_WINDOW animated:YES];
    hud.removeFromSuperViewOnHide = YES;
    //    if (mode == MBProgressHUDModeCustomView) {
    //        if (isSuccess) {
    //            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Success_Out"]];
    //        }else{
    //            hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Failure_Out"]];
    //        }
    //    }
    if (mode)hud.mode = mode;
    if (titleString)hud.label.text = titleString;
    if (detailsString)hud.detailsLabel.text = detailsString;
    if (time > 0){
        [hud hideAnimated:YES afterDelay:time];
    }else{
        [hud hideAnimated:YES afterDelay:20.0];
    }
}

+ (NSString *)className {
    return NSStringFromClass(self);
}
+(id)showLackPageViewframe:(CGRect)frame name:(NSString *)imgName title:(NSString *)title{
    UIView *bgView = [UIView ViewWithframe:frame color:FILL_WHITE AddToSuperview:nil];
    
    float ww = Get_Width_Float(208);
    float hh =  Get_Width_Float(208)*IMG(imgName).size.height /IMG(imgName).size.width;
    float ping_left_right = (SCREEN_WIDTH - ww)/2;
    UIImageView *LackImg = [UIImageView ImageViewWithFrame:CGRectMake(ping_left_right, 60, ww, hh) Image:imgName AddToSuperView:bgView];
    
    UILabel *titleLab = [UILabel LabelWithText:title font:15 textColor:TEXT_GRAY_COLOR1 TextAlignment:1 AddToSuperView:bgView];
    titleLab.frame = CGRectMake(LEFT_RIGHT_PING, LackImg.bottom, SCREEN_WIDTH - LEFT_RIGHT_PING*2, 20);

    return bgView;
}

+(id)showLackPageViewframe:(CGRect)frame name:(NSString *)imgName title:(NSString *)title changContent:(NSString *)content{
    
    UIView *bgView = [[UIView alloc] initWithFrame:frame];
    float ww = Get_Width_Float(208);
    float hh =  Get_Width_Float(208)*IMG(imgName).size.height /IMG(imgName).size.width;
    float ping_left_right = (SCREEN_WIDTH - ww)/2;
    UIImageView *LackImg = [UIImageView ImageViewWithFrame:CGRectMake(ping_left_right, 60, ww, hh) Image:imgName AddToSuperView:bgView];
    
    UILabel *titleLab = [UILabel LabelWithText:title font:15 textColor:TEXT_GRAY_COLOR1 TextAlignment:1 AddToSuperView:bgView];
    titleLab.attributedText = [UILabel changeContent:@[content] allContent:title andColor:@[MIAN_COLOR] andFont:@[FONT_Semibold(15)]];
    titleLab.frame = CGRectMake(LEFT_RIGHT_PING, LackImg.bottom, SCREEN_WIDTH - LEFT_RIGHT_PING*2, 20);
    
    return bgView;
}
+(id)showLackPageViewframe:(CGRect)frame name:(NSString *)imgName title:(NSString *)title btnTitle:(NSString *)btntitle target:(id)target action:(SEL)action{

    UIView *bgView = [UIView ViewWithframe:frame color:FILL_WHITE AddToSuperview:nil];
    
    float ww = Get_Width_Float(208);
    float hh =  Get_Width_Float(208)*IMG(imgName).size.height /IMG(imgName).size.width;
    float ping_left_right = (SCREEN_WIDTH - ww)/2;
    UIImageView *LackImg = [UIImageView ImageViewWithFrame:CGRectMake(ping_left_right, 60, ww, hh) Image:imgName AddToSuperView:bgView];
    
    UILabel *titleLab = [UILabel LabelWithText:title font:15 textColor:TEXT_GRAY_COLOR1 TextAlignment:1 AddToSuperView:bgView];
    titleLab.frame = CGRectMake(LEFT_RIGHT_PING, LackImg.bottom, SCREEN_WIDTH - LEFT_RIGHT_PING*2, 20);
    
    UIButton *btn = [UIButton buttonWithFrame:CGRectMake(LEFT_RIGHT_PING, titleLab.bottom + 15, SCREEN_WIDTH - LEFT_RIGHT_PING*2, 13) title:btntitle titlecolor:MIAN_COLOR target:target action:action AddToSuperView:bgView];
    btn.titleLabel.font = FONT_Medium(12);
    
    [UIView LineviewWithframe:CGRectMake((SCREEN_WIDTH -167)/2, btn.bottom, 167, 1.0) color:MIAN_COLOR AddToSuperview:bgView];
    
    
    
    return bgView;
}



@end
