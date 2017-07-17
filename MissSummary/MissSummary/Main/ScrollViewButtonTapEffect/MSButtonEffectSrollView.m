//
//  MSButtonEffectSrollView.m
//  MissSummary
//
//  Created by miss on 2017/7/14.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "MSButtonEffectSrollView.h"

@implementation MSButtonEffectSrollView

// 代码创建会走这个方法
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.delaysContentTouches = NO;
        self.canCancelContentTouches = YES;
    }
    
    return self;
}

// IB创建会走这个方法
- (void)awakeFromNib {
    [super awakeFromNib];
    self.delaysContentTouches = NO;
    self.canCancelContentTouches = YES;
}

- (BOOL)touchesShouldCancelInContentView:(UIView *)view{
    return YES;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
