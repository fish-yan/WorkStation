//
//  SettingViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/4.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "SettingViewController.h"
#import "SettingListCell.h"

@interface SettingViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)backItemAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SettingListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingListCell" forIndexPath:indexPath];
    NSArray *titleArray = @[@"无线打印机", @"修改密码",@"版本  V1.6"];
    cell.titleLab.text = titleArray[indexPath.row];
    if (indexPath.row == 0) {
        cell.printerLab.hidden = NO;
        cell.printerLab.text  = @"打印机1";
    }else{
        cell.printerLab.hidden = YES;
    }
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"printer" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"passWord" sender:nil];
            break;
        case 2:
            [self performSegueWithIdentifier:@"versions" sender:nil];
            break;
        default:
            break;
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
