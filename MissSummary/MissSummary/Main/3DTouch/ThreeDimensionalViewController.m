//
//  ThreeDimensionalViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/25.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "ThreeDimensionalViewController.h"
#import "AppDelegate.h"

@interface ThreeDimensionalViewController ()

@property (weak, nonatomic) IBOutlet UILabel *label;

@end

@implementation ThreeDimensionalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"3D Touch";
    if (self.touchTitle) {
        self.label.text = [NSString stringWithFormat:@"从3D Touch“%@“进来的",self.touchTitle];
     }
   
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
