//
//  UIScrollView+Extras
//  closett
//
//  Created by Orlando Aleman Ortiz on 05/02/13.
//  Copyright (c) 2013 Closett. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIScrollView (extras)
- (void)adjustHeightForCurrentSubviews:(int)verticalPadding;
- (void)adjustWidthForCurrentSubviews:(int)horizontalPadding;
- (void)adjustWidth:(bool)changeWidth andHeight:(bool)changeHeight withHorizontalPadding:(int)horizontalPadding andVerticalPadding:(int)verticalPadding;

- (CGRect)centeredFrameForView:(UIView *)rView;
@end
