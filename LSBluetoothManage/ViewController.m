//
//  ViewController.m
//  LSBluetoothManage
//
//  Created by noci on 16/8/20.
//  Copyright © 2016年 noci. All rights reserved.
//

#import "ViewController.h"

#import "LSBluetoothManage.h"

#import "PeripheralTableViewCell.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)NSArray * dataArray;

@property(nonatomic,strong)UITableView * bluetoothDeviceTable;

@property(nonatomic,strong)UIButton * tableFooterButton;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.bluetoothDeviceTable = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.bluetoothDeviceTable.dataSource = self;
    self.bluetoothDeviceTable.delegate = self;
    self.bluetoothDeviceTable.rowHeight = UITableViewAutomaticDimension;
    self.bluetoothDeviceTable.estimatedRowHeight = 66;
    [self.view addSubview:self.bluetoothDeviceTable];

    [[LSBluetoothManage shareLSBluetoothManage]startBluetooth];
    
    self.tableFooterButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.tableFooterButton setTitle:@"重新扫描" forState:UIControlStateNormal];
    [self.tableFooterButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [self.tableFooterButton addTarget:self action:@selector(reloadTheBlueTooth) forControlEvents:UIControlEventTouchUpInside];
    self.tableFooterButton.frame = CGRectMake(0, 0, 0, 50);
    self.bluetoothDeviceTable.tableFooterView = self.tableFooterButton;
    
    __weak typeof(self) weakself = self;
    
    [[LSBluetoothManage shareLSBluetoothManage] onUpdateTheScanedPerpheralDataArray:^(NSArray *perpheralArray) {
        
        weakself.dataArray = [NSArray arrayWithArray:perpheralArray];
        [weakself.bluetoothDeviceTable reloadData];
        
    }];
    
    // Do any additional setup after loading the view, typically from a nib.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static  NSString  *CellIdentiferId = @"PeripheralTableViewCell";
    PeripheralTableViewCell  * cell = [tableView dequeueReusableCellWithIdentifier:CellIdentiferId];
    if (cell == nil) {
        
        NSArray *nibs = [[NSBundle mainBundle]loadNibNamed:@"PeripheralTableViewCell" owner:nil options:nil];
        cell = [nibs lastObject];
    };
    
    cell.data = self.dataArray[indexPath.row];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[LSBluetoothManage shareLSBluetoothManage]connectionPeripheralWithIndex:indexPath.row];
}

//
-(void)reloadTheBlueTooth
{
    [[LSBluetoothManage shareLSBluetoothManage]reloadBluetooth];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
