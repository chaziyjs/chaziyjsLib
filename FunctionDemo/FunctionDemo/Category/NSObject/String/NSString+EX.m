//
//  NSString+EX.m
//  PPBuyer
//
//  Created by sven on 15/4/20.
//  Copyright (c) 2015年 Sven. All rights reserved.
//

#import "NSString+EX.h"
#import "sys/utsname.h"

@implementation NSString (EX)

+ (NSString *)UUID {
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidString = (NSString *) CFBridgingRelease(CFUUIDCreateString(kCFAllocatorDefault, uuid));
    CFRelease(uuid);
    return uuidString;
}

- (NSDictionary *)queryDictionaryFromString {
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    NSArray *components = [self componentsSeparatedByString:@"&"];
    for (NSString *component in components) {
        NSArray *keyAndValues = [component componentsSeparatedByString:@"="];
        [parameters setObject:[keyAndValues objectAtIndex:1] forKey:[[keyAndValues objectAtIndex:0] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    }
    return parameters;
}

+ (NSString *)encodeStringWithString:(NSString *)string
{
    return (NSString *)CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,(CFStringRef)string, (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]", NULL, kCFStringEncodingUTF8));
}

+ (NSString *)handleXMLSingle:(NSString *)xmlString
{
    xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    xmlString = [xmlString stringByReplacingOccurrencesOfString:@"&#39;" withString:@"\'"];
    xmlString = [xmlString stringByReplacingOccurrencesOfString:@"\\n" withString:@"\n"];
    return xmlString;
}

#pragma mark - 字符串处理
+ (NSString *)manageString:(NSString *)origStr
{
    NSString *newStr = [NSString stringWithFormat:@"%@",origStr];
    newStr = [newStr stringByReplacingOccurrencesOfString:@" " withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newStr = [newStr stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    return newStr;
}

#pragma mark - 获取字符串自适应后所占高度
+ (CGFloat)heightOfStr:(NSString *)str
                  font:(UIFont *)font
                 width:(CGFloat)width {
    CGSize rect;
    NSDictionary *dic = @{NSFontAttributeName : font};
    rect = [str boundingRectWithSize:CGSizeMake(width, 10000)
                             options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                          attributes:dic
                             context:nil]
    .size;
    
    return rect.height;
}

#pragma mark - 获取文字高度
+ (CGFloat)heightWithText:(NSString *)text font:(UIFont *)font constrainedToWidth:(CGFloat)width
{
    CFMutableAttributedStringRef attrString = CFAttributedStringCreateMutable(kCFAllocatorDefault,0);
    CFAttributedStringReplaceString (attrString,CFRangeMake(0,0), (CFStringRef) text);
    CFIndex stringLength = CFStringGetLength((CFStringRef) attrString);
    // Change font
    CTFontRef ctFont = CTFontCreateWithName((__bridge CFStringRef) font.fontName, font.pointSize,NULL);
    CFAttributedStringSetAttribute(attrString, CFRangeMake(0, stringLength), kCTFontAttributeName, ctFont);
    
    // Calc the size
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString(attrString);
    CFRange fitRange;
    CGSize frameSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, stringLength), NULL, CGSizeMake(width, CGFLOAT_MAX), &fitRange);
    CFRelease(ctFont);
    CFRelease(framesetter);
    CFRelease(attrString);
    return frameSize.height;
}

#pragma mark - 获取字符串自适应后所占宽度
+ (CGFloat)widthOfStr:(NSString *)str
                 font:(UIFont *)font
               height:(CGFloat)height {
    CGSize rect;
    NSDictionary *dic = @{NSFontAttributeName : font};
    rect = [str boundingRectWithSize:CGSizeMake(10000, height)
                             options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                          attributes:dic
                             context:nil]
    .size;
    
    return rect.width;
}

- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font {
    NSDictionary *attribute = @{NSFontAttributeName : font};
    
    CGSize retSize = [self boundingRectWithSize:size
                                        options:
                      NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:attribute
                                        context:nil]
    .size;
    
    return retSize;
}

#pragma mark - 判断字符串是不是纯数字
+ (BOOL)isPureNumandCharacters:(NSString *)string {
    string = [string stringByTrimmingCharactersInSet:[NSCharacterSet decimalDigitCharacterSet]];
    if (string.length > 0) {
        return NO;
    }
    return YES;
}

#pragma mark - 判断字符串是不是只由数字字母符号组成
+ (BOOL)isPureNumaOrCharacters:(NSString *)string {
    for (int i = 0; i < [string length]; ++i) {
        int a = [string characterAtIndex:i];
        if (!isnumber(a) && !isalpha(a) && !ispunct(a)) {
            return NO;
        } else {
            continue;
        }
    }
    return YES;
}

#pragma mark--截取字符串中指定两个字符之间的字符串
+ (NSString *)calNSStringWithStar:(NSString *)startStr End:(NSString *)endStr BaseStr:(NSString *)baseStr {
    
    NSRange start = [baseStr rangeOfString:startStr];
    NSRange end = [baseStr rangeOfString:endStr];
    NSString *sub = [baseStr substringWithRange:NSMakeRange(start.location + 1, end.location - start.location - 1)];
    return sub;
}

#pragma mark--不同颜色字符串拼接
/**
 拼接字符串
 ※字符串数组元素个数与颜色数组元素个数必须匹配
 @param strArr 字符串数组
 @param colorArr 单颜色数组
 @return 组合后拼接字符串
 */
+ (NSMutableAttributedString *)setStrs:(NSMutableArray *)strArr withColors:(NSMutableArray *)colorArr {
    //异常处理
    if (strArr.count != colorArr.count) {
        NSString *strErr = @"字符串数组与颜色数组不匹配";
        NSMutableAttributedString *attributedStrErr = [[NSMutableAttributedString alloc] initWithString:strErr];
        NSRange redRange = NSMakeRange(0, strErr.length);
        [attributedStrErr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:redRange];
        return attributedStrErr;
    }
    
    NSMutableAttributedString *resultStr = [[NSMutableAttributedString alloc] init];
    for (int i = 0; i < [strArr count]; i++) {
        if ([[strArr objectAtIndex:i] isKindOfClass:[NSString class]] && [[colorArr objectAtIndex:i] isKindOfClass:[UIColor class]]) {
            NSString *strNSTemp = [NSString stringWithFormat:@"%@", [strArr objectAtIndex:i]];
            NSRange colorRange = NSMakeRange(0, strNSTemp.length);
            UIColor *colorTemp = (UIColor *) [colorArr objectAtIndex:i];
            NSMutableAttributedString *strNSAttribuTemp = [[NSMutableAttributedString alloc] initWithString:strNSTemp];
            [strNSAttribuTemp addAttribute:NSForegroundColorAttributeName value:colorTemp range:colorRange];
            [resultStr appendAttributedString:strNSAttribuTemp];
        }
    }
    return resultStr;
}


+ (NSArray *)getLinesArrayOfStringInLabel:(NSString *)string font:(UIFont *)font andLableWidth:(CGFloat)lableWidth
{
    
    NSString *sub_str = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:sub_str];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,lableWidth,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [string substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}


// 举报界面单独用
+ (NSArray *)getLinesArrayOfStringInLabelNotMain:(NSString *)string font:(UIFont *)font andLableWidth:(CGFloat)lableWidth
{
    CTFontRef myFont = CTFontCreateWithName(( CFStringRef)([font fontName]), [font pointSize], NULL);
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:string];
    [attStr addAttribute:(NSString *)kCTFontAttributeName value:(__bridge  id)myFont range:NSMakeRange(0, attStr.length)];
    CFRelease(myFont);
    CTFramesetterRef frameSetter = CTFramesetterCreateWithAttributedString(( CFAttributedStringRef)attStr);
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0,0,lableWidth,100000));
    CTFrameRef frame = CTFramesetterCreateFrame(frameSetter, CFRangeMake(0, 0), path, NULL);
    NSArray *lines = ( NSArray *)CTFrameGetLines(frame);
    NSMutableArray *linesArray = [[NSMutableArray alloc]init];
    for (id line in lines) {
        CTLineRef lineRef = (__bridge  CTLineRef )line;
        CFRange lineRange = CTLineGetStringRange(lineRef);
        NSRange range = NSMakeRange(lineRange.location, lineRange.length);
        NSString *lineString = [string substringWithRange:range];
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithFloat:0.0]));
        CFAttributedStringSetAttribute((CFMutableAttributedStringRef)attStr, lineRange, kCTKernAttributeName, (CFTypeRef)([NSNumber numberWithInt:0.0]));
        [linesArray addObject:lineString];
    }
    
    CGPathRelease(path);
    CFRelease( frame );
    CFRelease(frameSetter);
    return (NSArray *)linesArray;
}

