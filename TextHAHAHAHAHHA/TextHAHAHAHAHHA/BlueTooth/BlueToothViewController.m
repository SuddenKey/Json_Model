//
//  BlueToothViewController.m
//  TextHAHAHAHAHHA
//
//  Created by haohao on 2018/3/7.
//  Copyright © 2018年 haohao. All rights reserved.
//

#import "BlueToothViewController.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "ToothDevice.h"

#define KWidth    self.view.frame.size.width
#define KHeight   self.view.frame.size.height

typedef NS_ENUM(NSInteger, BluetoothState){
    BluetoothStateDisconnect = 0,
    BluetoothStateScanSuccess,
    BluetoothStateScaning,
    BluetoothStateConnected,
    BluetoothStateConnecting
    
};
typedef NS_ENUM(NSInteger, BluetoothFailState){
    BluetoothFailStateUnExit = 0,
    BluetoothFailStateUnKnow,
    BluetoothFailStateByHW,
    BluetoothFailStateByOff,
    BluetoothFailStateUnauthorized,
    BluetoothFailStateByTimeout
    
};


@interface BlueToothViewController ()<UITableViewDelegate, UITableViewDataSource, CBCentralManagerDelegate, CBPeripheralDelegate>

@property (nonatomic, strong) UITableView *myTableView;

@property (nonatomic, strong) CBCentralManager *manage;//中央设备

@property (nonatomic, strong) CBPeripheral     *discoveredPeripheral;//周边设备

@property (nonatomic, strong) CBCharacteristic *characteristic1;//周边设备特性

@property (nonatomic, assign) BluetoothState     bluetoothState;

@property (nonatomic, assign) BluetoothFailState bluetoothFailState;

@property (nonatomic, strong) NSMutableArray    *BleViewPerArr;

@end

@implementation BlueToothViewController

- (NSMutableArray *)BleViewPerArr {
    if (_BleViewPerArr == nil) {
        _BleViewPerArr = [NSMutableArray array];
    }
    return _BleViewPerArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setManage];
    [self setSubView];
}

- (void)setManage {
    self.manage = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    self.manage.delegate = self;
}



- (void)setSubView {
    _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight) style:UITableViewStyleGrouped];
    _myTableView.delegate = self;
    _myTableView.dataSource = self;
    [self.view addSubview:_myTableView];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    rightBtn.frame = CGRectMake(0, 0, 40, 40);
    [rightBtn setTitle:@"点击" forState:UIControlStateNormal];
    [rightBtn setBackgroundColor:[UIColor yellowColor]];
    [rightBtn addTarget:self action:@selector(scan) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightBtn];
}

//扫描
- (void)scan {
    //判断状态开始扫瞄周围设备 第一个参数为空则会扫瞄所有的可连接设备 你可以
    //指定一个CBUUID对象 从而只扫瞄注册用指定服务的设备
    //scanForPeripheralsWithServices方法调用完后会调用代理CBCentralManagerDelegate的
    //- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI方法
    
    [self.manage scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:@NO}];
    //记录目前是扫描状态
    _bluetoothState = BluetoothStateScaning;
    //清空所有外设数组
    [self.BleViewPerArr removeAllObjects];
    //蓝牙是否开启
    if (_bluetoothFailState == BluetoothFailStateByOff) {
        NSLog(@"检查您的蓝牙是否开启后重试");
    }
}

#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"self.BleViewPerArr.count === %ld", self.BleViewPerArr.count);
    return self.BleViewPerArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell =  [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifier];
    }
    CBPeripheral *pheral = (CBPeripheral *)self.BleViewPerArr[indexPath.row];
    NSString *bleName = pheral.name;
    cell.textLabel.text = bleName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld", pheral.state];
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CBPeripheral *cbp = (CBPeripheral *)_BleViewPerArr[indexPath.row];
    //设定周边设备，指定代理者
    _discoveredPeripheral = cbp;
    _discoveredPeripheral.delegate = self;
    
    [_manage connectPeripheral:_discoveredPeripheral options:@{CBConnectPeripheralOptionNotifyOnConnectionKey:@YES}];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
//    return <#expression#>;
//}
//- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
//    return <#expression#>;
//}

//- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidthSCREEN, 0.0001)];
//    return headerView;
//}
//- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidthSCREEN, 6)];
//    return headerView;
//}
//
//
//-(void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
//
//{
//    if(indexPath.row == ((NSIndexPath*)[[tableView indexPathsForVisibleRows]lastObject]).row){
//        dispatch_async(dispatch_get_main_queue(), ^{
//            MyLog(@"%lf", tableView.contentSize.height);
//            if (_footView == nil) {
//                _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidthSCREEN, KHeightSCREEN - tableView.contentSize.height)];
//                _footView.backgroundColor = [UIColor whiteColor];
//                _myTableView.tableFooterView = _footView;
//            }
//        });
//    }
//}

#pragma mark - CBCentralManagerDelegate
- (void)centralManagerDidUpdateState:(CBCentralManager *)central {
    if (central.state != CBManagerStatePoweredOn) {
        switch (central.state) {
            case CBManagerStatePoweredOff:
                NSLog(@"蓝牙关了");
                _bluetoothFailState = BluetoothFailStateByOff;
                break;
            case CBManagerStateResetting:
                NSLog(@"失去服务, 需要立即更新");
                break;
            case CBManagerStateUnknown:
                NSLog(@"未知的状态，需要立即更新");
                break;
            case CBManagerStateUnsupported:
                NSLog(@"设备不支持");
                break;
            case CBManagerStateUnauthorized:
                NSLog(@"未授权");
                break;
            default:
                break;
        }
    }
    _bluetoothFailState = BluetoothFailStateUnExit;
}

- (void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary<NSString *, id> *)advertisementData RSSI:(NSNumber *)RSSI {
    //要判断获取自己的蓝牙名字
    
    NSString *perlname = [NSString stringWithFormat:@"%@", peripheral.name];
    NSLog(@"perlname   ====   %@", perlname);
    NSLog(@"advertisementData ===  %@", advertisementData);
    if (perlname.length > 0 && ![perlname isEqualToString:@"(null)"]) {
        [self.BleViewPerArr addObject:peripheral];
    }
    [_myTableView reloadData];
}
#pragma mark - CBPeripheralDelegate
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral {
    
}

- (void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error {
    
}

@end
