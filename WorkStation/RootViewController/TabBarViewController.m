//
//  TabBarViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/3.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "TabBarViewController.h"

@interface TabBarViewController ()

@end

@implementation TabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UITabBar appearance] setTintColor:UIColorFromRGB(0x2AB1F9)];
    
    UIStoryboard *guide = [UIStoryboard storyboardWithName:@"Guide" bundle:nil];
    UINavigationController *guideNVC = [guide instantiateInitialViewController];
    guideNVC.title = @"导购";
    guideNVC.tabBarItem.image = [UIImage imageNamed:@"导购"];
    
    self.viewControllers = @[guideNVC];
    
    // Do any additional setup after loading the view.
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
