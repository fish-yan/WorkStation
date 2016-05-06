//
//  WorkTimeChartViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/5.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "WorkTimeChartViewController.h"
#import "ServiceTitleCell.h"
#import "WorkTimeCell.h"
#import "WorkTimeHeaderView.h"

#define kHeaderHeight 300
@interface WorkTimeChartViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation WorkTimeChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _tableView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    WorkTimeHeaderView *headerView = [[WorkTimeHeaderView alloc]initWithFrame:CGRectMake(0, -kHeaderHeight, kScreenWidth, kHeaderHeight)];
    [_tableView addSubview:headerView];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        ServiceTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ServiceTitleCell" forIndexPath:indexPath];
        return cell;
    }
    WorkTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WorkTimeCell" forIndexPath:indexPath];
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc]init];
    sectionView.backgroundColor = [UIColor clearColor];
    return sectionView;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return 44;
    }else{
        return 65;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 12;
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
