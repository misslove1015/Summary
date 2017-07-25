//
//  ChangeAlertButtonColorViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/13.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "ChangeAlertButtonColorViewController.h"

@interface ChangeAlertButtonColorViewController ()

@end

@implementation ChangeAlertButtonColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)alert:(id)sender {
    [self showAlert:YES];
}

- (IBAction)actionSheet:(id)sender {
    [self showAlert:NO];
}

- (void)showAlert:(BOOL)isAlert {
    
    UIAlertController *alert;
    
    if (isAlert) {
       alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是一个Alert" preferredStyle:UIAlertControllerStyleAlert];
    }else {
       alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"这是一个ActionSheet" preferredStyle:UIAlertControllerStyleActionSheet];
    }
   
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    // 8.4之后才有这个属性
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.4) {
        [confirmAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
        [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];

    }
    
    [alert addAction:confirmAction];
    [alert addAction:cancelAction];
    
    [self presentViewController:alert animated:YES completion:nil];
    
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
