//
//  CommitCarCell.h
//  WorkStation
//
//  Created by 薛焱 on 16/5/6.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommitCarCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *carNumLab;
@property (weak, nonatomic) IBOutlet UILabel *carBrandLab;
@property (weak, nonatomic) IBOutlet UILabel *clientNameLab;
@property (weak, nonatomic) IBOutlet UILabel *statusLab;
@property (weak, nonatomic) IBOutlet UILabel *inStoreTimeLab;
@property (weak, nonatomic) IBOutlet UILabel *commitCarTimeLab;

@end
