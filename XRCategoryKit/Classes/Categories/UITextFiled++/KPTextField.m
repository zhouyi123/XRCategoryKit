//
//  KPTextField.m
//  XuanRui_APP
//
//  Created by zhouyi on 2018/9/4.
//  Copyright © 2018年 XRZJ. All rights reserved.
//

#import "KPTextField.h"

@implementation KPTextField

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didBeginEditing) name:UITextFieldTextDidBeginEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didEndEditing) name:UITextFieldTextDidEndEditingNotification object:self];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:self];
        self.delegate = self;
        _maxLengthOfHaveDian = 2;
    }
    return self;
}

- (void)setPlaceHolderNormalColor:(UIColor *)placeHolderNormalColor {
    
    _placeHolderNormalColor = placeHolderNormalColor;
    if (self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderNormalColor}];
    }
    
}

- (void)setPlaceHolderHighlightedSize:(CGFloat)placeHolderHighlightedSize{
    _placeHolderHighlightedSize = placeHolderHighlightedSize;
    if (self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_placeHolderHighlightedSize]}];
    }
}

- (void)setMaxLengthOfHaveDian:(NSUInteger)maxLengthOfHaveDian{
    _maxLengthOfHaveDian = maxLengthOfHaveDian;
}
- (void)didBeginEditing {
    
    NSInteger wordCount = self.text.length;
    if(wordCount){
        if (self.placeholder) {
              self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderHighlightedColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:_placeHolderHighlightedSize]}];
        }
    }else{
        if (self.placeholder) {
            
                self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:_placeHolderFontSize]}];
            
        }
    }
}

- (void)didEndEditing {
    
    NSInteger wordCount = self.text.length;
    if(wordCount){
        if (self.placeholder) {
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderHighlightedColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:_placeHolderHighlightedSize]}];
        }
    }else{
        if (self.placeholder) {
            
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:_placeHolderFontSize]}];
            
        }
    }
    
}

- (void)setPlaceHolderFontSize:(CGFloat)placeHolderFontSize {
    _placeHolderFontSize = placeHolderFontSize;
    if (self.placeholder) {
        self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:_placeHolderFontSize]}];
    }
}


//控制 placeHolder 的位置，左右缩进
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds,
                       self.paddingWith == 0.0f ? KPTextFieldPaddingWidth : self.paddingWith,
                       self.paddingHeight == 0.0f ? KPTextFieldPaddingHeight : self.paddingHeight);
}

// 控制文本的位置，左右缩进
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return CGRectInset(bounds,
                       self.paddingWith == 0.0f ? KPTextFieldPaddingWidth : self.paddingWith,
                       self.paddingHeight == 0.0f ? KPTextFieldPaddingHeight : self.paddingHeight);
}

- (void)setPaddingWith:(CGFloat)paddingWith {
    _paddingWith = paddingWith;
    [self setNeedsDisplay];
}

- (void)setPaddingHeight:(CGFloat)paddingHeight {
    _paddingHeight = paddingHeight;
    [self setNeedsDisplay];
}

- (void)setLeftMargin:(CGFloat)leftMargin {
    _leftMargin = leftMargin;
    [self setValue:[NSNumber numberWithFloat:leftMargin] forKey:@"paddingLeft"];
}

- (void)setRightMargin:(CGFloat)rightMargin {
    _rightMargin = rightMargin;
    [self setValue:[NSNumber numberWithFloat:rightMargin] forKey:@"paddingRight"];
}


- (void)setClearButtonNormalImageName:(NSString *)clearButtonNormalImageName {
    _clearButtonNormalImageName = clearButtonNormalImageName;
    UIButton *clearButton = [self valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:clearButtonNormalImageName] forState:UIControlStateNormal];
}

- (void)setClearButtonHighlightedImageName:(NSString *)clearButtonHighlightedImageName {
    _clearButtonHighlightedImageName = clearButtonHighlightedImageName;
    UIButton *clearButton = [self valueForKey:@"_clearButton"];
    [clearButton setImage:[UIImage imageNamed:clearButtonHighlightedImageName] forState:UIControlStateHighlighted];
}

- (void)setBorderWidth:(NSUInteger)borderWidth {
    _borderWidth = borderWidth;
    self.layer.borderWidth = _borderWidth;
}

- (void)setBorderColor:(UIColor *)borderColor {
    _borderColor = borderColor;
    self.layer.borderColor = _borderColor.CGColor;
}

- (void)setCornerRadius:(NSUInteger)cornerRadius {
    _cornerRadius = cornerRadius;
    self.layer.cornerRadius = cornerRadius;
}

- (CGRect)caretRectForPosition:(UITextPosition *)position
{
    CGRect originalRect = [super caretRectForPosition:position];
    
    if (_cursorHeight) {
        originalRect.size.height = _cursorHeight;
    }else {
        originalRect.size.height = self.font.lineHeight + 4;
    }
    if (_cursorWidth) {
        originalRect.size.width = _cursorWidth;
    }else {
        originalRect.size.width = 2;
    }
    
    return originalRect;
}

- (void)textLengthOverLimit:(KP_textFieldLengthOverLimitBlock)block {
   // _textOverLimitBlock = block;
}


- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    if (action == @selector(paste:))//禁止粘贴
        return !_forbidPaste;
    if (action == @selector(select:))// 禁止选择
        return NO;
    if (action == @selector(selectAll:))// 禁止全选
        return NO;
    return [super canPerformAction:action withSender:sender];
}

- (void)setPasswordMode:(BOOL)PasswordMode {
    _PasswordMode = PasswordMode;
    if (_PasswordMode) {
        self.placeholder = @"请输入密码";
        self.secureTextEntry = YES;
        self.clearButtonMode = UITextFieldViewModeNever;
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.height, self.frame.size.height)];
        imageView.image = [UIImage imageNamed:@"4321"];
        self.rightView = imageView;
        self.rightViewMode = UITextFieldViewModeAlways;
        imageView.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changPasswordMode:)];
        [imageView addGestureRecognizer:tap];
    }
}

- (void)changPasswordMode:(UITapGestureRecognizer *)tapGesture {
    UIImageView *imageView = (UIImageView *)tapGesture.view;
    _PasswordMode = !_PasswordMode;
    if (!_PasswordMode) {
        self.secureTextEntry = NO;
        imageView.image = [UIImage imageNamed:@"1234"];
    }else if (_PasswordMode) {
        self.secureTextEntry = YES;
        imageView.image = [UIImage imageNamed:@"4321"];
    }
}



- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)textDidChange{
    NSInteger wordCount = self.text.length;
    NSLog(@"%ld",(long)wordCount);
    
    if(wordCount){
        if (self.placeholder) {
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderHighlightedColor,NSFontAttributeName:[UIFont boldSystemFontOfSize:_placeHolderHighlightedSize]}];
        }
    }else{
        if (self.placeholder) {
            
            self.attributedPlaceholder = [[NSAttributedString alloc] initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:_placeHolderNormalColor,NSFontAttributeName:[UIFont systemFontOfSize:_placeHolderFontSize]}];
            
        }
    }
    

    if(self.textFieldChangeText){
        NSString *changeText = self.text;
        if([self.text hasSuffix:@"."]){
            changeText = [self.text substringToIndex:self.text.length - 1];
            
        }
        NSLog(@"textFieldChangeText=%@",changeText);
        self.textFieldChangeText(changeText);
    }
  
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    
    NSInteger wordCount = self.text.length;
    
    NSInteger allMaxCont = _maxLengthOfText + self.tt ;
    
    if(string.length){//继续输入
        wordCount = wordCount + 1;//当前输入框的个数
        unichar single=[string characterAtIndex:0];
        if(single == '.') {//判段当前输入的字符是否是"." 为临界
            self.frontTempInt = self.text.length;//获取整数的个数
            allMaxCont  =  self.frontTempInt + self.maxLengthOfHaveDian + 1;//最多输入 =整数个数 + 小数点个数 + 小数点
        }
        if ([self.text rangeOfString:@"."].location!=NSNotFound) {//如果有小数点。最多输入 = 整数个数 + 小数点个数 + 小数点
            allMaxCont  =  self.frontTempInt + self.maxLengthOfHaveDian + 1;
        }
    }else{//回退
        if(self.text.length){
            wordCount = wordCount - 1;//当前输入框的个数
            unichar single=   [self.text characterAtIndex:self.text.length - 1];//当前输入的字符
            if(single == '.') {//如果回退到小数点，那么就是回到输入整数的部分 且最多输入 =  整数个数
                allMaxCont  =  _maxLengthOfText;
            }
            if ([self.text rangeOfString:@"."].location==NSNotFound) {//如果没有小数点。最多输入 = 整数个数
                allMaxCont  =  _maxLengthOfText;
            }
        }
    }
    if (wordCount > allMaxCont ) {//超出就不输入
        
        return NO;
        
    }else {//小数点的判读规则
        
        BOOL isHaveDian = YES;
        
        if ([textField.text rangeOfString:@"."].location==NSNotFound) {
            self.tt = 0;
            isHaveDian=NO;
            
        }
        
        if ([string length]>0) {
            
            unichar single=[string characterAtIndex:0];//当前输入的字符
            
            if ((single >='0' && single<='9') || single=='.') {//数据格式正确
                
                //首字母不能为小数点
                
                if([textField.text length]==0) {
                    
                    if(single == '.') {
                        
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        
                        return NO;
                        
                    }
                    
                }
                if([textField.text length]==1 && [textField.text isEqualToString:@"0"]){
                    
                    if(single != '.'){
                        
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        
                        return NO;
                        
                    }
                    
                }
                if (single=='.') {
                    if(!isHaveDian) {//text中还没有小数点
                        isHaveDian=YES;
                        return YES;
                    }else {
                        [textField.text stringByReplacingCharactersInRange:range withString:@""];
                        return NO;
                    }
                }else {
                    if (isHaveDian){//存在小数点
                        
                        //判断小数点的位数
                        NSRange ran=[textField.text rangeOfString:@"."];
                        
                        self.tt = range.location-ran.location;
                        
                        if (self.tt <= _maxLengthOfHaveDian){
                            
                            return YES;
                            
                        }else{
                            
                            return NO;
                            
                        }
                        
                    }else {
                        return YES;
                    }
                }
                
            }else{//输入的数据格式不正确
                
                [textField.text stringByReplacingCharactersInRange:range withString:@""];
                
                return NO;
                
            }
            
        }else {
            
            return YES;
            
        }
        
    }
    
}
@end
