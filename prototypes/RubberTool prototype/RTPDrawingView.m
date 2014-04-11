//
//  RTPDrawingView.m
//  Floorball Coach
//
//  Created by Jakub Olejnik on 11/04/2014.
//  Copyright (c) 2014 Jakub Olejník. All rights reserved.
//

#import "RTPDrawingView.h"

@implementation RTPDrawingView
{
    UIBezierPath *_path;
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *someTouch = [touches anyObject];
    CGPoint touchLoc = [someTouch locationInView:self];
    
    _path = [[UIBezierPath alloc] init];
    
    [_path moveToPoint:touchLoc];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *someTouch = [touches anyObject];
    CGPoint touchLoc = [someTouch locationInView:self];
    
    [_path addLineToPoint:touchLoc];
    [self updateMask];
}

- (void)updateMask
{
    /*UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height) cornerRadius:0];
    UIBezierPath *circlePath = _path;
    [path appendPath:circlePath];
    [path setUsesEvenOddFillRule:YES];*/
    
    CGPathRef fixPath = CGPathCreateWithRect(self.bounds, NULL);
    CGPathRef actualPath = CGPathCreateCopyByStrokingPath(_path.CGPath, NULL, 10, kCGLineCapButt, kCGLineJoinMiter, 1);
    CGMutablePathRef path = CGPathCreateMutableCopy(fixPath);
    
    CGPathAddPath(path, NULL, actualPath);
    
    
    CAShapeLayer *fillLayer = [CAShapeLayer layer];
    fillLayer.path = path;
    fillLayer.fillRule = kCAFillRuleEvenOdd;
    fillLayer.fillColor = [UIColor grayColor].CGColor;
    fillLayer.opacity = 1;
    [self.layer setMask:fillLayer];
    
    return;
    
    
    UIBezierPath *fullPath = [UIBezierPath bezierPathWithRect:self.bounds];
    [fullPath appendPath:_path];
    [fullPath setUsesEvenOddFillRule:YES];
    
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    
    [maskLayer setFrame:self.bounds];
    [maskLayer setBackgroundColor:UIColor.blackColor.CGColor];
    [maskLayer setFillRule:kCAFillRuleEvenOdd];
    [maskLayer setFillColor:UIColor.blackColor.CGColor];
    
    [self.layer addSublayer:maskLayer];
    
    [self setNeedsDisplay];
}
@end
