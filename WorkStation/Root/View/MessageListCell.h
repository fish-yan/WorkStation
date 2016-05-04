//
//  MessageListCell.h
//  WorkStation
//
//  Created by 薛焱 on 16/5/4.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *titileLab;
@property (weak, nonatomic) IBOutlet UILabel *carNumLab;
@property (weak, nonatomic) IBOutlet UILabel *serviceStatusLab;
@property (weak, nonatomic) IBOutlet UILabel *applyDateLab;
@property (weak, nonatomic) IBOutlet UILabel *serviceTypeLab;

@end
