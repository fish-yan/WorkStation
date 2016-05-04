//
//  PrinterViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/4.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "PrinterViewController.h"
#import "PrinterCell.h"
#import "PrinterSectionView.h"

@interface PrinterViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) NSUserDefaults *userDefaluts;
@property (strong, nonatomic) NSMutableArray *dataArray;
@property (copy, nonatomic) NSString *currentPrinter;
@property (assign, nonatomic) BOOL isOn;

@end

@implementation PrinterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _dataArray = [NSMutableArray array];
    
    _userDefaluts = [NSUserDefaults standardUserDefaults];
    if ([_userDefaluts objectForKey:@"PrintData"] == nil) {
        NSMutableArray *firstSectionArray = @[@"无线打印机"].mutableCopy;
        NSMutableArray *secondSectionArray = @[@"打印机1", @"打印机2", @"打印机3", @"打印机4"].mutableCopy;
        _dataArray = @[firstSectionArray, secondSectionArray].mutableCopy;
        [_userDefaluts setObject:_dataArray forKey:@"PrintData"];
    }
    _dataArray = [_userDefaluts objectForKey:@"PrintData"];
    _isOn = [_userDefaluts boolForKey:@"printerSwitch"];
    
}

- (IBAction)backItemAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)printerSwitchAction:(UISwitch *)sender {
//    if (sender.on) {
//        [_dataArray[0] insertObject:_currentPrinter atIndex:1];
//    }else{
//        [_dataArray[0] removeObjectAtIndex:1];
//    }
//    [_userDefaluts setBool:sender.on forKey:@"printerSwitch"];
//    [_userDefaluts setObject:_dataArray forKey:@"PrintData"];
//    [_tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_dataArray[section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PrinterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PrinterCell" forIndexPath:indexPath];
    cell.printerLab.text = _dataArray[indexPath.section][indexPath.row];
    if (indexPath.section == 0 && indexPath.row == 0) {
        cell.printSwitch.hidden = NO;
        [cell.printSwitch setOn:_isOn];
    }else{
        cell.printSwitch.hidden = YES;
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        cell.selectImg.hidden = NO;
    }else{
        cell.selectImg.hidden = YES;
    }

    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return 11;
    }else{
        return 63;
    }

}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    PrinterSectionView *sectionView = [[NSBundle mainBundle]loadNibNamed:@"PrinterSectionView" owner:self options:nil].lastObject;
    sectionView.frame = CGRectMake(0, 0, kScreenWidth, 68);
    if (section == 1) {
       return sectionView;
    }else{
        return nil;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (_isOn && indexPath.section == 1) {
        _dataArray[0][1] = _dataArray[1][indexPath.row];
        [_userDefaluts setObject:_dataArray forKey:@"PrintData"];
        [_tableView reloadData];
    }
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
