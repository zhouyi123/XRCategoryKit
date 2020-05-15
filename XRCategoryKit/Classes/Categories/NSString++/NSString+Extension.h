//
//  NSString+Extension.h
//  正则表达式
//
//  Created by apple on 14/11/15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

//判断是否为全数字
+ (BOOL)isNum:(NSString *)checkedNumString;
//判断是否为全字母
- (BOOL)includeChinese;
//判断是否为全汉字
- (BOOL)isChinese;
- (BOOL)isQQ;
- (BOOL)isPhoneNumber;
- (BOOL)isIPAddress;


+ (BOOL)isBlankString:(NSString *)str ;

//判断是否为空串
-(BOOL) isBlankString;
// 空字符串 转换成 @“”
+ (NSString *)nullTransWithString:(NSString *)string;

/*邮箱验证 MODIFIED BY HELENSONG*/
-(BOOL)isValidateEmail;

//身份证号
-(BOOL) validateIdentityCard;

//判断获取data 是不是为一
+(BOOL) isGetDataWithOne:(id)one;

#pragma mark - 限制emoji表情输入
+ (NSString *)disableEmoji:(NSString *)text;

#pragma mark - 计算动态高度
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW;
//添加行高后的高度
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW lineSpacing:(CGFloat)lineSpacing;
//获取宽度
+(CGSize)getHSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size WithText:(NSString *)text;

+ (NSMutableAttributedString *)changeFont:(NSArray *)changeArr content:(NSString *)contentStr andColor:(NSArray*)colorArr andFont:(NSArray *)fontArr;

+(NSString *)getWeekDateWithString:(NSString *)dateStr;

- (NSString *)ChineseWithInteger:(NSInteger)integer;

+(NSString *)showJson:(id)responseObject;

#pragma mark - 获取Time
//将某个时间转化成 时间戳
+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format;

//
+ (NSString *)compareNowTo:(NSDate *)toTime;
//比较两个日期大小
+ (NSString *)compare:(NSDate *)startTime to:(NSDate *)endTime;
//获取当前时间
+ (NSString *)getLocationTime;
//获取当前时间戳
+ (NSString *)currentTimeStr;
//获取当前时间30分20秒
+ (NSString *)ConvertStrToTime:(NSString *)timeStr;
//将时间戳转成正常显示年月日时分秒的时间
-(NSString*)transtoFullNormalTime;
//转月日
-(NSString*)transtoMDTime;

+ (NSString*)CgroupdictionaryToJson:(id)dic;
//去掉字符串中的\n \t?
-(NSString *)specialCharacterRemoval;

+(NSString*)getFileMD5WithPath:(NSString*)path;

+ (long long)fileSizeAtPath:(NSString*)filePath;
+ (long long)fileTimesWithPath:(NSString *)fileStr;

//获取房屋全部类型
+(NSMutableArray *)getHouseTypeArray:(NSArray *)arr;
//获取房屋全部类型  装修派
+(NSString *)getHouseTypeMessagePaiString:(NSArray *)arr;
//获取房屋全部类型  装修派
+(NSMutableArray *)getHouseTypeWithMessagePaiArray:(NSArray *)arr;
//中介
+(NSMutableArray *)getNewNumHouseTypeWithMessagePaiArray:(NSArray *)arr;
+(NSString *)getNewNumHouseTypeMessagePaiString:(NSArray *)arr;
//获取房屋特定类型
+(NSString *)getHouseTypeString:(NSArray *)arr;

+(NSString *)getAddress:(NSString *)addressId;
//显示不完整号码
+(NSString *)getlockPhone:(NSString *)phone;
//显示不完整姓名
+(NSString *)getlockRealName:(NSString *)realName;
//显示不完整身份证号码
+(NSString *)getlockNIdNum:(NSString *)idNum;
//密码转md5
+ (NSString *)md5To32bit:(NSString *)str ;
//json转字典
+ (NSDictionary *)dictionaryWithJsonString:(id)json;
//数据转json
+(NSString *)convertToJsonData:(id)data;
//model转化为字典
+ (NSDictionary *)dicFromObject:(NSObject *)object;

+(NSString *)updateTimeForRow:(NSString *)createTimeString;

+ (NSArray *)arrayWithJsonString:(NSString *)jsonString;
#pragma mark - 正则比配URL
+ (BOOL)getUrlLink:(NSString *)link;
//判断是否为整形：
+(BOOL)isPureInt:(NSString*)string;
//判断是否为浮点形：
+(BOOL)isPureFloat:(NSString*)string;
//换算
//+(NSString *)XRBGoldenBeanNum:(double)num;

@end
