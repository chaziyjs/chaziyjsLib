//
//  SubTableView.h
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/12.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface SubTableView : UITableView<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSNumber *type;


@end
