
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSInteger, PPBarItemPosition)
{
    PPBarItemPosition_left,
    PPBarItemPosition_right,
};

@interface UIViewController (EX)

- (UIButton *)loadItemWithImage:(UIImage *)image HighLightImage:(UIImage *)hlImage target:(id)target action:(SEL)action position:(PPBarItemPosition)position;

- (UIButton *)loadIconWithImage:(UIImage *)image HighLightImage:(UIImage *)hlImage target:(id)target action:(SEL)action position:(PPBarItemPosition)position;


- (UIButton *)loadItemWithTitle:(NSString *)title target:(id)target action:(SEL)action position:(PPBarItemPosition)position;

- (UILabel *)loadTitleWithTitle:(NSString *)title color:(UIColor *)color fontSize:(CGFloat)size;

- (UIButton *)loadBackButtonWithTarger:(id)target action:(SEL)action;

- (UIButton *)loadHelpButtonWithTarget:(id)target action:(SEL)action;

- (void)loadItemWithCustomView:(UIView *)view position:(PPBarItemPosition)position;

- (NSArray *)loadItemTwoImagesWithFirstImage:(UIImage *)firstImage  FirstHighlight:(UIImage *)firstHigh
                                 SecondImage:(UIImage *)secondImage  SecondHighlight:(UIImage *)secondHigh
                                      target:(id)target
                              firstBtnAction:(SEL)firstAction
                             secondBtnAction:(SEL)secondAction
                                    position:(PPBarItemPosition)position;

/**
 顺序从右往左开始

 @param firstImage 最右侧按钮
 @param firstHigh 最右侧按钮
 @param secondImage 中间按钮
 @param secondHigh 中间按钮
 @param thirdImage 最左侧按钮
 @param thirdHigh 最左侧按钮
 @param target 执行人
 @param firstAction 第一个按钮方法
 @param secondAction 第二个按钮方法
 @param thirdAction 第三个按钮方法
 @param position 方位
 @return 所有按钮数组
 */
- (NSArray *)loadItemTwoImagesWithFirstImage:(UIImage *)firstImage  FirstHighlight:(UIImage *)firstHigh
                                 SecondImage:(UIImage *)secondImage  SecondHighlight:(UIImage *)secondHigh
                                  ThirdImage:(UIImage *)thirdImage  ThirdHightlight:(UIImage *)thirdHigh
                                      target:(id)target
                              firstBtnAction:(SEL)firstAction
                             secondBtnAction:(SEL)secondAction
                              thirdBtnAction:(SEL)thirdAction
                                    position:(PPBarItemPosition)position;

- (UIButton *)loadItemWithTitle:(NSString *)title target:(id)target action:(SEL)action position:(PPBarItemPosition)position color:(UIColor *)color;

- (void)loadTitleViewSubView:(UIView *)subView;

@end
