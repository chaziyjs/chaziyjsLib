//
//  ScrollViewController.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/6/12.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController () {
    
    UIView *titleView;
    UIScrollView *subScrollView;
    
}

@property (nonatomic, strong) SubTableView *table_1;
@property (nonatomic, strong) SubTableView *table_2;

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self buildMainView];
}

- (void)buildMainView
{
    self.backScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
    self.backScrollView.contentSize = CGSizeMake(kScreenWidth, kScreenHeight + 200.f);
    self.backScrollView.backgroundColor = [UIColor whiteColor];
    self.backScrollView.delegate = self;
    [self.view addSubview:self.backScrollView];
    
    titleView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 200.f)];
    titleView.backgroundColor = [UIColor orangeColor];
    [self.backScrollView addSubview:titleView];
    
    subScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 200.f, kScreenWidth, kScreenHeight)];
    subScrollView.contentSize = CGSizeMake(kScreenWidth * 2, kScreenHeight);
    subScrollView.delegate = self;
    subScrollView.pagingEnabled = YES;
    subScrollView.bounces = NO;
    [self.backScrollView addSubview:subScrollView];
    
    _table_1 = [[SubTableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _table_1.backgroundColor = [UIColor grayColor];
    [subScrollView addSubview:_table_1];
    
    _table_2 = [[SubTableView alloc] initWithFrame:CGRectMake(kScreenWidth, 0, kScreenWidth, kScreenHeight) style:UITableViewStylePlain];
    _table_2.backgroundColor = [UIColor blueColor];
    [subScrollView addSubview:_table_2];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if ([scrollView isEqual:subScrollView]) {
        self.table_1.scrollEnabled = NO;
        self.table_2.scrollEnabled = NO;
    }
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    if ([scrollView isEqual:subScrollView]) {
        self.table_1.scrollEnabled = YES;
        self.table_2.scrollEnabled = YES;
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    if ([scrollView isEqual:self.backScrollView]) {
        if (scrollView.contentOffset.y >= 200) {
//            if (self.table_1.contentOffset.y != 0) {
//                return;
//            }
            [scrollView setContentOffset:CGPointMake(0, 200)];
        } else {
//            if (self.table_1.contentOffset.y != 0) {
//                [scrollView setContentOffset:CGPointMake(0, 200)];
//            } else {
//            }
            if (_backScrollView.contentOffset.y > 0 && self.table_1.contentOffset.y != 0) {
                [_backScrollView setContentOffset:CGPointMake(0, 200)];
            } else {
                [self.table_1 setContentOffset:CGPointMake(0, 0)];
                [self.table_2 setContentOffset:CGPointMake(0, 0)];
            }
        }
    }
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    return YES;
}







- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
