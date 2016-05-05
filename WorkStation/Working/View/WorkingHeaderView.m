//
//  WorkingHeaderView.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/5.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "WorkingHeaderView.h"

@interface WorkingHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *firstCircleView;
@property (weak, nonatomic) IBOutlet UIView *secondCircleView;
@property (weak, nonatomic) IBOutlet UILabel *firstCirclePercent;
@property (weak, nonatomic) IBOutlet UILabel *secondCirclePercent;

@end

@implementation WorkingHeaderView

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    [self loadNib];
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder{
    self = [super initWithCoder:aDecoder];
    [self loadNib];
    return self;
}

- (void)setFirstStrokeEnd:(CGFloat)firstStrokeEnd{
    _firstStrokeEnd = firstStrokeEnd;
    [UIView animateWithDuration:0.3 animations:^{
        CAShapeLayer *shapeLayer = (CAShapeLayer *)_firstCircleView.layer.sublayers.lastObject;
        shapeLayer.strokeEnd = _firstStrokeEnd;
    }];
    _firstCirclePercent.text = [NSString stringWithFormat:@"%g%%", _firstStrokeEnd * 100];
}

- (void)setSecondStrokeEnd:(CGFloat)secondStrokeEnd{
    _secondStrokeEnd = secondStrokeEnd;
    [UIView animateWithDuration:0.3 animations:^{
        CAShapeLayer *shapeLayer = (CAShapeLayer *)_secondCircleView.layer.sublayers.lastObject;
        shapeLayer.strokeEnd = _secondStrokeEnd;
    }];
    _secondCirclePercent.text = [NSString stringWithFormat:@"%g%%", _secondStrokeEnd * 100];
}

- (void)loadNib{
    NSBundle *bundle = [NSBundle bundleForClass:self.class];
    UINib *nib = [UINib nibWithNibName:@"WorkingHeaderView" bundle:bundle];
    UIView *headerView = [nib instantiateWithOwner:self options:nil].firstObject;
    headerView.frame = self.bounds;
    [self addSubview:headerView];
    
    [self firstCircle];
    [self secondCircle];
    
}


- (void)firstCircle{
    
    [_firstCircleView.layer addSublayer:[self creatShapeLayerWithStrokeColor:[UIColor whiteColor] StrokeEnd:1.0]];
    [_firstCircleView.layer addSublayer:[self creatShapeLayerWithStrokeColor:UIColorFromRGB(0x57f114) StrokeEnd:0.0]];
}

- (void)secondCircle{
    [_secondCircleView.layer addSublayer:[self creatShapeLayerWithStrokeColor:[UIColor whiteColor] StrokeEnd:1.0]];
    [_secondCircleView.layer addSublayer:[self creatShapeLayerWithStrokeColor:UIColorFromRGB(0x57f114) StrokeEnd:0.5]];
}



- (CAShapeLayer *)creatShapeLayerWithStrokeColor:(UIColor *)strokeColor StrokeEnd:(CGFloat)strokeEnd{
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.frame = _firstCircleView.bounds;
    CGFloat width = (kScreenWidth - 160) / 4;
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(width, width) radius:width startAngle:-M_PI_2 endAngle:M_PI + M_PI_2 clockwise:YES];
    shapeLayer.path = path.CGPath;
    shapeLayer.lineWidth = 2;
    shapeLayer.strokeColor = strokeColor.CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.strokeStart = 0.0;
    shapeLayer.strokeEnd = strokeEnd;
    return shapeLayer;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
