//
//  SaveGIFViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/13.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "SaveGIFViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "UIImageView+PlayGIF.h"
#import "UIImageView+WebCache.h"

@interface SaveGIFViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *GIFImageView;
@property (weak, nonatomic) IBOutlet UIImageView *netGIFImageView;

@end

@implementation SaveGIFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.GIFImageView.gifPath = [[NSBundle mainBundle] pathForResource:@"funny" ofType:@"gif"];
    [self.GIFImageView startGIF];
    
    [self.netGIFImageView sd_setImageWithURL:[NSURL URLWithString:@"http://img.zcool.cn/community/015c0a55ae5a3232f875495e221f22.gif"]];
    
}

- (IBAction)saveGIF:(id)sender {
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"funny" ofType:@"gif"]];
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
    [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
        if (!error) {
            [self showTextHUD:@"保存成功"];
        }else {
            NSLog(@"%@",error);
        }
    }];
}

- (IBAction)saveNetGIF:(id)sender {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        // dataWithContentsOfURL是耗时操作，所以放入分线程
        NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://img.zcool.cn/community/015c0a55ae5a3232f875495e221f22.gif"]];
        ALAssetsLibrary *library = [[ALAssetsLibrary alloc]init];
        [library writeImageDataToSavedPhotosAlbum:data metadata:nil completionBlock:^(NSURL *assetURL, NSError *error) {
            if (!error) {
               dispatch_async(dispatch_get_main_queue(), ^{
                   [self showTextHUD:@"保存成功"];
               });
            }else {
                NSLog(@"%@",error);
            }
        }];
        
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
