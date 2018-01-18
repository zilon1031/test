//
//  ShapeView.m
//  LinkageTableView
//
//  Created by Mac on 2018/1/12.
//  Copyright © 2018年 z. All rights reserved.
//

#import "ShapeView.h"

@implementation ShapeView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        self.layer.cornerRadius = 5;
        self.layer.masksToBounds = YES;
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    //填满整个view
//    UIBezierPath *bezierPath = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:(UIRectCornerTopLeft |UIRectCornerBottomLeft) cornerRadii:CGSizeMake(10, 10)];
//    [[UIColor blackColor] setFill];
//    [bezierPath fill];
    
//    //绘制蓝色圆
//    CGContextRef contextRef = UIGraphicsGetCurrentContext();
//    CGContextAddEllipseInRect(contextRef, CGRectMake(30, 0, 20, 20));
//    CGContextSetFillColorWithColor(contextRef, [UIColor blueColor].CGColor);
//    CGContextFillPath(contextRef);
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(ctx, [UIColor blueColor].CGColor);
    CGContextMoveToPoint(ctx, 0, 0);
    CGContextAddLineToPoint(ctx, self.frame.size.width / 2 - 10, 0);
    CGContextAddLineToPoint(ctx, self.frame.size.width / 2, self.frame.size.height / 2);
    CGContextAddLineToPoint(ctx, self.frame.size.width / 2 - 10, self.frame.size.height);
    CGContextAddLineToPoint(ctx, 0, self.frame.size.height);

    CGContextFillPath(ctx);
  
}

//- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx {
//    CGContextAddEllipseInRect(ctx, self.bounds);
//    CGContextSetFillColorWithColor(ctx, [UIColor yellowColor].CGColor);
//    CGContextFillPath(ctx);
//}
@end