/**
 计算行数
 
 @param str 传入的字符串
 @param font 字体
 @param width label宽度
 @return 行数
 */
+ (CGFloat)getLineNum:(NSString *)str font:(UIFont *)font labelWidth:(CGFloat)width {
    if (str.length < 1) {
        return 0;
    }
    CGFloat oneRowHeight = [@"占位" sizeWithAttributes:@{NSFontAttributeName : font}].height;
    CGSize textSize = [str boundingRectWithSize:CGSizeMake(width, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font } context:nil].size;
    CGFloat rows = textSize.height / oneRowHeight;
    
    return rows;
}

/**
 判断字符串是否只由数字字母汉字组成
 
 @param baseStr 基字符串
 @return BOOL 是||否
 */
+ (BOOL)isNumAlphaChineseFomatOK:(NSString *)baseStr {
    for (int i = 0; i < [(NSString *) baseStr length]; ++i) {
        
        int a = [(NSString *) baseStr characterAtIndex:i];
        if (isnumber(a) || isalpha(a) || (a >= 0x4e00 && a <= 0x9fa5)) {
            continue;
        } else {
            return NO;
        }
    }
    return YES;
}

#pragma mark - 判断是否为系统表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}

// 获取设备型号然后手动转化为对应名称
+ (NSString *)getDeviceName {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *deviceString = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([deviceString isEqualToString:@"iPhone3,1"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,2"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone3,3"]) return @"iPhone 4";
    if ([deviceString isEqualToString:@"iPhone4,1"]) return @"iPhone 4S";
    if ([deviceString isEqualToString:@"iPhone5,1"]) return @"iPhone 5";
    if ([deviceString isEqualToString:@"iPhone5,2"]) return @"iPhone 5 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone5,3"]) return @"iPhone 5c (GSM)";
    if ([deviceString isEqualToString:@"iPhone5,4"]) return @"iPhone 5c (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone6,1"]) return @"iPhone 5s (GSM)";
    if ([deviceString isEqualToString:@"iPhone6,2"]) return @"iPhone 5s (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    if ([deviceString isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    if ([deviceString isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    if ([deviceString isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    if ([deviceString isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    // 日行两款手机型号均为日本独占，可能使用索尼FeliCa支付方案而不是苹果支付
    if ([deviceString isEqualToString:@"iPhone9,1"]) return @"国行、日版、港行iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,2"]) return @"港行、国行iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone9,3"]) return @"美版、台版iPhone 7";
    if ([deviceString isEqualToString:@"iPhone9,4"]) return @"美版、台版iPhone 7 Plus";
    if ([deviceString isEqualToString:@"iPhone10,1"]) return @"国行(A1863)、日行(A1906)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,4"]) return @"美版(Global/A1905)iPhone 8";
    if ([deviceString isEqualToString:@"iPhone10,2"]) return @"国行(A1864)、日行(A1898)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,5"]) return @"美版(Global/A1897)iPhone 8 Plus";
    if ([deviceString isEqualToString:@"iPhone10,3"]) return @"国行(A1865)、日行(A1902)iPhone X";
    if ([deviceString isEqualToString:@"iPhone10,6"]) return @"美版(Global/A1901)iPhone X";
    
    if ([deviceString isEqualToString:@"iPod1,1"]) return @"iPod Touch 1G";
    if ([deviceString isEqualToString:@"iPod2,1"]) return @"iPod Touch 2G";
    if ([deviceString isEqualToString:@"iPod3,1"]) return @"iPod Touch 3G";
    if ([deviceString isEqualToString:@"iPod4,1"]) return @"iPod Touch 4G";
    if ([deviceString isEqualToString:@"iPod5,1"]) return @"iPod Touch (5 Gen)";
    
    if ([deviceString isEqualToString:@"iPad1,1"]) return @"iPad";
    if ([deviceString isEqualToString:@"iPad1,2"]) return @"iPad 3G";
    if ([deviceString isEqualToString:@"iPad2,1"]) return @"iPad 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,2"]) return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,3"]) return @"iPad 2 (CDMA)";
    if ([deviceString isEqualToString:@"iPad2,4"]) return @"iPad 2";
    if ([deviceString isEqualToString:@"iPad2,5"]) return @"iPad Mini (WiFi)";
    if ([deviceString isEqualToString:@"iPad2,6"]) return @"iPad Mini";
    if ([deviceString isEqualToString:@"iPad2,7"]) return @"iPad Mini (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,1"]) return @"iPad 3 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,2"]) return @"iPad 3 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad3,3"]) return @"iPad 3";
    if ([deviceString isEqualToString:@"iPad3,4"]) return @"iPad 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad3,5"]) return @"iPad 4";
    if ([deviceString isEqualToString:@"iPad3,6"]) return @"iPad 4 (GSM+CDMA)";
    if ([deviceString isEqualToString:@"iPad4,1"]) return @"iPad Air (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,2"]) return @"iPad Air (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,4"]) return @"iPad Mini 2 (WiFi)";
    if ([deviceString isEqualToString:@"iPad4,5"]) return @"iPad Mini 2 (Cellular)";
    if ([deviceString isEqualToString:@"iPad4,6"]) return @"iPad Mini 2";
    if ([deviceString isEqualToString:@"iPad4,7"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,8"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad4,9"]) return @"iPad Mini 3";
    if ([deviceString isEqualToString:@"iPad5,1"]) return @"iPad Mini 4 (WiFi)";
    if ([deviceString isEqualToString:@"iPad5,2"]) return @"iPad Mini 4 (LTE)";
    if ([deviceString isEqualToString:@"iPad5,3"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad5,4"]) return @"iPad Air 2";
    if ([deviceString isEqualToString:@"iPad6,3"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,4"]) return @"iPad Pro 9.7";
    if ([deviceString isEqualToString:@"iPad6,7"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,8"]) return @"iPad Pro 12.9";
    if ([deviceString isEqualToString:@"iPad6,11"]) return @"iPad 5 (WiFi)";
    if ([deviceString isEqualToString:@"iPad6,12"]) return @"iPad 5 (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,1"]) return @"iPad Pro 12.9 inch 2nd gen (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,2"]) return @"iPad Pro 12.9 inch 2nd gen (Cellular)";
    if ([deviceString isEqualToString:@"iPad7,3"]) return @"iPad Pro 10.5 inch (WiFi)";
    if ([deviceString isEqualToString:@"iPad7,4"])     return @"iPad Pro 10.5 inch (Cellular)";
    
    if ([deviceString isEqualToString:@"AppleTV2,1"])    return @"Apple TV 2";
    if ([deviceString isEqualToString:@"AppleTV3,1"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV3,2"])    return @"Apple TV 3";
    if ([deviceString isEqualToString:@"AppleTV5,3"])    return @"Apple TV 4";
    
    if ([deviceString isEqualToString:@"i386"])         return @"Simulator";
    if ([deviceString isEqualToString:@"x86_64"])       return @"Simulator";
    
    return deviceString;
}

- (BOOL)isChinese
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}

- (BOOL)includeChinese
{
    for(int i = 0; i < [self length]; i++)
    {
        int a = [self characterAtIndex:i];
        if(a > 0x4e00 && a < 0x9fff){
            return YES;
        }
    }
    return NO;
}

/**
 电话号码 中间4位变*
 
 @param mobile 电话号码
 @return 变*后的电话号码
 */
+ (NSString *)mobileChange:(NSString *)mobile{
    
    NSString *strMobile=[mobile stringByReplacingCharactersInRange:NSMakeRange(3,4) withString:@"****"];
    
    return strMobile;
    
}

+(NSMutableAttributedString *)setStr:(NSString *)textOne oneColor:(UIColor *)oneColor  textTwo:(NSString *)textTwo twoColor:(UIColor *)twoColor maintext:(NSMutableAttributedString *)noteStr{
    
    NSRange redRange = NSMakeRange([[noteStr string] rangeOfString:textOne].location, [[noteStr string] rangeOfString:textOne].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:oneColor range:redRange];
    
    NSRange redRangeTwo = NSMakeRange([[noteStr string] rangeOfString:textTwo].location, [[noteStr string] rangeOfString:textTwo].length);
    [noteStr addAttribute:NSForegroundColorAttributeName value:twoColor range:redRangeTwo];
    
    return noteStr;
}

+(NSString *)compressionReturnStr:(NSString *)baseStr{
    return  [[NSString handleXMLSingle:baseStr] stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
}

@end
