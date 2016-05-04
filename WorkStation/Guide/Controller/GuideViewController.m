//
//  GuideViewController.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/3.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "GuideViewController.h"
#import "GuideCell.h"
#import "GuideHeaderView.h"

#define kMaxX 210
@interface GuideViewController ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation GuideViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
    _collectionView.contentInset = UIEdgeInsetsMake(500, 0, 0, 0);
    GuideHeaderView *headerView = [[NSBundle mainBundle]loadNibNamed:@"GuideHeaderView" owner:self options:nil].firstObject;
    headerView.frame = CGRectMake(0, -500, kScreenWidth, 500);
    [_collectionView.layer layoutIfNeeded];
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
    return 20;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    GuideCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"GuideCell" forIndexPath:indexPath];
    NSArray *imageArray = @[@"快速洗车", @"卡服务", @"洗车开单", @"服务开单", @"维修开单", @"增项开单", @"车辆检测", @"预定服务", @"客户领养", @"潜在客户", @"客户NPS", @"客户星级", @"项目查询", @"商品查询", @"消费记录", @"车辆信息", @"我的业绩", @"", @"", @""];
    NSArray *titleArray = @[@"快速洗车", @"卡服务", @"洗车开单", @"服务开单", @"维修开单", @"增项开单", @"车辆检测", @"预定服务", @"客户领养", @"潜在客户", @"客户NPS", @"客户星级", @"项目查询", @"商品查询", @"消费记录", @"车辆信息", @"我的业绩", @"", @"", @""];
    cell.itemImage.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.itemTitleLab.text = titleArray[indexPath.row];
    return cell;
}


#pragma mark - UICollectionViewDelegate





/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
