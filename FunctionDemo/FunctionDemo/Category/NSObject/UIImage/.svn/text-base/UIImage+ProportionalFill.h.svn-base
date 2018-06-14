//
//  UIImage+ProportionalFill.h
//
//  Created by Matt Gemmell on 20/08/2008.
//  Copyright 2008 Instinctive Code.
//

#import <UIKit/UIKit.h>
#import <CoreImage/CoreImage.h>

@interface UIImage (MGProportionalFill)

typedef enum {
    MGImageResizeCrop,	// analogous to UIViewContentModeScaleAspectFill, i.e. "best fit" with no space around.
    MGImageResizeCropStart,
    MGImageResizeCropEnd,
    MGImageResizeScale	// analogous to UIViewContentModeScaleAspectFit, i.e. scale down to fit, leaving space around if necessary.
} MGImageResizingMethod;

- (UIImage *)imageToFitSize:(CGSize)size method:(MGImageResizingMethod)resizeMethod;
- (UIImage *)imageCroppedToFitSize:(CGSize)size; // uses MGImageResizeCrop
- (UIImage *)imageScaledToFitSize:(CGSize)size; // uses MGImageResizeScale
//generate QR code
+ (UIImage *)generateWithDefaultQRCodeData:(NSString *)data imageViewWidth:(CGFloat)imageViewWidth;
+ (UIImage *)generateWithLogoQRCodeData:(NSString *)data logoImageName:(NSString *)logoImageName logoScaleToSuperView:(CGFloat)logoScaleToSuperView;
+ (UIImage *)generateWithColorQRCodeData:(NSString *)data backgroundColor:(CIColor *)backgroundColor mainColor:(CIColor *)mainColor;

- (UIImage *)imageWithCornerRadius:(CGFloat)radius;
@end
