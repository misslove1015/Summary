//
//  ShoopView.m
//  MissSummary
//
//  Created by miss on 2017/7/17.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "ShoopView.h"

@implementation ShoopView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];        
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2) radius:30 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    path.lineWidth = 1.0;
    [[UIColor colorWithRed:255 / 255.0 green:20 / 255.0 blue:20 / 255.0 alpha:1.0] setFill];
    [[UIColor colorWithRed:255 / 255.0 green:0 / 255.0 blue:0 / 255.0 alpha:1.0] setStroke];
    [path stroke];
    [path fill];
}

- (void)animationWithDuraton:(NSTimeInterval)duration {
    [UIView animateWithDuration:duration animations:^{
        self.transform = CGAffineTransformScale(self.transform, 6.5, 6.5);
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        if (self.superview) {
            [self removeFromSuperview];
        }
    }];
}

@end
