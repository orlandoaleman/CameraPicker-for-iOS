//
//
// -----------------------------------------------
// From cscade on iphonedevbook.com forums
// And Bjorn Sallarp on blog.sallarp.com
// -----------------------------------------------
//

@interface UIImage (Extras)

+ (UIImage *)imageWithColor:(UIColor *)color;

- (UIImage *)imageByScalingAndCroppingForSize:(CGSize)targetSize;

/// Set the image orientation to portrait
- (UIImage *)fixOrientation;

@end