//
//  ViewController.m
//  FunctionDemo
//
//  Created by chaziyjs on 2018/4/8.
//  Copyright © 2018年 chaziyjs. All rights reserved.
//

#import "ViewController.h"
#import "RegexKitLite.h"
#import "DXZNetworkAPI/DXZRequest.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    _objects = @"123";
//    self.test = [TestObject new];
//    NSMutableArray *array = [NSMutableArray arrayWithObjects:@"1", @"2", @"3", nil];
//    [array removeObjectAtIndex:3];
//    FLog(@"%@", [array objectAtIndex:3]);
//    // Do any additional setup after loading the view, typically from a nib.
//    NSString *html_str = @"<p style=\"text-align: center;\" align=\"center\"><img src=\"http://voucherimage.wetalk1948.com/detailsimg/8ddc76eb-f91e-41bd-98cc-01a46c8db7e5.png\" alt=\"商家特色\" style=\"max-width:100%;\" class=\"\"><br></p><p style=\"text-align: center;\" align=\"center\"><br></p><p style=\"text-align: center;\" align=\"center\"><img src=\"http://voucherimage.wetalk1948.com/detailsimg/13759848-2b3d-4d5c-b88f-089ecce8b863.jpg\" alt=\"微信图片_20171211104835\" style=\"max-width:100%;\" class=\"\"><br></p><p style=\"text-align: center;\" align=\"center\"><br></p><p style=\"text-align: center;\" align=\"center\">鲜排骨焖面&nbsp; &nbsp;97元/份</p><p style=\"text-align: center;\" align=\"center\">排骨酥嫩软烂，芸豆清新可口，面条浓郁美味</p><p style=\"text-align: center;\" align=\"center\"><br></p><p style=\"text-align: center;\" align=\"center\"><img src=\"http://voucherimage.wetalk1948.com/detailsimg/959aa66a-642e-4c24-af62-77b11ce056a2.jpg\" alt=\"微信图片_20171211104839\" style=\"max-width:100%;\" class=""><br></p><p style=\"text-align: center;\" align=\"center\"><br></p><p style=\"text-align: center;\" align=\"center\">鲜牛腩焖面&nbsp; &nbsp;98元/份</p><p style=\"text-align: center;\" align=\"center\">牛腩新鲜入味，面条香滑劲道，配菜丰富清香</p><p style=\"text-align: center;\" align=\"center\"><br></p><p style=\"text-align: center;\" align=\"center\"><img src=\"http://voucherimage.wetalk1948.com/detailsimg/cf07ba00-6b99-4c75-9e01-b96c5e961153.jpg\" alt=\"微信图片_20171211104843\" style=\"max-width:100%;\" class=\"\"><br></p><p style=\"text-align: center;\" align=\"center\"><br></p><p style=\"text-align: center;\" align=\"center\">大连海鲜焖面&nbsp; &nbsp;98元/份</p><p style=\"text-align: center;\" align=\"center\">海鲜味道鲜美，面条嚼劲十足，一锅尽是精华</p><p style=\"text-align: center;\" align=\"center\"><br></p><p><img src=\"http://voucherimage.wetalk1948.com/detailsimg/a3546baa-3926-4344-b40f-54da8c8eabd1.png\" alt=\"用餐环境\" style=\"max-width:100%;\" class=\"\"><br></p><p><br></p><p><img src=\"http://voucherimage.wetalk1948.com/detailsimg/7e3b8006-62db-4f11-9d75-0f65367a669b.jpg\" alt=\"微信图片_20171211104805\" style=\"max-width:100%;\"><br></p><p><img src=\"http://voucherimage.wetalk1948.com/detailsimg/92420f0c-bf4c-4f14-ac74-06ed5705011f.jpg\" alt=\"微信图片_20171211104816\" style=\"max-width:100%;\"><br></p><p><img src=\"http://voucherimage.wetalk1948.com/detailsimg/f69e2066-485c-43e9-a908-d7e002bcf8bc.jpg\" alt=\"微信图片_20171211104828\" style=\"max-width:100%;\"><br></p><p><br></p><p><img src=\"http://voucherimage.wetalk1948.com/detailsimg/5f20cca3-5d35-4226-b658-eee2ba97c607.png\" alt=\"使用说明\" style=\"max-width:100%;\" class=\"\"><br></p><p><br></p><p>焖尚铁锅焖面68元代金券一张</p><p>有效期：购买之日起45天有效</p><p>使用时间：10:00-21:00（周末节假日通用）</p><p>使用规则：</p><p>（1）持本券可抵值68元，除酒水外全场通用</p><p>（2）到店消费满120元可使用代金券，商家谢绝自带酒水</p><p>（3）每桌每次限用1张，不可叠加使用（包括同行分桌及拼桌叠加）</p><p>（4）仅限堂食，不提供餐前外带服务，餐毕如未吃完可打包，打包费详询商家</p><p>（5）仅限大厅使用，店内无包间</p><p>（6）菜品图及价格仅供参考</p><p>（7）本券不兑现，不与店内其他优惠同享</p><p>（8）本券支持随时可退及过期自动退业务，退券将以账户余额的形式退回到会购账户中。</p><p><br></p>";
//    NSString *regTags = @"<img[^>]+src\\s*=\\s*['\"]([^'\"]+)['\"][^>]*>";
//    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regTags
//                                                                           options:NSRegularExpressionCaseInsensitive    // 还可以加一些选项，例如：不区分大小写
//                                                                             error:nil];
//    NSArray *match = [regex matchesInString:html_str options:0 range:NSMakeRange(0, [html_str length])];
//    FLog(@"match result = %@", match);
//    if (match.count != 0)
//    {
//        NSMutableString *_targetImageHtml;
//        for (NSTextCheckingResult *matc in match)
//        {
//            NSRange range = [matc range];
//
//            //原图片img的html
//            NSString *_tmpString = [html_str substringWithRange:range];
//            NSString *_regEx = @"<img[^>]+src=['\"](.*?)['\"][^>]*>";
//            NSString *_keyString = [_tmpString stringByReplacingOccurrencesOfRegex:_regEx withString:@"$1"];
//            FLog(@"_tmpString = %@", _tmpString);
//            if (![_keyString hasPrefix:@"http://"]) {
//
//                //新url
//                _targetImageHtml = [NSMutableString stringWithFormat:@"<img src='%@/atth/m/%@_0_15.png' />", _apiUrl, _keyString];
//
//                //替换url
//                text = [text stringByReplacingOccurrencesOfString:_tmpString withString:[NSString stringWithFormat:@"%@ ", _targetImageHtml]];
//            }else{
//
//                _targetImageHtml = [NSMutableString stringWithFormat:@"<img src='%@' />",  _keyString];
//                text = [text stringByReplacingOccurrencesOfString:_tmpString withString:[NSString stringWithFormat:@"%@ ", _targetImageHtml]];
//            }
//        }
//    }
//    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
//    [web loadHTMLString:html_str baseURL:nil];
//    [self.view addSubview:web];
    
