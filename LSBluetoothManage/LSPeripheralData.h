//
//  LSPeripheralData.h
//  LSBluetoothManage
//
//  Created by noci on 16/8/20.
//  Copyright © 2016年 noci. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface LSPeripheralData : NSObject

@property(nonatomic,copy)NSString * device_name;

@property(nonatomic,assign)float device_distance;

@property(nonatomic,copy)NSString * device_id;

-(instancetype)initWithPeripheral:(CBPeripheral *)peripheral andRSSI:(int)rssi;


@end
