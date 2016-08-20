//
//  LSBluetoothManage.m
//  LSBluetoothManage
//
//  Created by noci on 16/8/20.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "LSBluetoothManage.h"
#import "Tools.h"
//
#import "LSPeripheralData.h"

@interface LSBluetoothManage()

@property(nonatomic,strong)NSMutableArray * scanedPeripheralArray;  //扫描出的外设对象数组

@property(nonatomic,strong)NSMutableArray * peripheralDataArray;    //根据外设对象产生的数据数组

@property(nonatomic,copy)onUpdateTheScanedPerpheral dataArrayBlock;

@end

@implementation LSBluetoothManage

+(LSBluetoothManage *)shareLSBluetoothManage
{
    static LSBluetoothManage * sharedLSBluetoothManage = nil;
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        sharedLSBluetoothManage = [[self alloc] init];
    });
    
    return sharedLSBluetoothManage;
}

-(void)startBluetooth
{
    bluetoothManage = [[CBCentralManager alloc]initWithDelegate:self queue:nil];
    
    self.scanedPeripheralArray = [NSMutableArray new];
    self.peripheralDataArray = [NSMutableArray new];
}

-(void)reloadBluetooth
{
    [bluetoothManage stopScan];
    [self.scanedPeripheralArray removeAllObjects];
    [self.peripheralDataArray removeAllObjects];
    
    if (self.dataArrayBlock) {
        
        self.dataArrayBlock(self.peripheralDataArray);
    }
    
    [bluetoothManage scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:[NSNumber numberWithBool:NO]}];
}

-(void)connectionPeripheralWithIndex:(NSInteger)index
{
    if (bluetoothPeripheral != self.scanedPeripheralArray[index]) {
        
        bluetoothPeripheral = self.scanedPeripheralArray[index];
        bluetoothPeripheral.delegate = self;
        [bluetoothManage connectPeripheral:bluetoothPeripheral options:nil];
    }
}

//蓝牙设备状态变化
-(void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    switch (central.state) {
            
        case CBCentralManagerStateUnknown:
            NSLog(@">>>CBCentralManagerStateUnknown");
            break;
        case CBCentralManagerStateResetting:
            NSLog(@">>>CBCentralManagerStateResetting");
            break;
        case CBCentralManagerStateUnsupported:
            NSLog(@">>>CBCentralManagerStateUnsupported");
            break;
        case CBCentralManagerStateUnauthorized:
            NSLog(@">>>CBCentralManagerStateUnauthorized");
            break;
            //蓝牙关闭中
        case CBCentralManagerStatePoweredOff:
            NSLog(@">>>CBCentralManagerStatePoweredOff");
            [self showBluetoothOffAlertTip];
            break;
            //蓝牙开启中
        case CBCentralManagerStatePoweredOn:
            NSLog(@">>>CBCentralManagerStatePoweredOn");
            
            //
            [bluetoothManage scanForPeripheralsWithServices:nil options:@{CBCentralManagerScanOptionAllowDuplicatesKey:[NSNumber numberWithBool:NO]}];
            
            break;
        default:
            break;
    }
}

//扫描到设备会进入方法
-(void)centralManager:(CBCentralManager *)central didDiscoverPeripheral:(CBPeripheral *)peripheral advertisementData:(NSDictionary *)advertisementData RSSI:(NSNumber *)RSSI{
    
    NSLog(@"当扫描到设备:%@",peripheral.name);

    LSPeripheralData * firstData = [[LSPeripheralData alloc]initWithPeripheral:peripheral andRSSI:[RSSI intValue]];
    [self.scanedPeripheralArray addObject:peripheral];
    [self.peripheralDataArray addObject:firstData];
    
    if (self.dataArrayBlock) {
        
        self.dataArrayBlock(self.peripheralDataArray);

    }
//    if ([peripheral.name hasPrefix:@"My"]) {
//        
//        NSLog(@"扫描到了华为渣渣手机！！！");
//        //开始连接设备
//        [bluetoothManage connectPeripheral:peripheral options:nil];
//
//    }
}



//连接到Peripherals-成功
- (void)centralManager:(CBCentralManager *)central didConnectPeripheral:(CBPeripheral *)peripheral
{
    NSLog(@">>>连接到名称为（%@）的设备-成功",peripheral.name);
}

//连接到Peripherals-失败
-(void)centralManager:(CBCentralManager *)central didFailToConnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error
{
    NSLog(@">>>连接到名称为（%@）的设备-失败,原因:%@",[peripheral name],[error localizedDescription]);
}

//Peripherals断开连接
- (void)centralManager:(CBCentralManager *)central didDisconnectPeripheral:(CBPeripheral *)peripheral error:(NSError *)error{
    NSLog(@">>>外设连接断开连接 %@: %@\n", [peripheral name], [error localizedDescription]);
    
}



#pragma mark - self method


-(void)showBluetoothOffAlertTip
{
    UIAlertController * tip = [UIAlertController alertControllerWithTitle:@"提示" message:@"当前设备蓝牙为开启,是否前往设置页面开启蓝牙?" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * confirm = [UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
        NSURL * url = [NSURL URLWithString:@"prefs:root=Bluetooth"];
        
        if ([[UIApplication sharedApplication]canOpenURL:url]) {
            
            [[UIApplication sharedApplication]openURL:url];
        }
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        
        [[Tools getCurrentViewController].presentedViewController dismissViewControllerAnimated:YES completion:NULL];
        
    }];
    
    [tip addAction:confirm];
    [tip addAction:cancel];
    
    [[Tools getCurrentViewController] presentViewController:tip animated:YES completion:NULL];
}

-(void)onUpdateTheScanedPerpheralDataArray:(onUpdateTheScanedPerpheral)block
{
    self.dataArrayBlock = block;
}

@end