//    UIView *seq_view = [[UIView alloc] initWithFrame:CGRectMake(100, 100, 100, 100)];
//    seq_view.backgroundColor = [UIColor redColor];
//    [seq_view drawRoundRectInContextWithRadius:8.f corners:UIRectCornerAllCorners];
//    [self.view addSubview:seq_view];
//
//    TestObject *obj = [TestObject new];
//    [obj setValue:self forKey:@"Number"];
//    [obj performSelectorOnMainThread:@selector(uiojo) withObject:nil waitUntilDone:YES];
//    NSLog(@"%@", [obj valueForKey:@"Number"]);
//    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
//    [dict setValue:[NSValue valueWithNonretainedObject:self] forKey:@"Controller"];
//    [dict setValue:NSStringFromSelector(@selector(KVOListen)) forKey:NSStringFromClass([self class])];
//    NSLog(@"dict = %@", dict);
//    for (NSString *keys in dict.allKeys) {
////        Class class = NSClassFromString(keys);
////        SEL sel = NSSelectorFromString(dict[keys]);
////        [class performSelector:sel withObject:nil afterDelay:0];
//        if ([keys isEqualToString:@"Controller"]) {
//            NSValue *controllerValue = [dict valueForKey:keys];
//            UIViewController *viewController = (UIViewController *)controllerValue.nonretainedObjectValue;
//        }
//    }
//    [self KVOListen];
//    [self AdViewBuild];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.bounds = CGRectMake(0, 0, 100, 30);
    btn.center = CGPointMake(CGRectGetWidth(self.view.frame) * 0.5, CGRectGetHeight(self.view.frame) * 0.5);
    [btn addTarget:self action:@selector(showAlert) forControlEvents:UIControlEventTouchUpInside];
    [btn setTitle:@"Touch" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.view addSubview:btn];
    
    [DXZRequest requestWithURL:@"api/a/apple/appleGoodsList.json" param:nil requestMethod:DXZRequestMethodPOST ComletionBlockWithSuccess:^(__kindof DXZBaseRequest * _Nonnull request) {
        NSLog(@"success = %@", request.responseJSONObject);
    } failure:^(__kindof DXZBaseRequest * _Nonnull request) {
        NSLog(@"failure = %@", request.error);
    }];
}

- (void)showAlert
{
    PayAlertView *alert = [PayAlertView payAlertWithTitle:@"asdffdsdsfdsafdsfdsfdas" Message:@"asdfdsfdsadsfsdfsdfdsfsdfsdfsdf" Image:nil ImageSize:CGSizeZero AlertStyle:PayAlertWithoutImage];
    [alert addAction:[PayAlertAction actionWithTitle:@"确认" Style:PayAlertActionDefine Action:^(PayAlertAction *action) {
        [alert payAlertViewDismissComplete:nil];
    }]];
    [alert addAction:[PayAlertAction actionWithTitle:@"关闭" Style:PayAlertActionCancel Action:^(PayAlertAction *action) {
        [alert payAlertViewDismissComplete:nil];
    }]];
    [alert payAlertViewPresentComplete:nil];
}

- (void)KVOListen
{
    //自动监听
//    NSLog(@"before object address = %s", );
//    [self addObserver:self forKeyPath:@"objects" options:NSKeyValueObservingOptionNew context:NULL];
    // 手动监听
//    [self willChangeValueForKey:@"objects"];
//    _objects = @"{";
//    [self didChangeValueForKey:@"objects"];
        [self addObserver:self forKeyPath:@"test" options:NSKeyValueObservingOptionNew context:NULL];
    NSLog(@"after object address");
//    _test.userName = @"test";
    
}

- (void)AdViewBuild
{
    AdListView *adView = [[AdListView alloc] initWithFrame:CGRectMake(0, 64.f, kScreenWidth, 100.f)];
    [self.view addSubview:adView];
    
    
}


//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    ScrollViewController *scrollTest = [ScrollViewController new];
//    [self presentViewController:scrollTest animated:YES completion:nil];
//}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context
{
    NSLog(@"keypath = %@ \n change = %@", keyPath, object);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [self removeObserver:self forKeyPath:@"objects"];
}

@end
