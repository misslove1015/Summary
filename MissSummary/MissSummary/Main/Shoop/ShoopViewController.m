//
//  ShoopViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/17.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "ShoopViewController.h"
#import "ShoopView.h"

@interface ShoopViewController ()

@property (weak, nonatomic) IBOutlet UIButton *shoopButton;

@end

@implementation ShoopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)shoop:(UIButton *)sender {
    ShoopView *shoopView = [[ShoopView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH)];
    shoopView.center = self.shoopButton.center;
    [shoopView animationWithDuraton:4.0];
    [self.view addSubview:shoopView];
    [self.view sendSubviewToBack:shoopView];
    
    sender.enabled = NO;
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        sender.enabled = YES;
    });
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
