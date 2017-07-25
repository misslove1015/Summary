//
//  ChangeAppIconViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/25.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "ChangeAppIconViewController.h"
#import <objc/runtime.h>

@interface ChangeAppIconViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic, strong) NSArray *array;

@end

@implementation ChangeAppIconViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
   
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 60;
    self.tableView.tableFooterView = [[UIView alloc]init];
    // 换图标不弹窗方法
    // [self runtimeReplaceAlert];
    
}

// 利用runtime来替换展现弹出框的方法
- (void)runtimeReplaceAlert {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method presentM = class_getInstanceMethod(self.class, @selector(presentViewController:animated:completion:));
        Method presentSwizzlingM = class_getInstanceMethod(self.class, @selector(myPresentViewController:animated:completion:));
        method_exchangeImplementations(presentM, presentSwizzlingM);
    });
}

// 自己的替换展示弹出框的方法
- (void)myPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    if ([viewControllerToPresent isKindOfClass:[UIAlertController class]]) {
        // 换图标时的提示框的title和message都是nil，由此可特殊处理
        UIAlertController *alertController = (UIAlertController *)viewControllerToPresent;
        if (alertController.title == nil && alertController.message == nil) {
            return;
        } else {
            [self myPresentViewController:viewControllerToPresent animated:flag completion:completion];
            return;
        }
    }
    
    [self myPresentViewController:viewControllerToPresent animated:flag completion:completion];
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
    cell.imageView.image = [UIImage imageNamed:dic[@"icon"]];
    cell.textLabel.text = dic[@"name"];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (![[UIApplication sharedApplication] supportsAlternateIcons]) {// 系统不支持换图标
        return;
    }
    
    NSDictionary *dic = self.array[indexPath.row];
    [[UIApplication sharedApplication] setAlternateIconName:dic[@"icon"] completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"更换app图标发生错误了 ： %@",error);
        }
    }];
}

- (NSArray *)array {
    if (!_array) {
        _array = @[@{@"icon":@"icon_huaji",
                     @"name":@"滑稽"},
                   @{@"icon":@"icon_keai",
                     @"name":@"可爱"},
                   @{@"icon":@"icon_xiao",
                     @"name":@"大笑"},
                   @{@"icon":@"icon_pen",
                     @"name":@"喷"}];
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
