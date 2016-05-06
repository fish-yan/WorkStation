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

#define kMaxX 210

@interface RootViewController ()<UITableViewDelegate, UITableViewDataSource, UIGestureRecognizerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) TabBarViewController *tabVC;

@end

@implementation RootViewController

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    _tabVC.view.layer.transform = CATransform3DIdentity;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    
    _tabVC = [[TabBarViewController alloc]init];
    _tabVC.view.frame = self.view.bounds;
    [self addChildViewController:_tabVC];
    [self.view addSubview:_tabVC.view];
    UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panGestureAction:)];
    [_tabVC.view addGestureRecognizer:pan];

    // Do any additional setup after loading the view.
}

- (void)panGestureAction:(UIPanGestureRecognizer *)sender{
    CGPoint translation = [sender translationInView:sender.view];
    CATransform3D transform = CATransform3DIdentity;
    
    
    if (translation.x > 20){
        transform = CATransform3DTranslate(transform, kMaxX, 0, 0);
        transform = CATransform3DScale(transform, 0.8, 0.8, 1);
        
        [UIView animateWithDuration:0.3 animations:^{
            _tabVC.view.layer.transform = transform;
        }];
    }else if (translation.x < -20){
        
        [UIView animateWithDuration:0.3 animations:^{
            _tabVC.view.layer.transform = transform;
        }];
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
    UIView *selectedBackgroundView = [[UIView alloc]init];
    selectedBackgroundView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.2];
    cell.selectedBackgroundView = selectedBackgroundView;
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 58;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.row) {
        case 0:
            [self performSegueWithIdentifier:@"message" sender:nil];
            break;
        case 1:
            [self performSegueWithIdentifier:@"message" sender:nil];
            break;
        case 2:
            [self performSegueWithIdentifier:@"message" sender:nil];
            break;
        case 3:
            [self performSegueWithIdentifier:@"setting" sender:nil];
            break;
        default:
            break;
    }
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    if (self.navigationController.viewControllers.count == 1) {
        return NO;
    }
    return YES;
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
