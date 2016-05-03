//
//  RootViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/3.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "RootViewController.h"
#import "UserCenterCell.h"
#import "TabBarViewController.h"

#define kMaxX 250

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TabBarViewController *tabVC;
@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _tabVC = [[TabBarViewController alloc]init];
    _tabVC.view.frame = self.view.bounds;
    [self addChildViewController:_tabVC];
    [self.view addSubview:_tabVC.view];
    
    // Do any additional setup after loading the view.
}
- (IBAction)panGestureAction:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender translationInView:sender.view];
    CGRect rect = _tabVC.view.frame;
    if (sender.state == UIGestureRecognizerStateChanged) {
        if (_tabVC.view.frame.origin.x <= kMaxX) {
            _tabVC.view.transform = CGAffineTransformTranslate(_tabVC.view.transform, point.x, 0);
            [sender setTranslation:CGPointZero inView:sender.view];
        }
    }
    NSLog(@"%f", point.x);
    if (sender.state == UIGestureRecognizerStateEnded) {
        if (_tabVC.view.frame.origin.x <= kMaxX - 150) {
            _tabVC.view.transform = CGAffineTransformIdentity;
        }else{
            _tabVC.view.transform = CGAffineTransformTranslate(_tabVC.view.transform, kMaxX - _tabVC.view.frame.origin.x, 0);
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UserCenterCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserCenterCell" forIndexPath:indexPath];
    NSArray *imageArray = @[@"工作提醒", @"公司通知", @"系统通知", @"设置"];
    NSArray *titleArray = @[@"工作提醒", @"公司通知", @"系统通知", @"设置"];
    cell.photoView.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.titleLab.text = titleArray[indexPath.row];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
