//
//  ShakeViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/17.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "ShakeViewController.h"

@interface ShakeViewController ()

@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UIView *downView;

@property (nonatomic, assign) CGRect upRect;
@property (nonatomic, assign) CGRect downRect;

@end

@implementation ShakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.upRect = self.upView.frame;
    self.downRect = self.downView.frame;
}

- (void)motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //开始摇晃
    CGFloat width = self.upView.frame.size.width;
    CGFloat height = self.upView.frame.size.height;
    
    [UIView animateWithDuration:0.5 animations:^{
        
        self.upView.frame = CGRectMake(0, self.upRect.origin.y-100, width, height);
        self.downView.frame = CGRectMake(0, self.downRect.origin.y+100, width, height);
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [UIView animateWithDuration:0.5 animations:^{
                self.upView.frame = self.upRect;
                self.downView.frame = self.downRect;
            }];
            
        });
        
    }];
    
}

- (void)motionEnded:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //摇晃完毕
}

- (void)motionCancelled:(UIEventSubtype)motion withEvent:(UIEvent *)event{
    //取消摇晃
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
