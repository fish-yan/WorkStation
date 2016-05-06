//
//  WorkingViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/4.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "WorkingViewController.h"
#import "GuideCell.h"
#import "WorkingHeaderView.h"

#define kMaxX 210
#define kHeaderHeight 480
@interface WorkingViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) UIPanGestureRecognizer *pan;
@end

@implementation WorkingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    [self.navigationController.navigationBar setBackgroundImage:[[UIImage alloc] init] forBarMetrics:UIBarMetricsDefault];
    _collectionView.contentInset = UIEdgeInsetsMake(kHeaderHeight, 0, 0, 0);
    WorkingHeaderView *headerView = [[WorkingHeaderView alloc]initWithFrame:CGRectMake(0, -kHeaderHeight, kScreenWidth, kHeaderHeight)];
    headerView.firstStrokeEnd = 0.76;
    headerView.secondStrokeEnd = 0.44;
    [_collectionView addSubview:headerView];
    // Do any additional setup after loading the view.
}
- (IBAction)leftBtnAction:(UIButton *)sender {
    CATransform3D transform = CATransform3DIdentity;
    if (self.tabBarController.view.frame.origin.x == 0){
        transform = CATransform3DTranslate(transform, kMaxX, 0, 0);
        transform = CATransform3DScale(transform, 0.8, 0.8, 1);
        [UIView animateWithDuration:0.3 animations:^{
            self.tabBarController.view.layer.transform = transform;
        }];
    }else{
        [UIView animateWithDuration:0.3 animations:^{
            self.tabBarController.view.layer.transform = transform;
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((kScreenWidth - 5)/4, (kScreenWidth - 5)/4);
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuideCell" forIndexPath:indexPath];
    NSArray *imageArray = @[@"toumingchejian", @"cheliangxinxi", @"gongshibaobiao", @"jiaochejishilv", @"yicixingxiufulv", @"", @"", @""];
    NSArray *titleArray = @[@"透明车间", @"车辆信息", @"工时报表", @"交车及时率", @"一次性修复率", @"", @"", @""];
    cell.itemImage.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.itemTitleLab.text = titleArray[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    switch (indexPath.row) {
        case 0:
            
            break;
        case 1:
            
            break;
        case 2:
            [self performSegueWithIdentifier:@"WorkTime" sender:nil];
            break;
        case 3:
            [self performSegueWithIdentifier:@"CommitCar" sender:nil];
            break;
        case 4:
            [self performSegueWithIdentifier:@"RepairPercent" sender:nil];
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
