//
//  ParabolaViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/20.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "ParabolaViewController.h"

@interface ParabolaViewController ()

@property (weak, nonatomic) IBOutlet UIView *animationView;

@end

@implementation ParabolaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
   
    CAKeyframeAnimation *keyframeAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    CGMutablePathRef path = CGPathCreateMutable();
    // 起始位置
    CGPathMoveToPoint(path, NULL, self.animationView.center.x, self.animationView.center.y);
    // 第三个参数是抛物线最高点x坐标，第四个参数是抛物线最高点y坐标，第五个参数是终点的x坐标，第六个是终点的y坐标
    CGPathAddQuadCurveToPoint(path, NULL, SCREEN_WIDTH/2, 50, SCREEN_WIDTH-50, 300);
    keyframeAnimation.path = path;
    CGPathRelease(path);
    keyframeAnimation.duration = 0.8;
    [self.animationView.layer addAnimation:keyframeAnimation forKey:@"KCKeyframeAnimation_Position"];
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
