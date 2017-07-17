//
//  DynamicAnimationViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/17.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "DynamicAnimationViewController.h"

@interface DynamicAnimationViewController ()

@property (strong ,nonatomic) UIDynamicAnimator *animator;
@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
@property (weak, nonatomic) IBOutlet UIView *view3;
@property (weak, nonatomic) IBOutlet UIView *view4;
@property (weak, nonatomic) IBOutlet UIView *view5;
@property (weak, nonatomic) IBOutlet UIView *view6;
@property (weak, nonatomic) IBOutlet UIView *view7;
@property (weak, nonatomic) IBOutlet UIView *view8;

@end

@implementation DynamicAnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIGravityBehavior *behavior = [[UIGravityBehavior alloc]init];
    [behavior addItem:self.view1];
    [behavior addItem:self.view2];
    [behavior addItem:self.view3];
    [behavior addItem:self.view4];
    [behavior addItem:self.view5];
    [behavior addItem:self.view6];
    [behavior addItem:self.view7];
    [behavior addItem:self.view8];
    behavior.magnitude = 3;
    
    UICollisionBehavior *collision = [[UICollisionBehavior alloc]init];
    collision.collisionMode = UICollisionBehaviorModeEverything;
    
    CGFloat y = self.view.frame.size.height;
    CGFloat x = self.view.frame.size.width;
    
    [collision addBoundaryWithIdentifier:@"collsion1" fromPoint:CGPointMake(0, y) toPoint:CGPointMake(x, y)];
    [collision addItem:self.view1];
    [collision addItem:self.view2];
    [collision addItem:self.view3];
    [collision addItem:self.view4];
    [collision addItem:self.view5];
    [collision addItem:self.view6];
    [collision addItem:self.view7];
    [collision addItem:self.view8];
    
    [self.animator addBehavior:behavior];
    [self.animator addBehavior:collision];
}

- (UIDynamicAnimator *)animator {
    if (!_animator) {
        _animator = [[UIDynamicAnimator alloc]init];
    }
    return _animator;
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
