//
//  NSString+EX.h
//  PPBuyer
//
//  Created by sven on 15/4/20.
//  Copyright (c) 2015年 Sven. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreText/CoreText.h>

@interface NSString (EX)

+ (NSString *)UUID;
- (NSDictionary *)queryDictionaryFromString;

+ (NSString *)handleXMLSingle:(NSString *)xmlString;

+ (NSString *)encodeStringWithString:(NSString *)string;

+ (NSString *)manageString:(NSString *)origStr;

- (CGSize)boundingRectWithSize:(CGSize)size font:(UIFont *)font;

+ (CGFloat)heightOfStr:(NSString *)str
                  font:(UIFont *)font
                 width:(CGFloat)width;

+ (CGFloat)widthOfStr:(NSString *)str
                 font:(UIFont *)font
               height:(CGFloat)height;

+ (NSString *)calNSStringWithStar:(NSString *)startStr
                              End:(NSString *)endStr
                          BaseStr:(NSString *)baseStr;

+ (BOOL)isPureNumandCharacters:(NSString *)string;

+ (BOOL)isPureNumaOrCharacters:(NSString *)string;

+ (NSMutableAttributedString *)setStrs:(NSMutableArray *)strArr withColors:(NSMutableArray *)colorArr;

+ (NSArray *)getLinesArrayOfStringInLabel:(NSString *)string font:(UIFont *)font andLableWidth:(CGFloat)lableWidth;

+ (CGFloat)getLineNum:(NSString *)str font:(UIFont *)font labelWidth:(CGFloat)width;

+ (BOOL)isNumAlphaChineseFomatOK:(NSString *)baseStr;

+ (BOOL)stringContainsEmoji:(NSString *)string;

+ (NSString *)getDeviceName;

+ (NSString *)mobileChange:(NSString *)mobile;

+(NSMutableAttributedString *)setStr:(NSString *)textOne oneColor:(UIColor *)oneColor  textTwo:(NSString *)textTwo twoColor:(UIColor *)twoColor maintext:(NSMutableAttributedString *)noteStr;
+(NSString *)compressionReturnStr:(NSString *)baseStr;

// 举报界面单独用
+ (NSArray *)getLinesArrayOfStringInLabelNotMain:(NSString *)string font:(UIFont *)font andLableWidth:(CGFloat)lableWidth;

- (BOOL)includeChinese;

- (BOOL)isChinese;
@end
