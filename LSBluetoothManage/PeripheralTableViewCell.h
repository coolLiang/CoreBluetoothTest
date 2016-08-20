//
//  PeripheralTableViewCell.h
//  LSBluetoothManage
//
//  Created by noci on 16/8/20.
//  Copyright © 2016年 noci. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "LSPeripheralData.h"

@interface PeripheralTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *idLabel;

@property (weak, nonatomic) IBOutlet UILabel *diatanceLabel;

@property(nonatomic,strong)LSPeripheralData * data;

@end
