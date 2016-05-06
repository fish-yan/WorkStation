//
//  WorkTimeHeaderView.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/6.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "WorkTimeHeaderView.h"

@implementation WorkTimeHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self loadNib];
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self loadNib];
    return self;
}

- (void)loadNib{
    UINib *nib = [UINib nibWithNibName:@"WorkTimeHeaderView" bundle:nil];
    UIView *headerView = [nib instantiateWithOwner:self options:nil].lastObject;
    headerView.frame = self.bounds;
    [self addSubview:headerView];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
