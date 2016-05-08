//
//  ScanViewController.h
//  WorkStation
//
//  Created by 薛焱 on 16/5/6.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

@interface ScanViewController : UIViewController

@property (copy, nonatomic) void(^getLince)(NSString *lince);

@end
