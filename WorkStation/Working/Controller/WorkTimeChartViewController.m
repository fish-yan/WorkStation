//
//  WorkTimeChartViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/5.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "WorkTimeChartViewController.h"

@interface WorkTimeChartViewController ()

@end

@implementation WorkTimeChartViewController

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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
