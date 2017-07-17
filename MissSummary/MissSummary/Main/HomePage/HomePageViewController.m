//
//  HomePageViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/13.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "HomePageViewController.h"
#import "HeaderFile.h"

#define STRING_CLASS(Class) NSStringFromClass([Class class])

@interface HomePageViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *array;

@end

@implementation HomePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"首页";
    UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    NSDictionary *dic = self.array[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%ld. %@",indexPath.row+1,dic[@"name"]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary *dic = self.array[indexPath.row];
    Class class = NSClassFromString(dic[@"class"]);
    UIViewController *viewController = [[class alloc]init];
    viewController.title = dic[@"name"];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (NSArray *)array {
    if (!_array) {
        _array = @[@{@"name":@"截取长屏",
                    @"class":STRING_CLASS(ScreenShotScrollViewViewController)},
                   
                   @{@"name":@"截取当前屏幕",
                    @"class":STRING_CLASS(ScreenShotViewController)},
                   
                   @{@"name":@"保存GIF到相册",
                    @"class":STRING_CLASS(SaveGIFViewController)},
                  
                   @{@"name":@"AlertController更改按钮颜色",
                     @"class":STRING_CLASS(ChangeAlertButtonColorViewController)},
                    
                   @{@"name":@"获取屏幕旋转",
                     @"class":STRING_CLASS(DeviceOrientationViewController)},
                     
                   @{@"name":@"恢复scrollView上按钮的点击效果",
                     @"class":STRING_CLASS(ScrollViewButtonTapEffectViewController)},
                     
                   @{@"name":@"MD5加密",
                    @"class":STRING_CLASS(MD5ViewController)},
                   
                   @{@"name":@"渐变进度条",
                     @"class":STRING_CLASS(GradientProgressViewViewController)},
                   
                   @{@"name":@"使用系统定位当前位置",
                     @"class":STRING_CLASS(LocationViewController)},
                   
                   @{@"name":@"重力物理动画",
                     @"class":STRING_CLASS(DynamicAnimationViewController)},
                   
                   @{@"name":@"摇一摇",
                     @"class":STRING_CLASS(ShakeViewController)},
                   
                   @{@"name":@"咻一咻",
                     @"class":STRING_CLASS(ShoopViewController)},
                   ];
    }
    
    return _array;
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
