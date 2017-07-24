//
//  GradientProgressViewViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/13.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "GradientProgressViewViewController.h"
#import "MSCircleProgressView.h"

@interface GradientProgressViewViewController ()

@property (weak, nonatomic) IBOutlet UIView *progressView;
@property (weak, nonatomic) IBOutlet MSCircleProgressView *circleProgressView;

@end

@implementation GradientProgressViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setGradientLayer];
 
}

- (void)setGradientLayer {
    CAGradientLayer *layer = [CAGradientLayer layer];
    layer.startPoint = CGPointMake(0, 0.5);
    layer.endPoint = CGPointMake(1, 0.5);
    layer.colors = [NSArray arrayWithObjects:
                    (id)[UIColor yellowColor].CGColor,
                    (id)[UIColor orangeColor].CGColor,
                    (id)[UIColor redColor].CGColor, nil];
    CGFloat width = SCREEN_WIDTH-20;
    layer.frame = CGRectMake(0, 0, width, 4);
    [self.progressView.layer insertSublayer:layer atIndex:0];
    self.progressView.clipsToBounds = YES;
}

- (IBAction)randomProgress:(UIButton *)sender {
    NSInteger randomNum = arc4random()%100;
    CGFloat width = (SCREEN_WIDTH-20)*randomNum/100;

    [sender setTitle:[NSString stringWithFormat:@"随机进度(%ld%%)",randomNum] forState:UIControlStateNormal];
    
    self.progressView.frame = CGRectMake(0, 0, 0, 4);
    [UIView animateWithDuration:1 animations:^{
        self.progressView.frame = CGRectMake(0, 0, width, 4);
    }];
}

- (IBAction)randomCircleProgress:(id)sender {
    //self.circleProgressView.animatable = YES;
    self.circleProgressView.percent = arc4random()%100;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
