//
//  MSCircleProgressView.m
//  MissSummary
//
//  Created by miss on 2017/7/24.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "MSCircleProgressView.h"

CGFloat const lineWidth = 5;

@interface MSCircleProgressView()

@property (nonatomic, strong) CAShapeLayer      *backgroundLine;
@property (nonatomic, strong) CAShapeLayer      *progressLine;
@property (nonatomic, strong) CAGradientLayer   *grain;
@property (nonatomic, strong) UILabel           *percentLabel;
@property (nonatomic, strong) CADisplayLink     *link;
@property (nonatomic, assign) NSInteger         progressNumber;

@end

@implementation MSCircleProgressView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setLayer];
        [self addSubview:self.percentLabel];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setLayer];
        [self addSubview:self.percentLabel];
    }
    return self;
}

- (void)setLayer {
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2)
                                                        radius:self.bounds.size.width/2 - lineWidth
                                                    startAngle:M_PI_2
                                                      endAngle:M_PI_2 + M_PI*2
                                                     clockwise:YES];
    self.backgroundLine.path = path.CGPath;
    self.progressLine.path = path.CGPath;
    [self.layer addSublayer:self.backgroundLine];
    [self.layer addSublayer:self.progressLine];
    [self.grain setMask:self.progressLine];

}

- (void)setPercent:(NSInteger)percent {
    _percent = percent;
    CABasicAnimation *pathAnima = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnima.duration = percent/60.f;
    pathAnima.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    pathAnima.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnima.toValue = [NSNumber numberWithFloat:percent/100.f];
    pathAnima.fillMode = kCAFillModeForwards;
    pathAnima.removedOnCompletion = NO;
    
    [self.progressLine addAnimation:pathAnima forKey:@"strokeEndAnimation"];
    
    self.link.paused = NO;

//    self.progressLine.strokeStart = 0.f;
//    self.progressLine.strokeEnd = percent/100.f;
}

- (void)animateprecent{
    if (self.progressNumber < self.percent) {
        self.progressNumber ++;
        self.percentLabel.text = [NSString stringWithFormat:@"%ld%%",self.progressNumber];
    }else{
        self.link.paused = YES;
        [self.link invalidate];
        self.link = nil;
        self.progressNumber = 0;
    }
}

- (CADisplayLink *)link{
    if (!_link) {
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(animateprecent)];
        _link.frameInterval = 1;
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    }
    return _link;
}

- (UILabel *)percentLabel {
    if (!_percentLabel) {
        _percentLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height)];
        _percentLabel.center = CGPointMake(self.bounds.size.width/2,self.bounds.size.height/2);
        _percentLabel.textAlignment = NSTextAlignmentCenter;
        int fontNum = self.bounds.size.width/6;
        _percentLabel.font = [UIFont boldSystemFontOfSize:fontNum];
        _percentLabel.text = @"100%";
    }
    return _percentLabel;
}

- (CAShapeLayer *)backgroundLine {
    if(!_backgroundLine) {
        _backgroundLine = [[CAShapeLayer alloc] init];
        _backgroundLine.fillColor = [UIColor clearColor].CGColor;
        _backgroundLine.strokeColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
        _backgroundLine.lineWidth = lineWidth;
    }
    return _backgroundLine;
}

- (CAShapeLayer *)progressLine {
    if(!_progressLine) {
        _progressLine = [[CAShapeLayer alloc] init];
        _progressLine.fillColor = [UIColor clearColor].CGColor;
        _progressLine.strokeColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1].CGColor;
        _progressLine.lineCap = kCALineCapRound;
        _progressLine.lineWidth = lineWidth;
    }
    return _progressLine;
}

- (CAGradientLayer *)grain {
    if(_grain == nil) {
        _grain = [[CAGradientLayer alloc] init];
        _grain.frame = CGRectMake(0, 0, self.bounds.size.width,self.bounds.size.height);
        [_grain setColors:[NSArray arrayWithObjects:
                           (id)[[UIColor yellowColor] CGColor],
                           (id)[[UIColor orangeColor] CGColor],
                           (id)[[UIColor redColor] CGColor], nil]];
        [_grain setLocations:@[@0, @0.5, @1]];
        [_grain setStartPoint:CGPointMake(0, 0)];
        [_grain setEndPoint:CGPointMake(1, 0)];
        _grain.type = kCAGradientLayerAxial;
        [self.layer addSublayer:_grain];
    }
    return _grain;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
