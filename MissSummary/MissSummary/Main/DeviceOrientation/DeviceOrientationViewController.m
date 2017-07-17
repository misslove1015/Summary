//
//  DeviceOrientationViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/13.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "DeviceOrientationViewController.h"

@interface DeviceOrientationViewController ()

@property (weak, nonatomic) IBOutlet UILabel *orientationLabel;

@end

@implementation DeviceOrientationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addDeviceOrientationDidChangeNotification];
}

- (void)addDeviceOrientationDidChangeNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deviceOrientationChange:)
                                                 name:UIDeviceOrientationDidChangeNotification
                                               object:nil];
}

- (void)deviceOrientationChange:(NSNotification*)noti{
    UIDeviceOrientation interfaceOrientation = [UIDevice currentDevice].orientation;
    
    switch (interfaceOrientation) {
        case UIDeviceOrientationPortrait:{
            
            self.orientationLabel.text = @"竖屏(Home键在下)";
            [self orientationLabelAnimation:0];
        }
            break;
            
        case UIDeviceOrientationPortraitUpsideDown:{
            
            self.orientationLabel.text = @"竖屏(Home键在上)";
            [self orientationLabelAnimation:M_PI];
        }
            break;
            
        case UIDeviceOrientationLandscapeLeft:{
            self.orientationLabel.text = @"横屏(Home键在右)";
            [self orientationLabelAnimation:M_PI_2];
        }
            break;
            
        case UIDeviceOrientationLandscapeRight:{
            
            self.orientationLabel.text = @"横屏(Home键在左)";
            [self orientationLabelAnimation:-M_PI_2];
        }
            break;
            
        default:
            break;
    }
    
}

- (void)orientationLabelAnimation:(CGFloat)rotation {
    [UIView animateWithDuration:0.25 animations:^{
        self.orientationLabel.transform = CGAffineTransformMakeRotation(rotation);
    }];
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
