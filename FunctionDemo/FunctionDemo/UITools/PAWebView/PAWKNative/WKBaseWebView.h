//
//  WKBaseWebView.h
//  Pkit
//
//  Created by llyouss on 2017/12/15.
//  Copyright © 2017年 llyouss. All rights reserved.
//

#import "BaseVC.h"

@interface WKBaseWebView : BaseVC

//@property (nonatomic, strong) UIBarButtonItem *backItem;   //返回按钮
//@property (nonatomic, strong) UIBarButtonItem *closeItem;  //关闭按钮

/* 实现单例网页从此初始位置退出 */
@property (nonatomic, assign) NSInteger previousIndex;

@end


