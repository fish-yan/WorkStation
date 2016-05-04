//
//  GuideHeaderView.m
//  WorkStation
//
//  Created by 薛焱 on 16/5/4.
//  Copyright © 2016年 薛焱. All rights reserved.
//

#import "GuideHeaderView.h"

@interface GuideHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *firstCircleView;
@property (weak, nonatomic) IBOutlet UIView *secondCircleView;


@end

@implementation GuideHeaderView

- (void)awakeFromNib{
    [self firstCircle];
    [self secondCircle];
    
}

- (void)firstCircle{
    
    [_firstCircleView.layer addSublayer:[self creatShapeLayerWithStrokeColor:[UIColor whiteColor] StrokeEnd:1.0]];
    [_firstCircleView.layer addSublayer:[self creatShapeLayerWithStrokeColor:[UIColor orangeColor] StrokeEnd:0.5]];
}

- (void)secondCircle{
    [_secondCircleView.layer addSublayer:[self creatShapeLayerWithStrokeColor:[UIColor whiteColor] StrokeEnd:1.0]];
    [_secondCircleView.layer addSublayer:[self creatShapeLayerWithStrokeColor:[UIColor orangeColor] StrokeEnd:0.5]];
}



- (CAShapeLayer *)creatShapeLayerWithStrokeColor:(UIColor *)strokeColor StrokeEnd:(CGFloat)strokeEnd{
    CAShapeLayer *shapeLayer = [[CAShapeLayer alloc]init];
    shapeLayer.frame = _firstCircleView.bounds;
    CGFloat width = (kScreenWidth - 140) / 4;
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
