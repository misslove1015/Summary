//
//  BluetoothViewController.m
//  MissSummary
//
//  Created by miss on 2017/7/24.
//  Copyright © 2017年 mukr. All rights reserved.
//

#import "BluetoothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>

@interface BluetoothViewController ()<CBCentralManagerDelegate,CBPeripheralDelegate,UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) CBCentralManager               *manager;
@property (nonatomic, strong) CBPeripheral                   *peripheral;
@property (nonatomic, strong) NSMutableArray                 *peripheralArray;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicatorView;

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation BluetoothViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.tableFooterView = [[UIView alloc]init];
    
    // 写数据到蓝牙设备
   // [self.peripheral writeValue:[[NSData alloc]init] forCharacteristic:[CBCharacteristic alloc] type:CBCharacteristicWriteWithResponse];
}

- (IBAction)searchPeripheral:(UIButton *)sender {
    [self.peripheralArray removeAllObjects];
    [self.tableView reloadData];
    
    [self.indicatorView startAnimating];

    self.manager = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
}


// 获得从蓝牙设备传过来的数据
- (void)peripheral:(CBPeripheral *)peripheral didUpdateValueForCharacteristic:(nonnull CBCharacteristic *)characteristic error:(nullable NSError *)error {
    NSLog(@"%@",characteristic);
}


// 发现蓝牙设备
- (void)centralManager:(CBCentralManager *)central
 didDiscoverPeripheral:(CBPeripheral *)peripheral
     advertisementData:(NSDictionary *)advertisementData
                  RSSI:(NSNumber *)RSSI{
    NSLog(@"发现设备 %@",peripheral);    
    if (peripheral.name) {
        
        [self.peripheralArray addObject:peripheral];
        [self.tableView reloadData];
    }
}


// 连接蓝牙设备成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    NSLog(@"连接成功 %@",peripheral);
    [self.manager stopScan];
    [self.indicatorView stopAnimating];
    [self.tableView reloadData];
}

// 连接蓝牙设备失败
- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接失败 %@",peripheral);

}

// 连接已断开
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    NSLog(@"连接已断开 %@",peripheral);
    [self.tableView reloadData];

}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    switch (central.state) {
        case CBManagerStateUnknown:
            // 蓝牙状态未知
            break;
        case CBManagerStateResetting:
            // 蓝牙正在重新启动
            break;
        case CBManagerStateUnsupported:
            // 设置不支持蓝牙
            break;
        case CBManagerStateUnauthorized:
            // 未获得授权
            break;
        case CBManagerStatePoweredOff:
            // 蓝牙已关闭
            break;
        case CBManagerStatePoweredOn:{
            // 蓝牙已开启

            [self.manager scanForPeripheralsWithServices:nil // 通过某些服务筛选外设
                                              options:nil]; // dict,条件
            // 搜索成功之后,会调用我们找到外设的代理方法
            // - (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI; //找到外设
        }
            break;
        default:
            break;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.peripheralArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    CBPeripheral *peripheral = self.peripheralArray[indexPath.row];
    cell.textLabel.text = peripheral.name;
    if (peripheral.state == CBPeripheralStateConnected) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    CBPeripheral *peripheral = self.peripheralArray[indexPath.row];
    if (peripheral.state == CBPeripheralStateConnected) return;
    [self.manager connectPeripheral:peripheral options:nil];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *peripheral = self.peripheralArray[indexPath.row];
    if (peripheral.state != CBPeripheralStateConnected) return;
    [self.manager cancelPeripheralConnection:peripheral];
}

- (NSMutableArray *)peripheralArray {
    if (!_peripheralArray) {
        _peripheralArray = [[NSMutableArray alloc]init];
    }
    return _peripheralArray;
}

- (void)dealloc {
    [self.manager stopScan];
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
