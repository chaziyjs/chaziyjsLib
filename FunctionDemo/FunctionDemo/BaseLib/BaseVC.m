//
//  BaseVC.m
//  WetalkCommunity
//
//  Created by chaziyjs on 2017/9/15.
//  Copyright © 2017年 chaziyjs. All rights reserved.
//

#import "BaseVC.h"


@interface BaseVC ()

@end

@implementation BaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forBarMetrics:UIBarMetricsDefault];

    if (self.navigationController && self.navigationController.viewControllers.firstObject != self) {
        [self loadBackBtn];
    }
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kUserDidLogin object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginLost:) name:kUserLoginLost object:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

//统一的返回按钮
- (UIButton *)loadBackBtn {
    if (_backbtn == nil) {
        _backbtn = [self loadBackButtonWithTarger:self action:@selector(backClick:)];
    }
    return _backbtn;
}

- (void)backClick:(UIButton *)btn {
    [self hiddenHUD:YES];
    if (self.navigationController.viewControllers.firstObject == self) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark--点击空白收起键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self.view endEditing:YES];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.view endEditing:YES];
    [self hiddenHUD:YES];
}

#pragma mark - 系统登录提示框
- (void)alertLoginWithTitle:(NSString *)title
                    Message:(NSString *)message
                DismissType:(BasePopType)type {
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消"
                                              style:UIAlertActionStyleCancel
                                            handler:^(UIAlertAction *_Nonnull action) {
                                                [alert dismissViewControllerAnimated:YES completion:nil];
                                            }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"去登录"
                                              style:UIAlertActionStyleDefault
                                            handler:^(UIAlertAction *_Nonnull action) {
                                                [self gotoLogin:type];
                                            }]];
    [self presentViewController:alert animated:YES completion:nil];
}

#pragma mark - 登录成功通知回调
- (void)gotoLogin:(BasePopType)type {
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
//    PwdLoginVC *login = [PwdLoginVC new];
//    login.hidesBottomBarWhenPushed = YES;
//    login.type = type;
//    if (type == BasePopType_Root) {
//        login.fromVC = self;
//    } else {
//        login.fromVC = nil;
//    }
//    UINavigationController *nv = [[UINavigationController alloc] initWithRootViewController:login];
//    nv.navigationBar.translucent = NO;
//    [nv.navigationBar setBarTintColor:kColorLightWhite];
//    [self presentViewController:nv
//                       animated:YES
//                     completion:^{
//                         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginSuccess:) name:kUserDidLogin object:nil];
//                     }];
}

#pragma mark - 登录成功
- (void)loginSuccess:(NSNotification *)notice {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserDidLogin object:nil];
}

#pragma mark - 无登录状态 或 掉线
- (void)loginLost:(NSNotification *)notice {
//    [[NSNotificationCenter defaultCenter] removeObserver:self name:kUserLoginLost object:nil];
}

- (void)dealloc {
    FLog(@"%@ dealloc", [self class]);
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
