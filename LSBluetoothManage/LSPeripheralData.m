//
//  LSPeripheralData.m
//  LSBluetoothManage
//
//  Created by noci on 16/8/20.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "LSPeripheralData.h"

@implementation LSPeripheralData

-(instancetype)initWithPeripheral:(CBPeripheral *)peripheral andRSSI:(int)rssi;
{
    self = [super init];
    
    if (self) {
        
        self.device_id = [peripheral.identifier UUIDString];
        self.device_name = peripheral.name;
        self.device_distance = [self calcDistByRSSI:rssi];
    }
    
    return self;
    
}

- (float)calcDistByRSSI:(int)rssi
{
    int iRssi = abs(rssi);
    float power = (iRssi-59)/(10*2.0);
    return pow(10, power);
}

@end
