//
//  ScreenShotViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/13.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "ScreenShotViewController.h"

@interface ScreenShotViewController ()

@end

@implementation ScreenShotViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (IBAction)screenShot:(id)sender {
    UIImage *image = [self screenShot];
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), (__bridge void *)self);

}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    if (!error) {
        [self showTextHUD:@"保存成功"];
    }else {
        NSLog(@"%@",error);
    }
    
}

- (UIImage *)screenShot{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT), YES, [UIScreen mainScreen].scale);
    // window可以改为其他view以实现截屏其他view
    [[UIApplication sharedApplication].delegate.window drawViewHierarchyInRect:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) afterScreenUpdates:NO];
    UIImage *screenShot = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return screenShot;
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
