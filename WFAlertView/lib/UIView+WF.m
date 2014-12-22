//
//  UIView+WF.m
//  Craigslist
//
//  Created by jwfstars on 14-10-13.
//  Copyright (c) 2014年 HuQingyu. All rights reserved.
//

#import "UIView+WF.h"

@implementation UIView (WF)
- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setWidthOfView:(CGFloat)widthOfView
{
    CGRect frame = self.frame;
    frame.size.width = widthOfView;
    self.frame = frame;
}

- (CGFloat)widthOfView
{
    return self.frame.size.width;
}

- (void)setHeightOfView:(CGFloat)heightOfView
{
    CGRect frame = self.frame;
    frame.size.height = heightOfView;
    self.frame = frame;
}

- (CGFloat)heightOfView
{
    return self.frame.size.height;
}

- (void)setSize:(CGSize)size
{
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOrigin:(CGPoint)origin
{
    CGRect frame = self.frame;
    frame.origin = origin;
    self.frame = frame;
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGFloat)centerX
{
    return self.center.x;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}
@end
