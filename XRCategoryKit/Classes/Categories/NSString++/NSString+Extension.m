//
//  NSString+Extension.m
//  正则表达式
//
//  Created by apple on 14/11/15.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import "NSString+Extension.h"
#import <AVFoundation/AVFoundation.h>
#include <CommonCrypto/CommonDigest.h>
#import <AssetsLibrary/AssetsLibrary.h>

#define FileHashDefaultChunkSizeForReadingData 1024*8

@implementation NSString (Extension)

- (BOOL)match:(NSString *)pattern
{
    // 1.创建正则表达式
    NSRegularExpression *regex = [[NSRegularExpression alloc] initWithPattern:pattern options:0 error:nil];
    // 2.测试字符串
    NSArray *results = [regex matchesInString:self options:0 range:NSMakeRange(0, self.length)];
    
    return results.count > 0;
}
//判断是否为全数字
+ (BOOL)isNum:(NSString *)checkedNumString {
    checkedNumString = [checkedNumString stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if(checkedNumString.length > 0) {
        return NO;
    }
    return YES;
}
//判断是否有汉子
- (BOOL)includeChinese
{
    for(int i=0; i< [self length];i++)
    {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}
- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)isQQ
{
    // 1.不能以0开头
    // 2.全部是数字
    // 3.5-11位
    return [self match:@"^[1-9]\\d{4,10}$"];
}

- (BOOL)isPhoneNumber
{
//    return [self match:@"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$"];
    [self hasPrefix:self];
    if (self.length == 11 && [self hasPrefix:@"1"]) {
        return YES;
    }
    return NO;
}

- (BOOL)isIPAddress
{
    // 1-3个数字: 0-255
    // 1-3个数字.1-3个数字.1-3个数字.1-3个数字
    return [self match:@"^\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}\\.\\d{1,3}$"];
}
+ (NSString *)nullTransWithString:(id )stringI
{
    if ([stringI isKindOfClass:[NSNumber class]]) {
        return [stringI stringValue];
    }
    if ([stringI isKindOfClass:[NSNull class]]) {
        return @"";
    }
    if (stringI == nil) {
        return @"";
    }
    if ([stringI isEqualToString:@"(null)"] || [stringI isEqualToString:@"nil"] || [stringI isEqualToString:@"null"] || [stringI isEqualToString:@"<null>"]) {
        return @"";
    }
    if ([[stringI stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return @"";
    }
    return stringI;
}

- (BOOL) isBlankString {

    if (self == nil || self == NULL) {
        return YES;
    }
    if ([self isEqual:[NSNull null]]) {
        return YES;
    }
    if (!self.length) {
        return YES;
    }
    if ([self isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([self isEqualToString:@"(null)"] || [self isEqualToString:@"nil"]) {
        return YES;
    }
    if ([[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

+ (BOOL)isBlankString:(NSString *)str {
    
    if (str == nil || str == NULL) {
        return YES;
    }
    if ([str isEqual:[NSNull null]]) {
        return YES;
    }
    if (!str.length) {
        return YES;
    }
    if ([str isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([str isEqualToString:@"(null)"] || [str isEqualToString:@"nil"]) {
        return YES;
    }
    if ([[str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0) {
        return YES;
    }
    return NO;
}

//判断获取data 是不是为一
+(BOOL) isGetDataWithOne:(id)one{
    if([one isKindOfClass:[NSNumber class]] && [one isEqualToNumber:@1]){
        return YES;
    }else if([one isKindOfClass:[NSString class]] && [one isEqualToString:@"1"]){
        return YES;
    }
    return NO;
}


-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//身份证号
-(BOOL) validateIdentityCard
{
    BOOL flag;
    if (self.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
    
}
-(NSString*)transtoFullNormalTime
{
    //1将获得的uinx时间戳转换成普通时间
    NSString * dateStrting = self;
//    KGLog(@"----timeStr:%@",dateStrting);
    NSTimeInterval  dateStrtingTime = [dateStrting doubleValue]/1000;//转成秒
    NSDate * dateTime = [NSDate dateWithTimeIntervalSince1970:dateStrtingTime];
//    KGLog(@"dateTime:%@",[ dateTime description]);
    
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";//
    NSString *dateStr = [fmt stringFromDate:dateTime];
//    KGLog(@"dateStr:%@",dateStr);
    return dateStr;
}
-(NSString*)transtoMDTime
{
    //1将获得的uinx时间戳转换成普通时间
    NSString * dateStrting = self;
    //    KGLog(@"----timeStr:%@",dateStrting);
    NSTimeInterval  dateStrtingTime = [dateStrting doubleValue]/1000;//转成秒
    NSDate * dateTime = [NSDate dateWithTimeIntervalSince1970:dateStrtingTime];
    //    KGLog(@"dateTime:%@",[ dateTime description]);
    
    NSDateFormatter * fmt = [[NSDateFormatter alloc]init];
    fmt.dateFormat = @"MM-dd HH:mm:ss";//
    NSString *dateStr = [fmt stringFromDate:dateTime];
    //    KGLog(@"dateStr:%@",dateStr);
    return dateStr;
}
#pragma mark - 限制emoji表情输入
+ (NSString *)disableEmoji:(NSString *)text
{
    NSRegularExpression *regular = [[NSRegularExpression alloc] initWithPattern:@"[^\\u0020-\\u007E\\u00A0-\\u00BE\\u2E80-\\uA4CF\\uF900-\\uFAFF\\uFE30-\\uFE4F\\uFF00-\\uFFEF\\u0080-\\u009F\\u2000-\\u201f\r\n]" options:NSRegularExpressionCaseInsensitive error:nil];
    NSString *modifiedString = [regular stringByReplacingMatchesInString:text options:NSMatchingReportProgress range:NSMakeRange(0, [text length]) withTemplate:@""];
    return modifiedString;
}

- (CGSize)sizeWithConstrainedSize:(CGSize)size font:(UIFont *)font lineSpacing:(CGFloat)lineSpacing {
    
    CGSize expectedSize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    expectedSize = [self boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    return CGSizeMake(ceil(expectedSize.width), ceil(expectedSize.height));
    
}
#pragma mark - 计算动态高度
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW lineSpacing:(CGFloat)lineSpacing
{
    CGSize expectedSize = CGSizeZero;
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.lineSpacing = lineSpacing;
    NSDictionary *attributes = @{NSFontAttributeName:font, NSParagraphStyleAttributeName:paragraphStyle.copy};
    
    expectedSize = [text boundingRectWithSize:CGSizeMake(maxW, FLT_MAX) options:NSStringDrawingUsesLineFragmentOrigin |NSStringDrawingUsesFontLeading attributes:attributes context:nil].size;
    
    return CGSizeMake(ceil(expectedSize.width), ceil(expectedSize.height));
    
}
+(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxW:(CGFloat)maxW{
    return [self sizeWithText:text font:font maxW:maxW lineSpacing:0];
}

+(CGSize)getHSizeWithFont:(UIFont *)font constrainedToSize:(CGSize)size WithText:(NSString *)text{
    CGSize resultSize = CGSizeZero;
    if (text.length <= 0) {
        return resultSize;
    }
    NSMutableParagraphStyle *style = [NSMutableParagraphStyle new];
    style.lineBreakMode = NSLineBreakByWordWrapping;
    resultSize = [text boundingRectWithSize:CGSizeMake(floor(size.width), floor(size.height))//用相对小的 width 去计算 height / 小 heigth 算 width
                                    options:(NSStringDrawingUsesFontLeading | NSStringDrawingUsesLineFragmentOrigin)
                                 attributes:@{NSFontAttributeName: font,
                                              NSParagraphStyleAttributeName: style}
                                    context:nil].size;
    resultSize = CGSizeMake(floor(resultSize.width + 1), floor(resultSize.height + 1));//上面用的小 width（height） 来计算了，这里要 +1
    return resultSize;
}

+ (NSMutableAttributedString *)changeFont:(NSArray *)changeArr content:(NSString *)contentStr andColor:(NSArray*)colorArr andFont:(NSArray *)fontArr
{
    NSMutableAttributedString * sString =[[NSMutableAttributedString alloc] initWithString:contentStr];
    for (int i= 0; i < changeArr.count; i ++) {
//        NSLog(@"%@~~~%@~~~~%@",[colorArr objectAtIndex:i],[changeArr objectAtIndex:i],[fontArr objectAtIndex:i]);
        [sString addAttribute:NSForegroundColorAttributeName value:[colorArr objectAtIndex:i] range:[contentStr rangeOfString:[changeArr objectAtIndex:i]]];
        [sString addAttribute:NSFontAttributeName value:[fontArr objectAtIndex:i] range:[contentStr rangeOfString:[changeArr objectAtIndex:i]]];
    }
    return sString;
}

#pragma mark - 把字符串的时间转成周几

+ (NSString *)getWeekDateWithString:(NSString *)dateStr
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormatter dateFromString:dateStr];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    NSDateComponents *comps = [calendar components:unitFlags fromDate:date];
    NSInteger weekday = [comps weekday]; // 星期几（注意，周日是“1”，周一是“2”）
    //阿拉伯数字转汉字
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:(int)weekday-1]];
    NSString *returnStr = [NSString stringWithFormat:@"周%@", string];
    return returnStr;
}
#pragma mark - 阿拉伯数字转汉字
- (NSString *)ChineseWithInteger:(NSInteger)integer
{
    NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
    formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
    NSString *string = [formatter stringFromNumber:[NSNumber numberWithInt:(int)integer]];
    if ([string isEqualToString:@"〇"]) {
        string = @"日";
    }
    return string;
}

+(NSString *)showJson:(id)responseObject{
    NSData * jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:nil];
    NSString * myString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return myString;
}


+ (NSString *)compareNowTo:(NSDate *)toTime {
    NSDate *date = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localeDate = [date  dateByAddingTimeInterval: interval];
    return [self compare:localeDate to:toTime];
}

+(NSInteger)timeSwitchTimestamp:(NSString *)formatTime andFormatter:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:format]; //(@"YYYY-MM-dd hh:mm:ss") ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Beijing"];
    [formatter setTimeZone:timeZone];
    
    NSDate* date = [formatter dateFromString:formatTime]; //------------将字符串按formatter转成nsdate
    //时间转时间戳的方法:
    NSInteger timeSp = [[NSNumber numberWithDouble:[date timeIntervalSince1970]] integerValue];
    NSLog(@"将某个时间转化成 时间戳&&&&&&&timeSp:%ld",(long)timeSp); //时间戳的值
    return timeSp;
}

+(NSString *)updateTimeForRow:(NSString *)createTimeString {

    //时间
//    NSString *createTimeString = @"2017-01-01 21:05:10";
    //把字符串转为NSdate
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *timeDate = [dateFormatter dateFromString:createTimeString];
    //得到与当前时间差
    NSTimeInterval timeInterval = [timeDate timeIntervalSinceNow];
    timeInterval = -timeInterval;
    
    NSInteger sec = timeInterval/60;
    if (sec<60) {
        return [NSString stringWithFormat:@"%ld分钟前",sec];
    }
    
    // 秒转小时
    NSInteger hours = timeInterval/3600;
    if (hours<24) {
        return [NSString stringWithFormat:@"%ld小时前",hours];
    }
    //秒转天数
    NSInteger days = timeInterval/3600/24;
    if (days < 30) {
        return [NSString stringWithFormat:@"%ld天前",days];
    }
    //秒转月
    NSInteger months = timeInterval/3600/24/30;
    if (months < 12) {
        return [NSString stringWithFormat:@"%ld月前",months];
    }
//    //秒转年
//    NSInteger years = timeInterval/3600/24/30/12;
//    return [NSString stringWithFormat:@"%ld年前",years];
    NSArray * arr = [createTimeString componentsSeparatedByString:@" "];
    return [arr objectAtIndex:0];

    
    
    
    
    
//    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
//    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
//
//    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
//    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
//    NSDate *timeDate = [dateFormatter dateFromString:createTimeString];
//    //得到与当前时间差
//    NSTimeInterval createTime = [timeDate timeIntervalSinceNow];
//    //    NSTimeInterval createTime = [createTimeString longLongValue]/1000;//时间戳转换
//
//    // 时间差
//    NSTimeInterval time = currentTime - createTime;
//
//    NSInteger sec = time/60;
//    if (sec<60) {
//        return [NSString stringWithFormat:@"%ld分钟前",sec];
//    }
//
//    // 秒转小时
//    NSInteger hours = time/3600;
//    if (hours<24) {
//        return [NSString stringWithFormat:@"%ld小时前",hours];
//    }
//    //秒转天数
//    NSInteger days = time/3600/24;
//    if (days < 30) {
//        return [NSString stringWithFormat:@"%ld天前",days];
//    }
//    //秒转月
//    NSInteger months = time/3600/24/30;
//    if (months < 12) {
//        return [NSString stringWithFormat:@"%ld月前",months];
//    }
//    //秒转年
//    NSInteger years = time/3600/24/30/12;
//    return [NSString stringWithFormat:@"%ld年前",years];
    
}





//比较两个日期大小
+ (NSString *)compare:(NSDate *)startTime to:(NSDate *)endTime {
    
    // 当前日历
    NSCalendar *calendar = [NSCalendar currentCalendar];
    // 需要对比的时间数据
    NSCalendarUnit unit = NSCalendarUnitYear | NSCalendarUnitMonth
    | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
    // 对比时间差
    NSDateComponents *dateCom = [calendar components:unit fromDate:startTime toDate:endTime options:0];
    NSString *time = nil;
    if (dateCom.year != 0) {
        return time = [NSString stringWithFormat:@"%ld 年前",labs(dateCom.year)];
    } else if (dateCom.month != 0) {
        return time = [NSString stringWithFormat:@"%ld 月前",labs(dateCom.month)];
    } else if (dateCom.day != 0) {
        return time = [NSString stringWithFormat:@"%ld 天前",labs(dateCom.day)];
    } else if (dateCom.hour != 0) {
        return time = [NSString stringWithFormat:@"%ld 小时前",labs(dateCom.hour)];
    } else if (dateCom.minute != 0) {
        return time = [NSString stringWithFormat:@"%ld 分钟前",labs(dateCom.minute)];
    } else {
        return time = [NSString stringWithFormat:@"%ld 秒前",labs(dateCom.second)];
    }
}

+ (NSString *)getLocationTime {
    NSDate *date = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
}
//获取当前时间戳
+ (NSString *)currentTimeStr{
    NSDate* date = [NSDate dateWithTimeIntervalSinceNow:0];//获取当前时间0秒后的时间
    NSTimeInterval time=[date timeIntervalSince1970]*1000;// *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", time];
    return timeString;
}

+ (NSString*)CgroupdictionaryToJson:(id)dic{
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

+ (NSString *)ConvertStrToTime:(NSString *)timeStr{

    long long time=[timeStr longLongValue];
    long second = time/1000%60;
    long m = time/1000/60;
    NSString *timeString;
    if(m >0){
       timeString  = [NSString stringWithFormat:@"%2ld分%2ld秒",m,second];
    }else{
       timeString = [NSString stringWithFormat:@"%2ld秒",second];
    }
   
    return timeString;

}

-(NSString *)specialCharacterRemoval{
    NSString *newStr = self;
    newStr = [newStr stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    return newStr;
}

+(NSString*)getFileMD5WithPath:(NSString*)path
{
    return (__bridge_transfer NSString *)FileMD5HashCreateWithPath((__bridge CFStringRef)path, FileHashDefaultChunkSizeForReadingData);
}

CFStringRef FileMD5HashCreateWithPath(CFStringRef filePath,size_t chunkSizeForReadingData) {
    // Declare needed variables
    CFStringRef result = NULL;
    CFReadStreamRef readStream = NULL;
    // Get the file URL
    CFURLRef fileURL =
    CFURLCreateWithFileSystemPath(kCFAllocatorDefault,
                                  (CFStringRef)filePath,
                                  kCFURLPOSIXPathStyle,
                                  (Boolean)false);
    if (!fileURL) goto done;
    // Create and open the read stream
    readStream = CFReadStreamCreateWithFile(kCFAllocatorDefault,
                                            (CFURLRef)fileURL);
    if (!readStream) goto done;
    bool didSucceed = (bool)CFReadStreamOpen(readStream);
    if (!didSucceed) goto done;
    // Initialize the hash object
    CC_MD5_CTX hashObject;
    CC_MD5_Init(&hashObject);
    // Make sure chunkSizeForReadingData is valid
    if (!chunkSizeForReadingData) {
        chunkSizeForReadingData = FileHashDefaultChunkSizeForReadingData;
    }
    // Feed the data to the hash object
    bool hasMoreData = true;
    while (hasMoreData) {
        uint8_t buffer[chunkSizeForReadingData];
        CFIndex readBytesCount = CFReadStreamRead(readStream,(UInt8 *)buffer,(CFIndex)sizeof(buffer));
        if (readBytesCount == -1) break;
        if (readBytesCount == 0) {
            hasMoreData = false;
            continue;
        }
        CC_MD5_Update(&hashObject,(const void *)buffer,(CC_LONG)readBytesCount);
    }
    // Check if the read operation succeeded
    didSucceed = !hasMoreData;
    // Compute the hash digest
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5_Final(digest, &hashObject);
    // Abort if the read operation failed
    if (!didSucceed) goto done;
    // Compute the string result
    char hash[2 * sizeof(digest) + 1];
    for (size_t i = 0; i < sizeof(digest); ++i) {
        snprintf(hash + (2 * i), 3, "%02x", (int)(digest[i]));
    }
    result = CFStringCreateWithCString(kCFAllocatorDefault,(const char *)hash,kCFStringEncodingUTF8);
    
done:
    if (readStream) {
        CFReadStreamClose(readStream);
        CFRelease(readStream);
    }
    if (fileURL) {
        CFRelease(fileURL);
    }
    return result;
}

+ (long long)fileSizeAtPath:(NSString*)filePath{
    
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

+ (long long)fileTimesWithPath:(NSString *)fileStr{
    
    AVURLAsset* audioAsset =[AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath: fileStr] options:nil];
    CMTime audioDuration = audioAsset.duration;
    float audioDurationSeconds = CMTimeGetSeconds(audioDuration);
    return audioDurationSeconds;
    
}

+(NSMutableArray *)getHouseTypeArray:(NSArray *)arr{
    NSMutableArray *typeArr = [NSMutableArray new];
//    NSArray *chinese_numerals = @[@"零",@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十",@"十一"];
     NSArray *chinese_numerals = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
    for (int i = 0; i < arr.count; i ++) {
        NSInteger num = [[arr objectAtIndex:i] integerValue];
        if (i == 0) {//室
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num; j++) {
                NSString *typeStr =  [NSString stringWithFormat:@"%@室", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
        }else if (i == 1){//厅
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num; j++) {
                NSString *typeStr = [NSString stringWithFormat:@"%@厅", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
        }else if (i == 2){//厨
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num ; j++) {
                NSString *typeStr = [NSString stringWithFormat:@"%@厨", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
        }else if (i == 3){//卫
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num ; j++) {
                NSString *typeStr = [NSString stringWithFormat:@"%@卫", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
        }else{//阳台
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num; j++) {
                NSString *typeStr = [NSString stringWithFormat:@"%@阳台", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
        }
    }
    return typeArr;
}

+(NSString *)getHouseTypeString:(NSArray *)arr{
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五",@"六",@"七",@"八",@"九",@"十"];
//    NSArray *chinese_numerals = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
    NSString *typeStr = @"";
    for (int i = 0; i < arr.count; i ++) {
        NSInteger num = [[arr objectAtIndex:i] integerValue];
        if (i == 0) {//室
            if (num > 0) {
                typeStr = [typeStr stringByAppendingFormat:@"%@室", [chinese_numerals objectAtIndex:num -1]];
            }
        }else if (i == 1){//厅
            if (num > 0) {
                typeStr = [typeStr stringByAppendingFormat:@"%@厅", [chinese_numerals objectAtIndex:num -1]];
            }
        }else if (i == 2){//厨
            if (num > 0) {
                typeStr = [typeStr stringByAppendingFormat:@"%@厨", [chinese_numerals objectAtIndex:num -1]];
            }
        }else if (i == 3){//卫
            if (num > 0) {
                typeStr = [typeStr stringByAppendingFormat:@"%@卫", [chinese_numerals objectAtIndex:num -1]];
            }
        }else{//阳台
            if (num > 0) {
                typeStr = [typeStr stringByAppendingFormat:@"%@阳台", [chinese_numerals objectAtIndex:num -1]];
            }
        }
    }
    return typeStr;
}
//523
+(NSMutableArray *)getHouseTypeWithMessagePaiArray:(NSArray *)arr{
    NSMutableArray *typeArr = [NSMutableArray new];

    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五"];
    for (int i = 0; i < arr.count; i ++) {
        
        NSInteger num = [[arr objectAtIndex:i] integerValue];
        if (i == 0) {//室
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num; j++) {
                NSString *typeStr =  [NSString stringWithFormat:@"%@室", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
            
        }else if (i == 1){//厅
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num; j++) {
                NSString *typeStr = [NSString stringWithFormat:@"%@厅", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
            
        }else if (i == 2){//卫
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num ; j++) {
                NSString *typeStr = [NSString stringWithFormat:@"%@卫", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
        }
    }
    return typeArr;
}
+(NSString *)getHouseTypeMessagePaiString:(NSArray *)arr{
    NSArray *chinese_numerals = @[@"一",@"二",@"三",@"四",@"五"];
    //    NSArray *chinese_numerals = @[@"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",@"11"];
    NSString *typeStr = @"";
    for (int i = 0; i < arr.count; i ++) {
        NSInteger num = [[arr objectAtIndex:i] integerValue];
        if(num >0){
            if (i == 0) {//室
                
                typeStr = [typeStr stringByAppendingFormat:@"%@室", [chinese_numerals objectAtIndex:num - 1]];
                
            }else if (i == 1){//厅
                
                typeStr = [typeStr stringByAppendingFormat:@"%@厅", [chinese_numerals objectAtIndex:num -1 ]];
                
            }else if (i == 2){//卫
                
                typeStr = [typeStr stringByAppendingFormat:@"%@卫", [chinese_numerals objectAtIndex:num - 1]];
                
            }
        }
    }
    return typeStr;
}
//中介
//523
+(NSMutableArray *)getNewNumHouseTypeWithMessagePaiArray:(NSArray *)arr{
    NSMutableArray *typeArr = [NSMutableArray new];
    
    NSArray *chinese_numerals = @[@"1",@"2",@"3",@"4",@"5"];
    for (int i = 0; i < arr.count; i ++) {
        
        NSInteger num = [[arr objectAtIndex:i] integerValue];
        if (i == 0) {//室
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num; j++) {
                NSString *typeStr =  [NSString stringWithFormat:@"%@室", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
            
        }else if (i == 1){//厅
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num; j++) {
                NSString *typeStr = [NSString stringWithFormat:@"%@厅", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
            
        }else if (i == 2){//卫
            NSMutableArray *sArr = [NSMutableArray new];
            for (int j = 0; j <num ; j++) {
                NSString *typeStr = [NSString stringWithFormat:@"%@卫", [chinese_numerals objectAtIndex:j]];
                [sArr addObject:typeStr];
            }
            [typeArr addObject:sArr];
        }
    }
    return typeArr;
}
+(NSString *)getNewNumHouseTypeMessagePaiString:(NSArray *)arr{
    NSArray *chinese_numerals = @[@"1",@"2",@"3",@"4",@"5"];

    NSString *typeStr = @"";
    for (int i = 0; i < arr.count; i ++) {
        NSInteger num = [[arr objectAtIndex:i] integerValue];
        if(num >0){
            if (i == 0) {//室
                
                typeStr = [typeStr stringByAppendingFormat:@"%@室", [chinese_numerals objectAtIndex:num - 1]];
                
            }else if (i == 1){//厅
                
                typeStr = [typeStr stringByAppendingFormat:@"%@厅", [chinese_numerals objectAtIndex:num -1 ]];
                
            }else if (i == 2){//卫
                
                typeStr = [typeStr stringByAppendingFormat:@"%@卫", [chinese_numerals objectAtIndex:num - 1]];
                
            }
        }
    }
    return typeStr;
}


+(NSString *)getAddress:(NSString *)addressId{
    NSDictionary *areaDic = [[PlistManager sharedInstance] getObjectFormPlist:@"Designer" WithKey:@"DesignerArea"];
    NSArray *theIdArr = [addressId componentsSeparatedByString:@","];
    NSString *addressStr = nil;
    NSArray *provincesArr = areaDic[@"provinces"];
    for (NSDictionary *dic in provincesArr) {
        if ([dic[@"id"] integerValue] == [[theIdArr objectAtIndex:0] integerValue]) {
            addressStr = dic[@"n"];
            NSArray *cityArr = dic[@"children"];
            for (NSDictionary *dic1 in cityArr) {
                if ([dic1[@"id"] integerValue] == [[theIdArr objectAtIndex:1] integerValue]) {
                    addressStr = [addressStr stringByAppendingString:dic1[@"n"] ];
                    NSArray *theAreaArr = dic1[@"children"];
                    for (NSDictionary *dic2 in theAreaArr) {
                        if ([dic2[@"id"] integerValue] == [[theIdArr objectAtIndex:2] integerValue]) {
                            addressStr = [addressStr stringByAppendingString:dic2[@"n"] ];
                            
                        }
                    }
                }
            }
        }
    }
    return addressStr;
}
//显示不完整号码
+(NSString *)getlockPhone:(NSString *)phone{
    if(!phone.length){
        return @"";
    }
    NSMutableString *string=[NSMutableString stringWithFormat:@"%@",phone];
    [string replaceCharactersInRange:NSMakeRange(3, 4) withString:@"****"];
    return string;
}
//显示不完整姓名
+(NSString *)getlockRealName:(NSString *)realName{
    if(!realName.length){
        return @"";
    }
    NSMutableString *string=[NSMutableString stringWithFormat:@"%@",realName];
    [string replaceCharactersInRange:NSMakeRange(0, string.length - 1) withString:@"**"];
    return string;
}
//显示不完整身份证号码
+(NSString *)getlockNIdNum:(NSString *)idNum{
    if(!idNum.length){
        return @"";
    }
    NSMutableString *string=[NSMutableString stringWithFormat:@"%@",idNum];
    [string replaceCharactersInRange:NSMakeRange(1, (string.length - 2)>0?string.length :0) withString:@"****************"];
    return string;
}
//密码转md5
+ (NSString *)md5To32bit:(NSString *)str {
    
    const char *cStrValue = [str UTF8String];
    unsigned char theResult[CC_MD5_DIGEST_LENGTH];
    CC_MD5(cStrValue, (unsigned)strlen(cStrValue), theResult);
    NSMutableString *result = [[NSMutableString alloc] init];
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++){
        [result appendFormat:@"%02x", theResult[i]];
    }
    
    return result;
}
//json转字典
+ (NSDictionary *)dictionaryWithJsonString:(id)json
{
    if (json == nil) {
        return nil;
    }
    if([json isKindOfClass:[NSDictionary class]]){
        return (NSDictionary *)json;
    }
    if([json isKindOfClass:[NSString class]]){
        NSString *jsonString = (NSString *)json;
        NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
        NSError *err;
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&err];
        if(err)
        {
            NSLog(@"json解析失败：%@",err);
            return nil;
        }
        return dic;
    }
    NSLog(@"数据类型错误");
    return nil;
}

+(NSString *)convertToJsonData:(id)data{
    if(data == nil){
        return nil;
    }
    
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:data options:NSJSONWritingPrettyPrinted error:&error];
    NSString *jsonString;
    if (!jsonData) {
        NSLog(@"%@",error);
    }else{
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
    NSRange range = {0,jsonString.length};
    //去掉字符串中的空格
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    NSRange range2 = {0,mutStr.length};
    //去掉字符串中的换行符
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    NSRange range3 = {0,mutStr.length};
    [mutStr replaceOccurrencesOfString:@"\r" withString:@"" options:NSLiteralSearch range:range3];

    NSString *str = mutStr;
    //去除掉首尾的空白字符和换行字符使用
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return str;
}

//model转化为字典
+ (NSDictionary *)dicFromObject:(NSObject *)object {
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    unsigned int count;
    objc_property_t *propertyList = class_copyPropertyList([object class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = propertyList[i];
        const char *cName = property_getName(property);
        NSString *name = [NSString stringWithUTF8String:cName];
        NSObject *value = [object valueForKey:name];//valueForKey返回的数字和字符串都是对象
        
        if ([value isKindOfClass:[NSString class]] || [value isKindOfClass:[NSNumber class]]) {
            //string , bool, int ,NSinteger
            [dic setObject:value forKey:name];
            
        } else if ([value isKindOfClass:[NSArray class]] || [value isKindOfClass:[NSDictionary class]]) {
            //字典或字典
            [dic setObject:[self arrayOrDicWithObject:(NSArray*)value] forKey:name];
        } else if (value == nil) {
            //null
            [dic setObject:[NSNull null] forKey:name];//这行可以注释掉?????
        } else {
            //model
            [dic setObject:[self dicFromObject:value] forKey:name];
        }
    }
    
    return [dic copy];
}
//将可能存在model数组转化为普通数组
+ (id)arrayOrDicWithObject:(id)origin {
    if ([origin isKindOfClass:[NSArray class]]) {
        //数组
        NSMutableArray *array = [NSMutableArray array];
        for (NSObject *object in origin) {
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [array addObject:object];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [array addObject:[self arrayOrDicWithObject:(NSArray *)object]];
            } else {
                //model
                [array addObject:[self dicFromObject:object]];
            }
        }
        return [array copy];
    } else if ([origin isKindOfClass:[NSDictionary class]]) {
        //字典
        NSDictionary *originDic = (NSDictionary *)origin;
        NSMutableDictionary *dic = [NSMutableDictionary dictionary];
        for (NSString *key in originDic.allKeys) {
            id object = [originDic objectForKey:key];
            if ([object isKindOfClass:[NSString class]] || [object isKindOfClass:[NSNumber class]]) {
                //string , bool, int ,NSinteger
                [dic setObject:object forKey:key];
            } else if ([object isKindOfClass:[NSArray class]] || [object isKindOfClass:[NSDictionary class]]) {
                //数组或字典
                [dic setObject:[self arrayOrDicWithObject:object] forKey:key];
            } else {
                //model
                [dic setObject:[self dicFromObject:object] forKey:key];
            }
        }
        return [dic copy];
    }
    return [NSNull null];
}

+ (NSArray *)arrayWithJsonString:(NSString *)jsonString {
    
    if (jsonString == nil) {
        return nil;
    }
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSArray *arr = [NSJSONSerialization JSONObjectWithData:jsonData
                    
                                                   options:NSJSONReadingMutableContainers
                    
                                                     error:&err];
    if(err) {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return arr;
}

#pragma mark - 正则比配URL
+ (BOOL)getUrlLink:(NSString *)link {
    
    NSString *regTags = @"((http[s]{0,1}|ftp|HTTP[S]|FTP|HTTP)://[a-zA-Z0-9\\.\\-]+\\.([a-zA-Z]{2,4})(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)|(((http[s]{0,1}|ftp)://|)((?:(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d)))\\.){3}(?:25[0-5]|2[0-4]\\d|((1\\d{2})|([1-9]?\\d))))(:\\d+)?(/[a-zA-Z0-9\\.\\-~!@#$%^&*+?:_/=<>]*)?)";
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regTags];
    
    BOOL isValid = [predicate evaluateWithObject:link];
    
    return isValid;
}



//判断是否为整形：

+(BOOL)isPureInt:(NSString*)string{

    NSScanner* scan = [NSScanner scannerWithString:string];

    int val;

    return[scan scanInt:&val] && [scan isAtEnd];

}

 

//判断是否为浮点形：

+(BOOL)isPureFloat:(NSString*)string{

    NSScanner* scan = [NSScanner scannerWithString:string];

    float val;

    return[scan scanFloat:&val] && [scan isAtEnd];

}

//+(NSString *)XRBGoldenBeanNum:(double)看{
//    NSString *numString;
////    BOOL intClass = [NSString isPureInt:SDOUBLE(num)];
//     if ([num  floatValue]==[num intValue]){
//        int theNum = num;
//        numString = SINT(theNum);
//    }else{
//        double theNum = num * 100;
//        numString = [NSString stringWithFormat:@"b的值为 %.2f",ceilf(theNum)/100];
//    }
//    return numString;
//}




@end
