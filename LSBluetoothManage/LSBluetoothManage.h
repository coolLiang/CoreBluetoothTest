//
//  LSBluetoothManage.h
//  LSBluetoothManage
//
//  Created by noci on 16/8/20.
//  Copyright © 2016年 noci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreBluetooth/CoreBluetooth.h>

typedef void(^onUpdateTheScanedPerpheral)(NSArray * perpheralArray);

@interface LSBluetoothManage : NSObject<CBCentralManagerDelegate,CBPeripheralDelegate>
{
    CBCentralManager * bluetoothManage;  //系统蓝牙管理对象
    CBPeripheral * bluetoothPeripheral;  //当前出现的外设。
}

+(LSBluetoothManage *)shareLSBluetoothManage;

-(void)startBluetooth;

-(void)reloadBluetooth;

-(void)connectionPeripheralWithIndex:(NSInteger)index;

-(void)onUpdateTheScanedPerpheralDataArray:(onUpdateTheScanedPerpheral)block;



@end
