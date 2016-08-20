//
//  PeripheralTableViewCell.m
//  LSBluetoothManage
//
//  Created by noci on 16/8/20.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "PeripheralTableViewCell.h"

@implementation PeripheralTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)setData:(LSPeripheralData *)data
{
    self.nameLabel.text = data.device_name;
    self.idLabel.text = data.device_id;
    self.diatanceLabel.text = [NSString stringWithFormat:@"%.2f",data.device_distance];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
