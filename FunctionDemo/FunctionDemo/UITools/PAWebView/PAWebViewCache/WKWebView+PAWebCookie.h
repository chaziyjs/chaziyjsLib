//
//  WKWebView+PAWebCookie.h
//  Pkit
//
//  Created by llyouss on 2017/12/28.
//  Copyright © 2017年 llyouss. All rights reserved.
//

#import <WebKit/WebKit.h>

@interface WKWebView (PAWebCookie)

/** ios11 同步cookies */
- (void)syncCookiesToWKHTTPCookieStore:(WKHTTPCookieStore *)cookieStroe API_AVAILABLE(macosx(10.13), ios(11.0));

/** 插入cookies存储于磁盘 */
- (void)insertCookie:(NSHTTPCookie *)cookie;

/** 获取本地磁盘的cookies */
- (void)sharedHTTPCookieStorage:(void (^)(NSMutableArray *cookie_array))cookieArray;

/** 删除所有的cookies */
- (void)clearWKCookies;

/** 删除某一个cookies */
- (void)deleteWKCookie:(NSHTTPCookie *)cookie completionHandler:(nullable void (^)(void))completionHandler;
- (void)deleteWKCookiesByHost:(NSURL *)host completionHandler:(nullable void (^)(void))completionHandler;

/** js获取domain的cookie */
- (void)jsCookieStringWithDomain:(NSString *)domain
                        Callback:(void (^)(NSString *domain))block;
- (void)searchCookieForUserScriptWithDomain:(NSString *)domain
                                 UserScript:(void (^)(WKUserScript *script))block;

/** PHP 获取domain的cookie */
- (void)phpCookieStringWithDomain:(NSString *)domain
                         Callback:(void (^)(NSString *cookieSting))block;


@end
