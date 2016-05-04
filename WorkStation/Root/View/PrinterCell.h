//
//  PrinterCell.h
//  WorkStation
//
//  Created by 薛焱 on 16/5/4.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrinterCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *selectImg;
@property (weak, nonatomic) IBOutlet UILabel *printerLab;
@property (weak, nonatomic) IBOutlet UISwitch *printSwitch;

@end
