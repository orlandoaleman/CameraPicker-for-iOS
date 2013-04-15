//
//  UIScrollView+Extras
//  closett
//
//  Created by Orlando Aleman Ortiz on 05/02/13.
//  Copyright (c) 2013 Closett. All rights reserved.
//

#import "UIScrollView+Extras.h"

@implementation UIScrollView (extras)

- (void)adjustWidth:(bool)changeWidth andHeight:(bool)changeHeight withHorizontalPadding:(int)horizontalPadding andVerticalPadding:(int)verticalPadding
{
    float contentWidth = horizontalPadding;
    float contentHeight = verticalPadding;
    for (UIView *subview in self.subviews) {
        [subview sizeToFit];
        contentWidth += subview.frame.size.width;
        contentHeight += subview.frame.size.height;
    }

    contentWidth = changeWidth ? contentWidth : self.superview.frame.size.width;
    contentHeight = changeHeight ? contentHeight : self.superview.frame.size.height;

    self.contentSize = CGSizeMake(contentWidth, contentHeight);
}


- (void)adjustHeightForCurrentSubviews:(int)verticalPadding
{
    [self adjustWidth:NO andHeight:YES withHorizontalPadding:0 andVerticalPadding:verticalPadding];
}

- (void)adjustWidthForCurrentSubviews:(int)horizontalPadding
{
    [self adjustWidth:YES andHeight:NO withHorizontalPadding:horizontalPadding andVerticalPadding:0];
}


- (CGRect)centeredFrameForView:(UIView *)rView;
{
    CGSize boundsSize = self.bounds.size;
    CGRect frameToCenter = rView.frame;
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width) {
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    }
    else {
        frameToCenter.origin.x = 0;
    }
    // center vertically
    if (frameToCenter.size.height < boundsSize.height) {
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    }
    else {
        frameToCenter.origin.y = 0;
    }
    return frameToCenter;
}
@end