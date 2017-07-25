//
//  TouchIDViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/25.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "TouchIDViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>

@interface TouchIDViewController ()

@property (weak, nonatomic) IBOutlet UIView *printView;

@end

@implementation TouchIDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self print];
}

- (IBAction)print:(id)sender {
    [self print];
}

- (void)print{
    LAContext *context = [[LAContext alloc]init];
    NSError *error = nil;
    NSString *result = @"通过Home键验证已有指纹";
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:result reply:^(BOOL success, NSError * _Nullable error) {
            if (success) {//验证成功
               
                [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                    
                    [self.printView removeFromSuperview];
                    
                }];                
                
            }else{
                switch (error.code) {
                    case LAErrorSystemCancel:
                        //切换到其他APP，系统取消验证
                        break;
                    case LAErrorUserCancel:
                        //用户取消验证
                        break;
                    case LAErrorUserFallback:
                        //用户选择其他验证方式
                    {
                        //切换到主线程处理
                        [[NSOperationQueue mainQueue]addOperationWithBlock:^{
                            
                        }];
                    }
                        break;
                        
                    default://其他情况
                        break;
                }
                
            }
            
            
            
        }];
    }else{
        //不支持指纹识别，LOG出错误详情
        
        switch (error.code) {
            case LAErrorTouchIDNotEnrolled:
            {
                NSLog(@"TouchID is not enrolled");
                break;
            }
            case LAErrorPasscodeNotSet:
            {
                NSLog(@"A passcode has not been set");
                break;
            }
            default:
            {
                NSLog(@"TouchID not available");
                break;
            }
        }
        
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
